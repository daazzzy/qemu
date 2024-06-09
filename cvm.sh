#!/bin/bash

while getopts f:i:s:n: flag
do
    case "${flag}" in
        f) iso=${OPTARG};;
        i) image=${OPTARG};;
        s) size=${OPTARG};;
        n) name=${OPTARG};;
    esac
done

sname=${name}.sh
iname=${image}.img
fsize=${size}G

iso=$(realpath ${iso})

qemu-img create -f qcow2 ~/qemu/imgs/$iname $fsize

echo "#!/bin/bash
qemu-system-x86_64 -enable-kvm -cdrom ${iso} -boot menu=on -drive file=${HOME}/qemu/imgs/${iname},format=qcow2 -m 8G -cpu host -smp 3 -vga virtio -display sdl,gl=on" > ${sname}

chmod +x $sname

./$sname
