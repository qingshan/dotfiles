# devbox

devbox is based on Ubuntu 24.04 LTS, deployed as a libvirt VM via cloud-init.

## Install

```shell
make
```

### Creating VMs with other names

The same recipe can create differently named/sized VMs (e.g. `testbox` on a
GPU host like testlab) by overriding variables — each name gets its own
image dir and static IP, so multiple VMs can coexist:

```shell
make NAME=testbox MEMORY=16384 VCPUS=16 DISK_SIZE=40 IP=192.168.122.101
```

## GPU access

These VMs do **not** get the host GPU passed through. Giving a VM direct
access to a physical GPU (full VFIO passthrough, or NVIDIA vGPU/mdev) relies
on the kernel VFIO framework, which requires hardware IOMMU (Intel VT-d /
AMD-Vi) to be enabled on the host to safely isolate DMA. Where IOMMU can't
be enabled (e.g. testlab), there is no supported, safe way to pass the GPU
into the VM — VFIO's "unsafe no-IOMMU" mode exists but disables DMA
protection entirely, so it's intentionally not used here.

Instead, run GPU workloads as containers directly on the GPU host (where
`nvidia-container-toolkit` + `docker --gpus` already work there), and drive
them from the VM over a Docker SSH context, same as `deploy/README.md`:

```shell
docker context create testlab --docker "host=ssh://qingshan@testlab"
docker context use testlab
docker run --rm --gpus all nvidia/cuda:12.5.0-base-ubuntu24.04 nvidia-smi
```

This runs the container on the host's docker engine (and its real GPU)
while being controlled from the VM, without needing the GPU device inside
the VM itself.
