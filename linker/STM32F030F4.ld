/*

    Minimalistic linker script for STM32 microcontrollers.

    Please update memory size and stack location.

    Author: Krzysztof Dziuba krzysztof (at) meeqo.net
    License: LGPL-3.0


*/

ENTRY(Reset_Handler)

_estack = 0x20001000; /* end of 4K RAM */

MEMORY
{
    rom (rx)  : ORIGIN = 0x08000000, LENGTH = 16K
    ram (rwx) : ORIGIN = 0x20000000, LENGTH = 4K
}

SECTIONS
{
    .  = 0x0;         /* From 0x00000000 */
    .text :
    {
        KEEP(*(.isr_vector))    /* Vector table */
        . = ALIGN(4);
        *(.text)      /* Program code */
        *(.text*)      /* Program code */
    } >rom

    .rodata :
    {
        . = ALIGN(4);
        *(.rodata)    /* Read only data */
        *(.rodata*)    /* Read only data */
        . = ALIGN(4);
    } >rom

    _sidata = LOADADDR(.data);

    .data :
    {
        . = ALIGN(4);
        _sdata = .;
        *(.data)      /* Data memory */
        *(.data*)
        . = ALIGN(4);
        _edata = .;
    } >ram AT >rom

    . = ALIGN(4);

    .bss :
    {
        _sbss = .;
        *(.bss)       /* Zero-filled run time allocate data memory */
        *(.bss*)
        . = ALIGN(4);
        _ebss = .;
    } >ram
}
