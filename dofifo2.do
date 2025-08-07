vlib work
vlog +acc +define+SIM -f fifo2_files.list
vsim -voptargs=+acc fifo2_top

add wave /fifo2_top/intf/clk
add wave /fifo2_top/intf/rst_n
add wave /fifo2_top/intf/wr_en
add wave /fifo2_top/intf/rd_en
add wave /fifo2_top/intf/data_in
add wave /fifo2_top/intf/data_out
add wave /fifo2_top/intf/full
add wave /fifo2_top/intf/empty
add wave /fifo2_top/intf/almostfull 
add wave /fifo2_top/intf/almostempty 
add wave /fifo2_top/intf/underflow
add wave /fifo2_top/intf/overflow
add wave /fifo2_top/intf/wr_ack
add wave /fifo2_top/dut/count
add wave /fifo2_top/dut/wr_ptr
add wave /fifo2_top/dut/rd_ptr

run -all

