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
add_files ./src/sampler.v
add_files ./src/lvds_clk_conv.v

# Add constraints file
add_files -fileset constrs_1 ./constraints/constraints.xdc

####################################
# Block design automation
####################################

update_compile_order -fileset sources_1
create_bd_design "design_1"

# --------- Run Synthesis/Implementation ---------
# update_compile_order -fileset sources_1
# update_compile_order -fileset sim_1

# launch_runs synth_1 -jobs 8
# wait_on_run synth_1

# launch_runs impl_1 -to_step write_bitstream -jobs 8
# wait_on_run impl_1