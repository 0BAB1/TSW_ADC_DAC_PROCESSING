#Run this script from in the vivado GUI after editing the below parameters

set PROJ_NAME 			"adc_ref_design"
set PROJ_FOLDER_NAME 	"project"
set DEVICE    			"xcku060-ffva1517-2-e"
#replace the ip repo path
set IP_REPO_PATH 		"../ip_repos"
set PROJ_PATH 			"../prj"
#replace the xdc path
set XDC_PATH 			"../xdc/adc_rx_xcku060.xdc" 
#expected vivado version
set EXP_VIVADO_VER 		"2025.1"
set BLOCK_DIA_NAME		"bd_ref_design"
set wrapper 			${BLOCK_DIA_NAME}_wrapper
# script file source path detection
set script_path [ file dirname [ file normalize [ info script ] ] ]
puts $script_path
cd $script_path

#check that the correct version of Vivado is being used
set CUR_VIVADO_VER [version -short]

if { [string compare $EXP_VIVADO_VER $CUR_VIVADO_VER] != 0 } {
   puts ""
   puts "ERROR: This script is for Vivado <$EXP_VIVADO_VER> and is being run in <$CUR_VIVADO_VER> of Vivado. Please use Vivado <$EXP_VIVADO_VER>"

   return 1
}

#delete if already project exists
if { [file exists ./$PROJ_FOLDER_NAME] } {
  file delete -force ./$PROJ_FOLDER_NAME
}

#create project
create_project $PROJ_NAME -force ../$PROJ_FOLDER_NAME -part $DEVICE
current_project $PROJ_NAME
#addition of IP repo into the project
set_property  ip_repo_paths  "$IP_REPO_PATH" [current_project]
update_ip_catalog -rebuild

#block diagram creation
create_bd_design $BLOCK_DIA_NAME

#required IP insertion into project
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:jtag_axi:1.2 jtag_axi_0
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0
set_property -dict [list CONFIG.NUM_MI {5}] [get_bd_cells axi_interconnect_0]
create_bd_cell -type ip -vlnv ti.com:user:LRX:1.0 LRX_0
create_bd_cell -type ip -vlnv ti.com:user:clock_manager:1.0 clock_manager_0
set_property -dict [list CONFIG.FAN_OUT_SW_RST_APPCLK {0x00078} CONFIG.FAN_OUT_SW_RST_RIUCLK {0x0008}] [get_bd_cells clock_manager_0]
create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0
set_property -dict [list CONFIG.C_SIZE {1} CONFIG.C_OPERATION {not} CONFIG.LOGO_FILE {data/sym_notgate.png}] [get_bd_cells util_vector_logic_0]
create_bd_cell -type ip -vlnv ti.com:user:dummy_adc_data_capture:1.0 dummy_adc_data_capture_0
create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_1
set_property -dict [list CONFIG.C_SIZE {1} CONFIG.C_OPERATION {not} CONFIG.LOGO_FILE {data/sym_notgate.png}] [get_bd_cells util_vector_logic_1]
endgroup

#addition of external files
add_files -fileset constrs_1 -norecurse "$XDC_PATH"
import_files -fileset constrs_1 "$XDC_PATH"

#input port creation
startgroup
#on-board clk
create_bd_port -dir I clk_100m_p
create_bd_port -dir I clk_100m_n
#reset
create_bd_port -dir I -type rst hw_rst_n
#lvds forward clk in
create_bd_port -dir I -from 3 -to 0 rx_clk_p
create_bd_port -dir I -from 3 -to 0 rx_clk_n
#lvds data in
create_bd_port -dir I -from 47 -to 0 rx_data_p
create_bd_port -dir I -from 47 -to 0 rx_data_n
#lvds strobe in
create_bd_port -dir I -from 3 -to 0 strobe_rx_p
create_bd_port -dir I -from 3 -to 0 strobe_rx_n
endgroup

#output port creation
startgroup
create_bd_port -dir O rx_sync
create_bd_port -dir O rx_rst_done_led
create_bd_port -dir O and_of_all_busdata
endgroup

#net connections
# clk 
connect_bd_net [get_bd_pins /clock_manager_0/clk_100m_p] [get_bd_ports clk_100m_p]
connect_bd_net [get_bd_pins /clock_manager_0/clk_100m_n] [get_bd_ports clk_100m_n]
#reset 
connect_bd_net [get_bd_pins /clock_manager_0/hw_rst_n] [get_bd_ports hw_rst_n]
#lvds lanes
connect_bd_net [get_bd_pins /LRX_0/rx_clk_p] [get_bd_ports rx_clk_p]
connect_bd_net [get_bd_pins /LRX_0/rx_clk_n] [get_bd_ports rx_clk_n]

connect_bd_net [get_bd_pins /LRX_0/rx_data_p] [get_bd_ports rx_data_p]
connect_bd_net [get_bd_pins /LRX_0/rx_data_n] [get_bd_ports rx_data_n]

connect_bd_net [get_bd_pins /LRX_0/strobe_rx_p] [get_bd_ports strobe_rx_p]
connect_bd_net [get_bd_pins /LRX_0/strobe_rx_n] [get_bd_ports strobe_rx_n]

connect_bd_net [get_bd_pins /LRX_0/rx_sync] [get_bd_ports rx_sync]

connect_bd_net [get_bd_pins util_vector_logic_1/Res] [get_bd_ports rx_rst_done_led]

connect_bd_net [get_bd_pins dummy_adc_data_capture_0/and_of_all_busdata] [get_bd_ports and_of_all_busdata]

#internal signal connections

#Clock manager
connect_bd_net [get_bd_ports hw_rst_n] [get_bd_pins util_vector_logic_0/Op1]
connect_bd_net [get_bd_pins util_vector_logic_0/Res] [get_bd_pins clock_manager_0/sw_rst]
connect_bd_net [get_bd_pins LRX_0/app_clk] [get_bd_pins clock_manager_0/app_clk]
connect_bd_net [get_bd_pins LRX_0/rx_rst_done] [get_bd_pins util_vector_logic_1/Op1]
connect_bd_net [get_bd_pins clock_manager_0/riu_clk] [get_bd_pins jtag_axi_0/aclk]
connect_bd_net [get_bd_pins clock_manager_0/riu_clk] [get_bd_pins LRX_0/riu_clk]
connect_bd_net [get_bd_pins clock_manager_0/riu_clk] [get_bd_pins LRX_0/s_axi_clk]
connect_bd_net [get_bd_pins clock_manager_0/riu_clk] [get_bd_pins axi_interconnect_0/ACLK] 
connect_bd_net [get_bd_pins clock_manager_0/riu_clk] [get_bd_pins axi_interconnect_0/S00_ACLK]
connect_bd_net [get_bd_pins clock_manager_0/riu_clk] [get_bd_pins axi_interconnect_0/M00_ACLK]
connect_bd_net [get_bd_pins clock_manager_0/riu_clk] [get_bd_pins axi_interconnect_0/M02_ACLK] 
connect_bd_net [get_bd_pins clock_manager_0/riu_clk] [get_bd_pins axi_interconnect_0/M01_ACLK] 
connect_bd_net [get_bd_pins clock_manager_0/riu_clk] [get_bd_pins axi_interconnect_0/M03_ACLK] 
connect_bd_net [get_bd_pins clock_manager_0/riu_clk] [get_bd_pins axi_interconnect_0/M04_ACLK]
connect_bd_net [get_bd_pins clock_manager_0/sw_rst_appclk] [get_bd_pins LRX_0/sw_rst_app]
connect_bd_net [get_bd_pins clock_manager_0/sw_rst_riuclk] [get_bd_pins LRX_0/sw_rst_riu]
connect_bd_net [get_bd_pins clock_manager_0/sw_rst_riuclk_n] [get_bd_pins jtag_axi_0/aresetn]
connect_bd_net [get_bd_pins clock_manager_0/sw_rst_riuclk_n] [get_bd_pins axi_interconnect_0/ARESETN]
connect_bd_net [get_bd_pins clock_manager_0/sw_rst_riuclk_n] [get_bd_pins axi_interconnect_0/S00_ARESETN]
connect_bd_net [get_bd_pins clock_manager_0/sw_rst_riuclk_n] [get_bd_pins axi_interconnect_0/M00_ARESETN]
connect_bd_net [get_bd_pins clock_manager_0/sw_rst_riuclk_n] [get_bd_pins axi_interconnect_0/M01_ARESETN]
connect_bd_net [get_bd_pins clock_manager_0/sw_rst_riuclk_n] [get_bd_pins axi_interconnect_0/M02_ARESETN]
connect_bd_net [get_bd_pins clock_manager_0/sw_rst_riuclk_n] [get_bd_pins axi_interconnect_0/M03_ARESETN]
connect_bd_net [get_bd_pins clock_manager_0/sw_rst_riuclk_n] [get_bd_pins axi_interconnect_0/M04_ARESETN]
connect_bd_net [get_bd_pins clock_manager_0/sw_rst_riuclk_n] [get_bd_pins LRX_0/s_axi_rst_n]

#LRX 0

connect_bd_intf_net [get_bd_intf_pins LRX_0/s_axi] -boundary_type upper [get_bd_intf_pins axi_interconnect_0/M00_AXI]
connect_bd_intf_net [get_bd_intf_pins LRX_0/busA_iod_s_axi] -boundary_type upper [get_bd_intf_pins axi_interconnect_0/M01_AXI]
connect_bd_intf_net [get_bd_intf_pins LRX_0/busB_iod_s_axi] -boundary_type upper [get_bd_intf_pins axi_interconnect_0/M02_AXI]
connect_bd_intf_net [get_bd_intf_pins LRX_0/busC_iod_s_axi] -boundary_type upper [get_bd_intf_pins axi_interconnect_0/M03_AXI]
connect_bd_intf_net [get_bd_intf_pins LRX_0/busD_iod_s_axi] -boundary_type upper [get_bd_intf_pins axi_interconnect_0/M04_AXI]
connect_bd_intf_net [get_bd_intf_pins jtag_axi_0/M_AXI] -boundary_type upper [get_bd_intf_pins axi_interconnect_0/S00_AXI]
connect_bd_net [get_bd_pins LRX_0/app_clk] [get_bd_pins dummy_adc_data_capture_0/app_clk]

#temp module 
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins LRX_0/adc_busA] [get_bd_intf_pins dummy_adc_data_capture_0/adc_busSlaveA]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins LRX_0/adc_busB] [get_bd_intf_pins dummy_adc_data_capture_0/adc_busSlaveB]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins LRX_0/adc_busC] [get_bd_intf_pins dummy_adc_data_capture_0/adc_busSlaveC]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins LRX_0/adc_busD] [get_bd_intf_pins dummy_adc_data_capture_0/adc_busSlaveD]

# mapping the address for slaves
assign_bd_address

#hierarcy creation
group_bd_cells lrx_hier [get_bd_cells jtag_axi_0] [get_bd_cells util_vector_logic_1] [get_bd_cells clock_manager_0] [get_bd_cells LRX_0] [get_bd_cells axi_interconnect_0]

regenerate_bd_layout  

#generation of wrapper file

make_wrapper -files [get_files ../$PROJ_FOLDER_NAME/$PROJ_NAME.srcs/sources_1/bd/$BLOCK_DIA_NAME/$BLOCK_DIA_NAME.bd] -top
add_files -norecurse ../$PROJ_FOLDER_NAME/$PROJ_NAME.srcs/sources_1/bd/$BLOCK_DIA_NAME/hdl/$wrapper.v

#selecting debug probes
set_property HDL_ATTRIBUTE.DEBUG true [get_bd_intf_nets {LRX_0_adc_busA}]
set_property HDL_ATTRIBUTE.DEBUG true [get_bd_intf_nets {LRX_0_adc_busB}]
set_property HDL_ATTRIBUTE.DEBUG true [get_bd_intf_nets {LRX_0_adc_busC}]
set_property HDL_ATTRIBUTE.DEBUG true [get_bd_intf_nets {LRX_0_adc_busD}]
set_property HDL_ATTRIBUTE.DEBUG true [get_bd_nets {LRX_0_rx_sync}]

save_bd_design
