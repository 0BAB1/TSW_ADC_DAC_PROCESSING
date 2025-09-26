# ==========================================================
# Vivado TCL Script for LVDS + ILA Debug Project
# Target device: XCKU060-FFVA1517
#
# BRH 09/2025
# ==========================================================

# --------- Project Setup ---------
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
# Add top SystemVerilog file
add_files ./src/top.sv

# Add constraints file
add_files -fileset constrs_1 ./constraints/constraints.xdc

# Set top module explicitly
set_property top top_lvds_ila [current_fileset]

# --------- ILA IP Core ---------
create_ip -name ila -vendor xilinx.com -library ip -version 6.2 -module_name ila_0
set_property -dict [list \
    CONFIG.C_PROBE0_WIDTH {12} \
    CONFIG.C_PROBE1_WIDTH {12} \
    CONFIG.C_PROBE2_WIDTH {12} \
    CONFIG.C_PROBE3_WIDTH {12} \
    CONFIG.C_NUM_OF_PROBES {4} \
    CONFIG.C_INPUT_PIPE_STAGES {0} \
] [get_ips ila_0]

# Generate output products for IP
generate_target {instantiation_template} [get_ips ila_0]
generate_target all [get_ips ila_0]

# --------- Run Synthesis/Implementation ---------
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

launch_runs synth_1 -jobs 8
wait_on_run synth_1

launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1

# Open implemented design
open_run impl_1

# --------- Hardware Setup ---------
# This will be run manually once board is connected
# open_hw
# connect_hw_server
# open_hw_target
# set_property PROGRAM.FILE {./lvds_ila_proj/lvds_ila_proj.runs/impl_1/top_lvds_ila.bit} [current_hw_device]
# program_hw_devices [current_hw_device]

puts "=================================================="
puts " Vivado Project Setup Complete!"
puts " Project dir: $project_dir"
puts " Target part: XCKU060-FFVA1517"
puts "=================================================="
