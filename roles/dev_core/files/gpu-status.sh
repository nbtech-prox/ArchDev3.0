#!/bin/bash

echo "=========================================="
echo "ArchDev GPU Status"
echo "=========================================="
echo ""
echo "WLR_DRM_DEVICES=${WLR_DRM_DEVICES:-<não definido>}"
echo "AQ_DRM_DEVICES=${AQ_DRM_DEVICES:-<não definido>}"
echo "DRI_PRIME=${DRI_PRIME:-<não definido>}"
echo "LIBVA_DRIVER_NAME=${LIBVA_DRIVER_NAME:-<não definido>}"
echo "VDPAU_DRIVER=${VDPAU_DRIVER:-<não definido>}"
echo ""
echo "Dispositivos DRM disponíveis:"
ls -l /dev/dri/by-path 2>/dev/null || true
echo ""
echo "GPUs detetadas pelo sistema:"
lspci | grep -Ei 'vga|3d|display' || true
echo ""
