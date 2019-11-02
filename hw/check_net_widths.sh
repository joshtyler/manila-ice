
for NET in "+1V2" "+3V3" "/5V" "/ETHERNET/REG_OUT" "/ETHERNET/VDD" "/FPGA/GNDPLL0" "/FPGA/GNDPLL1" "/FPGA/VCCPLL0" "/FPGA/VCCPLL1" "/VBUS" "GND"; do
    echo "Checking $NET"
    python ~/tmp/kicad-scripts/CheckTrackWidth.py manila_ice.kicad_pcb $NET 0.3
done