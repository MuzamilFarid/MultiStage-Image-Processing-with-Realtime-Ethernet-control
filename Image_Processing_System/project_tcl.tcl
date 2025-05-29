start_gui

create_project Image_Processing_System /home/muzamilfarid/Coraz7_Projects/Image-Processing-Systen-with-realtime-Camera/Image_Processing_System -part xc7z007sclg400-1

set_property board_part digilentinc.com:cora-z7-07s:part0:1.1 [current_project]

create_bd_design "Ov7670_Image_Proc_System"

update_compile_order -fileset sources_1

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 blk_mem_gen_0
endgroup

set_property -dict [list CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Use_RSTB_Pin {true} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Write_Rate {50} CONFIG.Port_B_Enable_Rate {100}] [get_bd_cells blk_mem_gen_0]
set_property location {1 36 -213} [get_bd_cells blk_mem_gen_0]
set_property location {1 82 -216} [get_bd_cells blk_mem_gen_0]

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
endgroup

apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]

file mkdir /home/muzamilfarid/Coraz7_Projects/Image-Processing-Systen-with-realtime-Camera/Image_Processing_System/Image_Processing_System.srcs/sources_1/new
close [ open /home/muzamilfarid/Coraz7_Projects/Image-Processing-Systen-with-realtime-Camera/Image_Processing_System/Image_Processing_System.srcs/sources_1/new/blurr.sv w ]
add_files /home/muzamilfarid/Coraz7_Projects/Image-Processing-Systen-with-realtime-Camera/Image_Processing_System/Image_Processing_System.srcs/sources_1/new/blurr.sv
close [ open /home/muzamilfarid/Coraz7_Projects/Image-Processing-Systen-with-realtime-Camera/Image_Processing_System/Image_Processing_System.srcs/sources_1/new/edge_detection_IP.sv w ]
add_files /home/muzamilfarid/Coraz7_Projects/Image-Processing-Systen-with-realtime-Camera/Image_Processing_System/Image_Processing_System.srcs/sources_1/new/edge_detection_IP.sv
update_compile_order -fileset sources_1
update_compile_order -fileset sources_1