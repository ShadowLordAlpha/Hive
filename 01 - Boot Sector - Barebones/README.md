# Hive

## Goal

Create a "program" that a BIOS can use as a boot image/disk

## Requierments

For this section there are two programs you will need. You can use others or replacements but I am on a windows computer using these so that is what my tutorials will be following.

* [QEMU](https://www.qemu.org/download/) - Emulation program. We will use this so that we don't brick one of our own computers by accident. Also it is much faster than using a physical computer
* [NASM](https://www.nasm.us/) - This is used to assemble the assembly to machine code from our slightly more human readable set of instructions we are giving the computer.
stuff

## Lets get coding

For this one we are going to make a bootloader that is essentually as simple as we can possibly make it. Most people know of the 'hello world!' programs but there are even simpler ones. In assembly this is a program that just takes up space.

We still need to do some parts in order to get it set up and ready for the next sessions but its extreamly simple. The whole thing is 3 lines of code. Lets go over each line for now.

```asm
[BITS 16]

TIMES 510 - ($ - $$) db 0
DW 0xAA55

```
You can, of course, look at the asm file in the src folder.

```asm
[BITS 16]
```

This line tells NASM that the code is in 16 bit mode. This is because computers generally boot into 16 bit most instead of the 32 or 64 bit mode that your computer is most likely running in now. There are actually other names for these modes but its not really that important to know them. Just know that because the computer is in 16 bit mode we can only use 16 bit instructions and we need to tell NASM that it is only able to use those instructions.

```asm
TIMES 510 - ($ - $$) db 0
```

A boot sector is always 512 bytes long. This section here will fill up 510 of that with 0 excluding any that we use for code later on. This does limit how much can be in the initial part of the boot loader but you probably can guess that an OS is normally MUCH larger than what can fit in this size limit. You can probably also see that we are missing 2 bytes. If the length is 512 why are we only using 510 of it? well thats because of the next part

```asm
DW 0xAA55
```

The BIOS is a peice of code that ships with your computer but how does it know what is a boot program what is just random parts of code for the OS? Well these two bytes here actually make up the boot signature which allow it to be recognized properly as the bootloader.

With that all of our code for our barebones bootloader is done! Now we just need to build it. This is done using NASM and the below command. Its a decently basic part of code and should be easy enough to understand if you have compiled anything before but the only real things that you need to do is make sure that the nasm command can be used (either add it to your path or run the command in the folder with the nasm.exe is) boot.asm is the file and the only part you many need to change. This is a path to and including the file we just wrote.

```
nasm -f bin boot.asm -o boot.bin
```

After running the command you should be able to find a new file called boot.bin. We can use this file QEMU to start our own loader now! As before simply direct the boot.bin part of the below command to where your boot.bin file is and run the command! you may need to add the qemu program to your path as well in order to get this to function properly.

```
qemu-system-x86_64 boot.bin
```

If everything worked correctly you should end up with a screen like this.

![bootloader](https://github.com/ShadowLordAlpha/Hive/tree/master/01%20-%20Boot%20Sector%20-%20Barebones/images/bootloader.png What it should look like")

If so congragulations! you have created one of the simplest bootloaders there is!