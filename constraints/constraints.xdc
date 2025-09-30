# Main TI TSW EVM Board constraint file for vivado
#
# BRH 09/2025

# define main clock 

# CLK_ADC_REF
# set_property PACKAGE_PIN G37 [get_ports CLK125_P]
# set_property PACKAGE_PIN F37 [get_ports CLK125_N]
# set_property IOSTANDARD LVDS [get_ports {CLK125_P CLK125_N}]
# create_clock -name sys_clk -period 1.25 [get_ports CLK125_P]

# use CLK_ONBOARD_125_P onboard TSW 125 mhz clock
set_property PACKAGE_PIN H36 [get_ports CLK_ONBOARD_125_P]
set_property PACKAGE_PIN G36 [get_ports CLK_ONBOARD_125_N]
set_property IOSTANDARD LVDS [get_ports {CLK_ONBOARD_125_P CLK_ONBOARD_125_N}]
create_clock -name sys_clk -period 8 [get_ports CLK_ONBOARD_125_N]

# ADC Channels clocks
set_property PACKAGE_PIN AP36 [get_ports RX_CLK0_P]
set_property PACKAGE_PIN AR36 [get_ports RX_CLK0_N]
set_property IOSTANDARD LVDS [get_ports {RX_CLK0_P RX_CLK0_N}]
create_clock -name RX_CLK0 -period 2.5 [get_ports RX_CLK0_P]

set_property PACKAGE_PIN AK23 [get_ports RX_CLK1_P]
set_property PACKAGE_PIN AL23 [get_ports RX_CLK1_N]
set_property IOSTANDARD LVDS [get_ports {RX_CLK1_P RX_CLK1_N}]
create_clock -name RX_CLK1 -period 2.5 [get_ports RX_CLK1_P]

set_property PACKAGE_PIN AL30 [get_ports RX_CLK2_P]
set_property PACKAGE_PIN AM30 [get_ports RX_CLK2_N]
set_property IOSTANDARD LVDS [get_ports {RX_CLK2_P RX_CLK2_N}]
create_clock -name RX_CLK2 -period 2.5 [get_ports RX_CLK2_P]

set_property PACKAGE_PIN AK27 [get_ports RX_CLK3_P]
set_property PACKAGE_PIN AK28 [get_ports RX_CLK3_N]
set_property IOSTANDARD LVDS [get_ports {RX_CLK3_P RX_CLK2_N}]
create_clock -name RX_CLK3 -period 2.5 [get_ports RX_CLK3_P]

# LRX0
set_property PACKAGE_PIN AM36 [get_ports LRX0_P]
set_property PACKAGE_PIN AM37 [get_ports LRX0_N]
set_property IOSTANDARD LVDS [get_ports {LRX0_P LRX0_N}]

# LRX1
set_property PACKAGE_PIN AR38 [get_ports LRX1_P]
set_property PACKAGE_PIN AT38 [get_ports LRX1_N]
set_property IOSTANDARD LVDS [get_ports {LRX1_P LRX1_N}]

# LRX2
set_property PACKAGE_PIN AN38 [get_ports LRX2_P]
set_property PACKAGE_PIN AP38 [get_ports LRX2_N]
set_property IOSTANDARD LVDS [get_ports {LRX2_P LRX2_N}]

# LRX3
set_property PACKAGE_PIN AN39 [get_ports LRX3_P]
set_property PACKAGE_PIN AP39 [get_ports LRX3_N]
set_property IOSTANDARD LVDS [get_ports {LRX3_P LRX3_N}]

# LRX4
set_property PACKAGE_PIN AR37 [get_ports LRX4_P]
set_property PACKAGE_PIN AT37 [get_ports LRX4_N]
set_property IOSTANDARD LVDS [get_ports {LRX4_P LRX4_N}]

# LRX5
set_property PACKAGE_PIN AV38 [get_ports LRX5_P]
set_property PACKAGE_PIN AV39 [get_ports LRX5_N]
set_property IOSTANDARD LVDS [get_ports {LRX5_P LRX5_N}]

# LRX6
set_property PACKAGE_PIN AU37 [get_ports LRX6_P]
set_property PACKAGE_PIN AV37 [get_ports LRX6_N]
set_property IOSTANDARD LVDS [get_ports {LRX6_P LRX6_N}]

# LRX7
set_property PACKAGE_PIN AW33 [get_ports LRX7_P]
set_property PACKAGE_PIN AW34 [get_ports LRX7_N]
set_property IOSTANDARD LVDS [get_ports {LRX7_P LRX7_N}]

# LRX8
set_property PACKAGE_PIN AT35 [get_ports LRX8_P]
set_property PACKAGE_PIN AU35 [get_ports LRX8_N]
set_property IOSTANDARD LVDS [get_ports {LRX8_P LRX8_N}]

# LRX9
set_property PACKAGE_PIN AM34 [get_ports LRX9_P]
set_property PACKAGE_PIN AM35 [get_ports LRX9_N]
set_property IOSTANDARD LVDS [get_ports {LRX9_P LRX9_N}]

# LRX10
set_property PACKAGE_PIN AU36 [get_ports LRX10_P]
set_property PACKAGE_PIN AV36 [get_ports LRX10_N]
set_property IOSTANDARD LVDS [get_ports {LRX10_P LRX10_N}]

# LRX11
set_property PACKAGE_PIN AT39 [get_ports LRX11_P]
set_property PACKAGE_PIN AU39 [get_ports LRX11_N]
set_property IOSTANDARD LVDS [get_ports {LRX11_P LRX11_N}]

# LRX12
set_property PACKAGE_PIN AN24 [get_ports LRX12_P]
set_property PACKAGE_PIN AP24 [get_ports LRX12_N]
set_property IOSTANDARD LVDS [get_ports {LRX12_P LRX12_N}]

# LRX13
set_property PACKAGE_PIN AH22 [get_ports LRX13_P]
set_property PACKAGE_PIN AH23 [get_ports LRX13_N]
set_property IOSTANDARD LVDS [get_ports {LRX13_P LRX13_N}]

# LRX14
set_property PACKAGE_PIN AJ20 [get_ports LRX14_P]
set_property PACKAGE_PIN AJ21 [get_ports LRX14_N]
set_property IOSTANDARD LVDS [get_ports {LRX14_P LRX14_N}]

# LRX15
set_property PACKAGE_PIN AK20 [get_ports LRX15_P]
set_property PACKAGE_PIN AK21 [get_ports LRX15_N]
set_property IOSTANDARD LVDS [get_ports {LRX15_P LRX15_N}]

# LRX16
set_property PACKAGE_PIN AL20 [get_ports LRX16_P]
set_property PACKAGE_PIN AM20 [get_ports LRX16_N]
set_property IOSTANDARD LVDS [get_ports {LRX16_P LRX16_N}]

# LRX17
set_property PACKAGE_PIN AM22 [get_ports LRX17_P]
set_property PACKAGE_PIN AN22 [get_ports LRX17_N]
set_property IOSTANDARD LVDS [get_ports {LRX17_P LRX17_N}]

# LRX18
set_property PACKAGE_PIN AV24 [get_ports LRX18_P]
set_property PACKAGE_PIN AW24 [get_ports LRX18_N]
set_property IOSTANDARD LVDS [get_ports {LRX18_P LRX18_N}]

# LRX19
set_property PACKAGE_PIN AN23 [get_ports LRX19_P]
set_property PACKAGE_PIN AP23 [get_ports LRX19_N]
set_property IOSTANDARD LVDS [get_ports {LRX19_P LRX19_N}]

# LRX20
set_property PACKAGE_PIN AR22 [get_ports LRX20_P]
set_property PACKAGE_PIN AR23 [get_ports LRX20_N]
set_property IOSTANDARD LVDS [get_ports {LRX20_P LRX20_N}]

# LRX21
set_property PACKAGE_PIN AM21 [get_ports LRX21_P]
set_property PACKAGE_PIN AN21 [get_ports LRX21_N]
set_property IOSTANDARD LVDS [get_ports {LRX21_P LRX21_N}]

# LRX22
set_property PACKAGE_PIN AV21 [get_ports LRX22_P]
set_property PACKAGE_PIN AW21 [get_ports LRX22_N]
set_property IOSTANDARD LVDS [get_ports {LRX22_P LRX22_N}]

# LRX23
set_property PACKAGE_PIN AP21 [get_ports LRX23_P]
set_property PACKAGE_PIN AR21 [get_ports LRX23_N]
set_property IOSTANDARD LVDS [get_ports {LRX23_P LRX23_N}]

# LRX24
set_property PACKAGE_PIN AN33 [get_ports LRX24_P]
set_property PACKAGE_PIN AP33 [get_ports LRX24_N]
set_property IOSTANDARD LVDS [get_ports {LRX24_P LRX24_N}]

# LRX25
set_property PACKAGE_PIN AJ33 [get_ports LRX25_P]
set_property PACKAGE_PIN AK33 [get_ports LRX25_N]
set_property IOSTANDARD LVDS [get_ports {LRX25_P LRX25_N}]

# LRX26
set_property PACKAGE_PIN AK32 [get_ports LRX26_P]
set_property PACKAGE_PIN AL32 [get_ports LRX26_N]
set_property IOSTANDARD LVDS [get_ports {LRX26_P LRX26_N}]

# LRX27
set_property PACKAGE_PIN AJ31 [get_ports LRX27_P]
set_property PACKAGE_PIN AK31 [get_ports LRX27_N]
set_property IOSTANDARD LVDS [get_ports {LRX27_P LRX27_N}]

# LRX28
set_property PACKAGE_PIN AJ30 [get_ports LRX28_P]
set_property PACKAGE_PIN AK30 [get_ports LRX28_N]
set_property IOSTANDARD LVDS [get_ports {LRX28_P LRX28_N}]

# LRX29
set_property PACKAGE_PIN AU32 [get_ports LRX29_P]
set_property PACKAGE_PIN AV32 [get_ports LRX29_N]
set_property IOSTANDARD LVDS [get_ports {LRX29_P LRX29_N}]

# LRX30
set_property PACKAGE_PIN AR31 [get_ports LRX30_P]
set_property PACKAGE_PIN AR32 [get_ports LRX30_N]
set_property IOSTANDARD LVDS [get_ports {LRX30_P LRX30_N}]

# LRX31
set_property PACKAGE_PIN AP30 [get_ports LRX31_P]
set_property PACKAGE_PIN AP31 [get_ports LRX31_N]
set_property IOSTANDARD LVDS [get_ports {LRX31_P LRX31_N}]

# LRX32
set_property PACKAGE_PIN AM32 [get_ports LRX32_P]
set_property PACKAGE_PIN AN32 [get_ports LRX32_N]
set_property IOSTANDARD LVDS [get_ports {LRX32_P LRX32_N}]

# LRX33
set_property PACKAGE_PIN AT29 [get_ports LRX33_P]
set_property PACKAGE_PIN AT30 [get_ports LRX33_N]
set_property IOSTANDARD LVDS [get_ports {LRX33_P LRX33_N}]

# LRX34
set_property PACKAGE_PIN AM31 [get_ports LRX34_P]
set_property PACKAGE_PIN AN31 [get_ports LRX34_N]
set_property IOSTANDARD LVDS [get_ports {LRX34_P LRX34_N}]

# LRX35
set_property PACKAGE_PIN AV29 [get_ports LRX35_P]
set_property PACKAGE_PIN AW29 [get_ports LRX35_N]
set_property IOSTANDARD LVDS [get_ports {LRX35_P LRX35_N}]

# LRX36
set_property PACKAGE_PIN AR26 [get_ports LRX36_P]
set_property PACKAGE_PIN AR27 [get_ports LRX36_N]
set_property IOSTANDARD LVDS [get_ports {LRX36_P LRX36_N}]

# LRX37
set_property PACKAGE_PIN AH26 [get_ports LRX37_P]
set_property PACKAGE_PIN AJ26 [get_ports LRX37_N]
set_property IOSTANDARD LVDS [get_ports {LRX37_P LRX37_N}]

# LRX38
set_property PACKAGE_PIN AL24 [get_ports LRX38_P]
set_property PACKAGE_PIN AL25 [get_ports LRX38_N]
set_property IOSTANDARD LVDS [get_ports {LRX38_P LRX38_N}]

# LRX39
set_property PACKAGE_PIN AJ25 [get_ports LRX39_P]
set_property PACKAGE_PIN AK25 [get_ports LRX39_N]
set_property IOSTANDARD LVDS [get_ports {LRX39_P LRX39_N}]

# LRX40
set_property PACKAGE_PIN AH24 [get_ports LRX40_P]
set_property PACKAGE_PIN AJ24 [get_ports LRX40_N]
set_property IOSTANDARD LVDS [get_ports {LRX40_P LRX40_N}]

# LRX41
set_property PACKAGE_PIN AV28 [get_ports LRX41_P]
set_property PACKAGE_PIN AW28 [get_ports LRX41_N]
set_property IOSTANDARD LVDS [get_ports {LRX41_P LRX41_N}]

# LRX42
set_property PACKAGE_PIN AV26 [get_ports LRX42_P]
set_property PACKAGE_PIN AV27 [get_ports LRX42_N]
set_property IOSTANDARD LVDS [get_ports {LRX42_P LRX42_N}]

# LRX43
set_property PACKAGE_PIN AW25 [get_ports LRX43_P]
set_property PACKAGE_PIN AW26 [get_ports LRX43_N]
set_property IOSTANDARD LVDS [get_ports {LRX43_P LRX43_N}]

# LRX44
set_property PACKAGE_PIN AN28 [get_ports LRX44_P]
set_property PACKAGE_PIN AP28 [get_ports LRX44_N]
set_property IOSTANDARD LVDS [get_ports {LRX44_P LRX44_N}]

# LRX45
set_property PACKAGE_PIN AP25 [get_ports LRX45_P]
set_property PACKAGE_PIN AR25 [get_ports LRX45_N]
set_property IOSTANDARD LVDS [get_ports {LRX45_P LRX45_N}]

# LRX46
set_property PACKAGE_PIN AM26 [get_ports LRX46_P]
set_property PACKAGE_PIN AN26 [get_ports LRX46_N]
set_property IOSTANDARD LVDS [get_ports {LRX46_P LRX46_N}]

# LRX47
set_property PACKAGE_PIN AM24 [get_ports LRX47_P]
set_property PACKAGE_PIN AM25 [get_ports LRX47_N]
set_property IOSTANDARD LVDS [get_ports {LRX47_P LRX47_N}]
