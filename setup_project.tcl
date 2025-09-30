# ==========================================================
# Vivado TCL Script for LVDS + ILA Debug Project
# Target device: XCKU060-FFVA1517
#
# BRH 09/2025
# ==========================================================

####################################
# overall project setup
####################################

set project_name "TSW_TESTS"
set project_dir  "./${project_name}"

# Clean up if project already exists
if {[file exists $project_dir]} {
    puts "INFO: Removing old project directory..."
    file delete -force $project_dir
}

# Create new project
create_project $project_name $project_dir -part xcku060-ffva1517-2-e
set_property target_language verilog [current_project]
set_property default_lib work [current_project]

# --------- Source Files ---------
# Add src files
add_files ./src/reciever.v

# Add constraints file
add_files -fileset constrs_1 ./constraints/constraints.xdc

####################################
# Block design automation
####################################

update_compile_order -fileset sources_1
create_bd_design "design_1"

update_compile_order -fileset sources_1
create_bd_cell -type module -reference reciever reciever_0

make_bd_pins_external  [get_bd_pins reciever_0/LRX44_P] [get_bd_pins reciever_0/LRX17_N] [get_bd_pins reciever_0/CLK_ONBOARD_125_P] [get_bd_pins reciever_0/LRX43_P] [get_bd_pins reciever_0/LRX16_N] [get_bd_pins reciever_0/LRX6_P] [get_bd_pins reciever_0/LRX15_N] [get_bd_pins reciever_0/LRX5_P] [get_bd_pins reciever_0/LRX42_P] [get_bd_pins reciever_0/LRX30_N] [get_bd_pins reciever_0/LRX4_P] [get_bd_pins reciever_0/LRX41_P] [get_bd_pins reciever_0/LRX3_P] [get_bd_pins reciever_0/LRX40_P] [get_bd_pins reciever_0/LRX29_N] [get_bd_pins reciever_0/LRX2_P] [get_bd_pins reciever_0/LRX39_P] [get_bd_pins reciever_0/LRX28_N] [get_bd_pins reciever_0/LRX27_N] [get_bd_pins reciever_0/LRX1_P] [get_bd_pins reciever_0/LRX26_N] [get_bd_pins reciever_0/LRX0_P] [get_bd_pins reciever_0/RX_STROBE3_P] [get_bd_pins reciever_0/LRX25_N] [get_bd_pins reciever_0/LRX24_N] [get_bd_pins reciever_0/LRX14_P] [get_bd_pins reciever_0/LRX23_N] [get_bd_pins reciever_0/LRX13_P] [get_bd_pins reciever_0/LRX12_P] [get_bd_pins reciever_0/LRX38_N] [get_bd_pins reciever_0/LRX11_P] [get_bd_pins reciever_0/LRX37_N] [get_bd_pins reciever_0/LRX47_P] [get_bd_pins reciever_0/LRX36_N] [get_bd_pins reciever_0/LRX10_P] [get_bd_pins reciever_0/RX_STROBE2_N] [get_bd_pins reciever_0/LRX35_N] [get_bd_pins reciever_0/LRX9_P] [get_bd_pins reciever_0/LRX34_N] [get_bd_pins reciever_0/LRX8_P] [get_bd_pins reciever_0/RX_STROBE1_N] [get_bd_pins reciever_0/LRX33_N] [get_bd_pins reciever_0/LRX7_P] [get_bd_pins reciever_0/RX_STROBE0_N] [get_bd_pins reciever_0/LRX22_P] [get_bd_pins reciever_0/RX_CLK3_N] [get_bd_pins reciever_0/LRX32_N] [get_bd_pins reciever_0/LRX21_P] [get_bd_pins reciever_0/RX_CLK2_N] [get_bd_pins reciever_0/LRX31_N] [get_bd_pins reciever_0/RX_CLK1_N] [get_bd_pins reciever_0/LRX46_N] [get_bd_pins reciever_0/LRX20_P] [get_bd_pins reciever_0/RX_CLK0_N] [get_bd_pins reciever_0/LRX45_N] [get_bd_pins reciever_0/LRX19_P] [get_bd_pins reciever_0/LRX44_N] [get_bd_pins reciever_0/LRX18_P] [get_bd_pins reciever_0/CLK_ONBOARD_125_N] [get_bd_pins reciever_0/LRX43_N] [get_bd_pins reciever_0/LRX17_P] [get_bd_pins reciever_0/LRX6_N] [get_bd_pins reciever_0/LRX42_N] [get_bd_pins reciever_0/LRX16_P] [get_bd_pins reciever_0/LRX5_N] [get_bd_pins reciever_0/LRX41_N] [get_bd_pins reciever_0/LRX15_P] [get_bd_pins reciever_0/LRX4_N] [get_bd_pins reciever_0/LRX40_N] [get_bd_pins reciever_0/LRX30_P] [get_bd_pins reciever_0/LRX3_N] [get_bd_pins reciever_0/LRX39_N] [get_bd_pins reciever_0/LRX2_N] [get_bd_pins reciever_0/LRX29_P] [get_bd_pins reciever_0/LRX28_P] [get_bd_pins reciever_0/LRX1_N] [get_bd_pins reciever_0/LRX27_P] [get_bd_pins reciever_0/LRX0_N] [get_bd_pins reciever_0/LRX26_P] [get_bd_pins reciever_0/LRX14_N] [get_bd_pins reciever_0/LRX25_P] [get_bd_pins reciever_0/LRX13_N] [get_bd_pins reciever_0/LRX24_P] [get_bd_pins reciever_0/LRX23_P] [get_bd_pins reciever_0/LRX12_N] [get_bd_pins reciever_0/LRX11_N] [get_bd_pins reciever_0/LRX38_P] [get_bd_pins reciever_0/LRX37_P] [get_bd_pins reciever_0/LRX47_N] [get_bd_pins reciever_0/LRX10_N] [get_bd_pins reciever_0/LRX36_P] [get_bd_pins reciever_0/LRX9_N] [get_bd_pins reciever_0/RX_STROBE2_P] [get_bd_pins reciever_0/LRX35_P] [get_bd_pins reciever_0/LRX8_N] [get_bd_pins reciever_0/RX_STROBE1_P] [get_bd_pins reciever_0/LRX34_P] [get_bd_pins reciever_0/LRX7_N] [get_bd_pins reciever_0/RX_STROBE0_P] [get_bd_pins reciever_0/LRX33_P] [get_bd_pins reciever_0/LRX22_N] [get_bd_pins reciever_0/RX_CLK3_P] [get_bd_pins reciever_0/LRX21_N] [get_bd_pins reciever_0/LRX32_P] [get_bd_pins reciever_0/LRX31_P] [get_bd_pins reciever_0/LRX20_N] [get_bd_pins reciever_0/RX_CLK2_P] [get_bd_pins reciever_0/LRX46_P] [get_bd_pins reciever_0/RX_CLK1_P] [get_bd_pins reciever_0/LRX19_N] [get_bd_pins reciever_0/LRX45_P] [get_bd_pins reciever_0/RX_CLK0_P] [get_bd_pins reciever_0/LRX18_N] [get_bd_pins reciever_0/RX_STROBE3_N]
set_property NAME LRX44_P [get_bd_ports LRX44_P_0]
set_property NAME LRX17_N [get_bd_ports LRX17_N_0]
set_property NAME CLK_ONBOARD_125_P [get_bd_ports CLK_ONBOARD_125_P_0]
set_property NAME LRX43_P [get_bd_ports LRX43_P_0]
set_property NAME LRX16_N [get_bd_ports LRX16_N_0]
set_property NAME LRX6_P [get_bd_ports LRX6_P_0]
set_property NAME LRX15_N [get_bd_ports LRX15_N_0]
set_property NAME LRX5_P [get_bd_ports LRX5_P_0]
set_property NAME LRX42_P [get_bd_ports LRX42_P_0]
set_property NAME LRX30_N [get_bd_ports LRX30_N_0]
set_property NAME LRX4_P [get_bd_ports LRX4_P_0]
set_property NAME LRX41_P [get_bd_ports LRX41_P_0]
set_property NAME LRX3_P [get_bd_ports LRX3_P_0]
set_property NAME LRX40_P [get_bd_ports LRX40_P_0]
set_property NAME LRX29_N [get_bd_ports LRX29_N_0]
set_property NAME LRX2_P [get_bd_ports LRX2_P_0]
set_property NAME LRX39_P [get_bd_ports LRX39_P_0]
set_property NAME LRX28_N [get_bd_ports LRX28_N_0]
set_property NAME LRX27_N [get_bd_ports LRX27_N_0]
set_property NAME LRX1_P [get_bd_ports LRX1_P_0]
set_property NAME LRX26_N [get_bd_ports LRX26_N_0]
set_property NAME LRX0_P [get_bd_ports LRX0_P_0]
set_property NAME RX_STROBE3_P [get_bd_ports RX_STROBE3_P_0]
set_property NAME LRX25_N [get_bd_ports LRX25_N_0]
set_property NAME LRX24_N [get_bd_ports LRX24_N_0]
set_property NAME LRX14_P [get_bd_ports LRX14_P_0]
set_property NAME LRX23_N [get_bd_ports LRX23_N_0]
set_property NAME LRX13_P [get_bd_ports LRX13_P_0]
set_property NAME LRX12_P [get_bd_ports LRX12_P_0]
set_property NAME LRX38_N [get_bd_ports LRX38_N_0]
set_property NAME LRX11_P [get_bd_ports LRX11_P_0]
set_property NAME LRX37_N [get_bd_ports LRX37_N_0]
set_property NAME LRX47_P [get_bd_ports LRX47_P_0]
set_property NAME LRX36_N [get_bd_ports LRX36_N_0]
set_property NAME LRX10_P [get_bd_ports LRX10_P_0]
set_property NAME RX_STROBE2_N [get_bd_ports RX_STROBE2_N_0]
set_property NAME LRX35_N [get_bd_ports LRX35_N_0]
set_property NAME LRX9_P [get_bd_ports LRX9_P_0]
set_property NAME LRX34_N [get_bd_ports LRX34_N_0]
set_property NAME LRX8_P [get_bd_ports LRX8_P_0]
set_property NAME RX_STROBE1_N [get_bd_ports RX_STROBE1_N_0]
set_property NAME LRX33_N [get_bd_ports LRX33_N_0]
set_property NAME LRX7_P [get_bd_ports LRX7_P_0]
set_property NAME RX_STROBE0_N [get_bd_ports RX_STROBE0_N_0]
set_property NAME LRX22_P [get_bd_ports LRX22_P_0]
set_property NAME RX_CLK3_N [get_bd_ports RX_CLK3_N_0]
set_property NAME LRX32_N [get_bd_ports LRX32_N_0]
set_property NAME LRX21_P [get_bd_ports LRX21_P_0]
set_property NAME RX_CLK2_N [get_bd_ports RX_CLK2_N_0]
set_property NAME LRX31_N [get_bd_ports LRX31_N_0]
set_property NAME RX_CLK1_N [get_bd_ports RX_CLK1_N_0]
set_property NAME LRX46_N [get_bd_ports LRX46_N_0]
set_property NAME LRX20_P [get_bd_ports LRX20_P_0]
set_property NAME RX_CLK0_N [get_bd_ports RX_CLK0_N_0]
set_property NAME LRX45_N [get_bd_ports LRX45_N_0]
set_property NAME LRX19_P [get_bd_ports LRX19_P_0]
set_property NAME LRX44_N [get_bd_ports LRX44_N_0]
set_property NAME LRX18_P [get_bd_ports LRX18_P_0]
set_property NAME CLK_ONBOARD_125_N [get_bd_ports CLK_ONBOARD_125_N_0]
set_property NAME LRX43_N [get_bd_ports LRX43_N_0]
set_property NAME LRX17_P [get_bd_ports LRX17_P_0]
set_property NAME LRX6_N [get_bd_ports LRX6_N_0]
set_property NAME LRX42_N [get_bd_ports LRX42_N_0]
set_property NAME LRX16_P [get_bd_ports LRX16_P_0]
set_property NAME LRX5_N [get_bd_ports LRX5_N_0]
set_property NAME LRX41_N [get_bd_ports LRX41_N_0]
set_property NAME LRX15_P [get_bd_ports LRX15_P_0]
set_property NAME LRX4_N [get_bd_ports LRX4_N_0]
set_property NAME LRX40_N [get_bd_ports LRX40_N_0]
set_property NAME LRX30_P [get_bd_ports LRX30_P_0]
set_property NAME LRX3_N [get_bd_ports LRX3_N_0]
set_property NAME LRX39_N [get_bd_ports LRX39_N_0]
set_property NAME LRX2_N [get_bd_ports LRX2_N_0]
set_property NAME LRX29_P [get_bd_ports LRX29_P_0]
set_property NAME LRX28_P [get_bd_ports LRX28_P_0]
set_property NAME LRX1_N [get_bd_ports LRX1_N_0]
set_property NAME LRX27_P [get_bd_ports LRX27_P_0]
set_property NAME LRX0_N [get_bd_ports LRX0_N_0]
set_property NAME LRX26_P [get_bd_ports LRX26_P_0]
set_property NAME LRX14_N [get_bd_ports LRX14_N_0]
set_property NAME LRX25_P [get_bd_ports LRX25_P_0]
set_property NAME LRX13_N [get_bd_ports LRX13_N_0]
set_property NAME LRX24_P [get_bd_ports LRX24_P_0]
set_property NAME LRX23_P [get_bd_ports LRX23_P_0]
set_property NAME LRX12_N [get_bd_ports LRX12_N_0]
set_property NAME LRX11_N [get_bd_ports LRX11_N_0]
set_property NAME LRX38_P [get_bd_ports LRX38_P_0]
set_property NAME LRX37_P [get_bd_ports LRX37_P_0]
set_property NAME LRX47_N [get_bd_ports LRX47_N_0]
set_property NAME LRX10_N [get_bd_ports LRX10_N_0]
set_property NAME LRX36_P [get_bd_ports LRX36_P_0]
set_property NAME LRX9_N [get_bd_ports LRX9_N_0]
set_property NAME RX_STROBE2_P [get_bd_ports RX_STROBE2_P_0]
set_property NAME LRX35_P [get_bd_ports LRX35_P_0]
set_property NAME LRX8_N [get_bd_ports LRX8_N_0]
set_property NAME RX_STROBE1_P [get_bd_ports RX_STROBE1_P_0]
set_property NAME LRX34_P [get_bd_ports LRX34_P_0]
set_property NAME LRX7_N [get_bd_ports LRX7_N_0]
set_property NAME RX_STROBE0_P [get_bd_ports RX_STROBE0_P_0]
set_property NAME LRX33_P [get_bd_ports LRX33_P_0]
set_property NAME LRX22_N [get_bd_ports LRX22_N_0]
set_property NAME RX_CLK3_P [get_bd_ports RX_CLK3_P_0]
set_property NAME LRX21_N [get_bd_ports LRX21_N_0]
set_property NAME LRX32_P [get_bd_ports LRX32_P_0]
set_property NAME LRX31_P [get_bd_ports LRX31_P_0]
set_property NAME LRX20_N [get_bd_ports LRX20_N_0]
set_property NAME RX_CLK2_P [get_bd_ports RX_CLK2_P_0]
set_property NAME LRX46_P [get_bd_ports LRX46_P_0]
set_property NAME RX_CLK1_P [get_bd_ports RX_CLK1_P_0]
set_property NAME LRX19_N [get_bd_ports LRX19_N_0]
set_property NAME LRX45_P [get_bd_ports LRX45_P_0]
set_property NAME RX_CLK0_P [get_bd_ports RX_CLK0_P_0]
set_property NAME LRX18_N [get_bd_ports LRX18_N_0]
set_property NAME RX_STROBE3_N [get_bd_ports RX_STROBE3_N_0]


# inform vivado of isolation between 2 clock domains
set_false_path -from [get_clocks RX_CLK0] -to [get_clocks sys_clk]

# --------- Run Synthesis/Implementation ---------
# update_compile_order -fileset sources_1
# update_compile_order -fileset sim_1

# launch_runs synth_1 -jobs 8
# wait_on_run synth_1

# launch_runs impl_1 -to_step write_bitstream -jobs 8
# wait_on_run impl_1