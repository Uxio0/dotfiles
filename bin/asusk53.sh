#!/bin/sh
# Power control for Asus K53/A53 Optimus
# by Pete Eberlein(Original Asus 1215n)
if [ $(id -u) -ne 0 ]; then
	echo 'Error: Ejecútalo como root'
	exit
fi

if ! lsmod | grep -q acpi_call; then
    echo "Error: acpi_call module not loaded"
    exit
fi

acpi_call () {
    echo "$*" > /proc/acpi/call
    cat /proc/acpi/call
}


case "$1" in
off)
    echo _DSM $(acpi_call "\_SB.PCI0.PEGR.GFX0._DSM" \
	"{0xF8,0xD8,0x86,0xA4,0xDA,0x0B,0x1B,0x47," \
	 "0xA7,0x2B,0x60,0x42,0xA6,0xB5,0xBE,0xE0}" \
	 "0x100 0x1A {0x1,0x0,0x0,0x3}")
	# ok to turn off: Buffer {0x59 0x0 0x0 0x11}
	# is already off: Buffer {0x41 0x0 0x0 0x11}
    echo _PS3 $(acpi_call "\_SB.PCI0.PEGR.GFX0._PS3")
;;
on)
    echo _PS0 $(acpi_call "\_SB.PCI0.PEGR.GFX0._PS0")
;;
*)
    echo "Usage: $0 [on|off]"
esac


#echo P3MO $(acpi_call "\_SB.PCI0.PEGR.GFX0.P3MO")
echo DGPS $(acpi_call "\_SB.PCI0.PEGR.GFX0.DGPS")
PSC=$(acpi_call "\_SB.PCI0.PEGR.GFX0._PSC")
echo _PSC ${PSC}
case "$PSC" in
0x0)
    PSC="on"
;;
0x3)
    PSC="off"
;;
esac
echo "Asus K53SV Optimus appears to be ${PSC}"
