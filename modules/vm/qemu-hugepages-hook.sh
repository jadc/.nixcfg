OPERATION="$2"
SUB_OPERATION="$3"
# Substituted value is MB; the kernel counts the pool in 2MB pages.
HUGEPAGES=@HUGEPAGES@
HUGEPAGES=$((HUGEPAGES / 2))

XML=$(cat)
case "$XML" in
    *"<hugepages"*) ;;
    *) exit 0 ;;
esac

if [ "$OPERATION" = "prepare" ] && [ "$SUB_OPERATION" = "begin" ]; then
    allocate() {
        echo 1 > /proc/sys/vm/compact_memory
        echo "$HUGEPAGES" > /proc/sys/vm/nr_hugepages
        ALLOCATED=$(cat /proc/sys/vm/nr_hugepages)
        [ "$ALLOCATED" -ge "$HUGEPAGES" ]
    }

    # Compaction alone usually suffices; sync + drop_caches evicts the
    # entire host page cache, so pay that only when the first attempt
    # falls short.
    if ! allocate; then
        sync
        echo 3 > /proc/sys/vm/drop_caches
        if ! allocate; then
            echo "Failed to allocate hugepages: got $ALLOCATED, wanted $HUGEPAGES" >&2
            echo 0 > /proc/sys/vm/nr_hugepages
            exit 1
        fi
    fi
elif [ "$OPERATION" = "release" ] && [ "$SUB_OPERATION" = "end" ]; then
    echo 0 > /proc/sys/vm/nr_hugepages
fi
