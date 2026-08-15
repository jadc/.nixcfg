if [ $# -eq 0 ]; then
    echo "usage: gamerun <command> [args...]" >&2
    exit 64
fi

# Read the ids off whatever is currently bound to the nvidia driver.
gpu=""
for dev in /sys/bus/pci/drivers/nvidia/*:*:*.*; do
    [ -r "$dev/vendor" ] || continue
    vendor=$(cat "$dev/vendor")
    device=$(cat "$dev/device")
    gpu="${vendor#0x}:${device#0x}"
    break
done

# Offload rendering if found
if [ -n "$gpu" ]; then
    # Render on the NVIDIA card.
    export __NV_PRIME_RENDER_OFFLOAD=1

    # GL goes through GLVND's vendor selection.
    export __GLX_VENDOR_LIBRARY_NAME=nvidia

    # Vulkan needs device promoted to index 0.
    export MESA_VK_DEVICE_SELECT="$gpu"
fi

exec gamemoderun gamescope -- "$@"
