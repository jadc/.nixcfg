OPERATION="$2"
SUB_OPERATION="$3"

# Drain stdin unconditionally, even on the paths that
# exit early below, so libvirt never writes the domain
# XML into a script that has already gone away.
XML=$(cat)

# Only the pre-start gate matters; libvirt's
# managed='yes' does the actual driver handover.
[ "$OPERATION" = "prepare" ] && [ "$SUB_OPERATION" = "begin" ] || exit 0

case "$XML" in
    *"<hostdev"*) ;;
    *) exit 0 ;;
esac

# True when this guest's XML passes through the given
# host PCI address.
xml_has_addr() {
    local dom=${1%%:*} rest=${1#*:}
    local bus=${rest%%:*} slotfn=${rest#*:}
    local slot=${slotfn%.*} fn=${slotfn#*.}
    case "$XML" in
        *"<address domain='0x$dom' bus='0x$bus' slot='0x$slot' function='0x$fn'"*) return 0 ;;
    esac
    return 1
}

# Resolve every host path a configured passthrough
# device could be held open on.
targets=()
add_target() {
    local resolved
    resolved=$(readlink -f "$1" 2>/dev/null) || return 0
    [ -n "$resolved" ] && [ -e "$resolved" ] || return 0
    targets+=("$resolved")
}

# The token substitutes to one word per address.
# shellcheck disable=SC2043
for ADDR in @PASSTHROUGH@; do
    # Only gate on devices this guest actually uses.
    xml_has_addr "$ADDR" || continue

    # by-path, not cardN: DRM minors are reallocated
    # every time the device is detached and returned.
    add_target "/dev/dri/by-path/pci-$ADDR-card"
    add_target "/dev/dri/by-path/pci-$ADDR-render"

    # CUDA and NVENC clients open /dev/nvidia<minor>
    # rather than a DRM node. /dev/nvidiactl is
    # deliberately not checked: anything that merely
    # enumerates GPUs opens it.
    INFO="/proc/driver/nvidia/gpus/$ADDR/information"
    if [ -r "$INFO" ]; then
        MINOR=$(sed -n 's/^Device Minor:[[:space:]]*//p' "$INFO")
        [ -n "$MINOR" ] && add_target "/dev/nvidia$MINOR"
    fi
done

BUSY=""
if [ "${#targets[@]}" -gt 0 ]; then
    SEEN=""
    # Single pass over every fd on the system. `-ef`
    # is a shell builtin that compares device+inode,
    # so this stays fast (no fork/readlink per fd)
    # even with thousands of fds open host-wide.
    for fd in /proc/[0-9]*/fd/*; do
        for target in "${targets[@]}"; do
            [ "$fd" -ef "$target" ] || continue
            pid=${fd#/proc/}
            pid=${pid%%/*}
            # $pid is numeric (from /proc/[0-9]*), so
            # it is safe to embed unquoted in a case
            # pattern -- unlike $comm, it can't carry
            # glob metacharacters that would corrupt
            # the dedup match.
            case " $SEEN " in
                *" $pid "*) ;;
                *)
                    SEEN="$SEEN $pid"
                    comm=$(cat "/proc/$pid/comm" 2>/dev/null) || comm="?"
                    BUSY="$BUSY $comm($pid)"
                    ;;
            esac
            break
        done
    done
fi

if [ -n "$BUSY" ]; then
    echo "Refusing to start $1: passthrough device still in use by:$BUSY" >&2
    echo "Close these on the host and try again." >&2
    exit 1
fi

exit 0
