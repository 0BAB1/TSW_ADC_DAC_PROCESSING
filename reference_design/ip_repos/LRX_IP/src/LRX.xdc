# For 1600Mbps LVDS rate
create_clock -period 1.250 [get_ports {rx_clk_p[0]}]
create_clock -period 1.250 [get_ports {rx_clk_p[1]}]
create_clock -period 1.250 [get_ports {rx_clk_p[2]}]
create_clock -period 1.250 [get_ports {rx_clk_p[3]}]

#Constraints for the clock cross domain

set_false_path -to sync_stage_i0/sync_flop_0_reg[*]/D
set_false_path -to sync_stage_i1/sync_flop_0_reg[*]/D
set_false_path -to sync_stage_i2/sync_flop_0_reg[*]/D
set_false_path -to sync_stage_i3/sync_flop_0_reg[*]/D
set_false_path -to sync_stage_i4/sync_flop_0_reg[*]/D
set_false_path -to sync_stage_i5/sync_flop_0_reg[*]/D
set_false_path -to sync_stage_i6/sync_flop_0_reg[*]/D
set_false_path -to sync_stage_i7/sync_flop_0_reg[*]/D
set_false_path -to sync_stage_i8/sync_flop_0_reg[*]/D
set_false_path -to sync_stage_i9/sync_flop_0_reg[*]/D
set_false_path -to sync_stage_i10/sync_flop_0_reg[*]/D

set_false_path -to ch0_i/sync_stage_i0/sync_flop_0_reg[*]/D
set_false_path -to ch0_i/sync_stage_i2/sync_flop_0_reg[*]/D
set_false_path -to ch0_i/sync_stage_i3/sync_flop_0_reg[*]/D
set_false_path -to ch0_i/genblk2[*].Bank0_iod/sync_stage_i0/sync_flop_0_reg[*]/D
set_false_path -to ch0_i/genblk2[*].Bank0_iod/sync_stage_i1/sync_flop_0_reg[*]/D
set_false_path -to ch0_i/genblk2[*].Bank0_iod/check_ms_i/sync_stage_i4/sync_flop_0_reg[*]/D
set_false_path -to ch0_i/genblk2[*].Bank0_iod/check_ms_i/sync_stage_i5/sync_flop_0_reg[*]/D

set_false_path -to ch1_i/sync_stage_i0/sync_flop_0_reg[*]/D
set_false_path -to ch1_i/sync_stage_i2/sync_flop_0_reg[*]/D
set_false_path -to ch1_i/sync_stage_i3/sync_flop_0_reg[*]/D
set_false_path -to ch1_i/genblk2[*].Bank1_iod/sync_stage_i0/sync_flop_0_reg[*]/D
set_false_path -to ch1_i/genblk2[*].Bank1_iod/sync_stage_i1/sync_flop_0_reg[*]/D
set_false_path -to ch1_i/genblk2[*].Bank1_iod/check_ms_i/sync_stage_i4/sync_flop_0_reg[*]/D
set_false_path -to ch1_i/genblk2[*].Bank1_iod/check_ms_i/sync_stage_i5/sync_flop_0_reg[*]/D

set_false_path -to ch2_i/sync_stage_i0/sync_flop_0_reg[*]/D
set_false_path -to ch2_i/sync_stage_i2/sync_flop_0_reg[*]/D
set_false_path -to ch2_i/sync_stage_i3/sync_flop_0_reg[*]/D
set_false_path -to ch2_i/genblk2[*].Bank2_iod/sync_stage_i0/sync_flop_0_reg[*]/D
set_false_path -to ch2_i/genblk2[*].Bank2_iod/sync_stage_i1/sync_flop_0_reg[*]/D
set_false_path -to ch2_i/genblk2[*].Bank2_iod/check_ms_i/sync_stage_i4/sync_flop_0_reg[*]/D
set_false_path -to ch2_i/genblk2[*].Bank2_iod/check_ms_i/sync_stage_i5/sync_flop_0_reg[*]/D


set_false_path -to ch3_i/sync_stage_i0/sync_flop_0_reg[*]/D
set_false_path -to ch3_i/sync_stage_i2/sync_flop_0_reg[*]/D
set_false_path -to ch3_i/sync_stage_i3/sync_flop_0_reg[*]/D
set_false_path -to ch3_i/genblk2[*].Bank3_iod/sync_stage_i0/sync_flop_0_reg[*]/D
set_false_path -to ch3_i/genblk2[*].Bank3_iod/sync_stage_i1/sync_flop_0_reg[*]/D
set_false_path -to ch3_i/genblk2[*].Bank3_iod/check_ms_i/sync_stage_i4/sync_flop_0_reg[*]/D
set_false_path -to ch3_i/genblk2[*].Bank3_iod/check_ms_i/sync_stage_i5/sync_flop_0_reg[*]/D