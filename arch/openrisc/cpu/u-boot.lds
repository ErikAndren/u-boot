#include <config.h>
OUTPUT_ARCH(or1k)
__DYNAMIC  =  0;

MEMORY
{
	vectors : ORIGIN = CONFIG_SYS_VECTORS_BASE,
        	  LENGTH = CONFIG_SYS_VECTORS_LEN
	ram	: ORIGIN = CONFIG_SYS_MONITOR_BASE,
		  LENGTH = CONFIG_SYS_MONITOR_LEN
}

SECTIONS
{
	.vectors :
	{
		*(.vectors)
	} > vectors

	__start = .;
	.text : AT (__start) {
		_stext = .;
		*(.text)
		_etext = .;
		*(.lit)
		*(.shdata)
		_endtext = .;
	}  > ram


	 . = ALIGN(4);
	 .u_boot_list : {
		KEEP(*(SORT(.u_boot_list*)));
	 } > ram

	.rodata : {
		*(.rodata);
		*(.rodata.*)
	} > ram

	.shbss :
	{
		*(.shbss)
	} > ram

	.talias :
	{
	}  > ram

	.data : {
		sdata = .;
		_sdata = .;
		*(.data)
		edata = .;
		_edata = .;
	} > ram

	.bss :
	{
		_bss_start = .;
		*(.bss)
		*(COMMON)
		_bss_end = .;
	} > ram
	__end = .;

	/* No stack specification - done manually */

	.stab  0 (NOLOAD) :
	{
		[ .stab ]
	}

	.stabstr  0 (NOLOAD) :
	{
		[ .stabstr ]
	}
}
