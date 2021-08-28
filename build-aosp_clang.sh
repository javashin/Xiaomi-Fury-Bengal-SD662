#!/bin/bash

clear
umount /OUT
rm -rf /OUT
export ARCH=arm64
export SUBARCH=arm
mkdir /OUT
mount /OUT

export LD_LIBRARY_PATH="/cross-tc/clang/lib64:/crossdev/arm64/lib:/crossdev/arm32/lib:$LD_LIBRARY_PATH"

export PATH="/cross-tc/clang/bin:/crossdev/arm64/bin:/crossdev/arm32/bin:$PATH"

export CROSS_COMPILE="/crossdev/arm64/bin/aarch64-unknown-linux-gnu-"

export CROSS_COMPILE_COMPAT="/crossdev/arm32/bin/armv8-unknown-linux-gnueabi-"

  make -j$(nproc --all) O=/OUT ARCH=arm64 \
  CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \
  OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
  HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld LLVM_IAS=1 LLVM=1 \
  vendor/fury_defconfig oldconfig prepare nconfig Image.gz

cp /OUT/arch/arm64/boot/Image.gz .
ls -lash /OUT/arch/arm64/boot/Image.gz
ls -lash ./Image.gz


