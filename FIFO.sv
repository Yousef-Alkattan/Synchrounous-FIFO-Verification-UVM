////////////////////////////////////////////////////////////////////////////////
// Author: Kareem Waseem
// Course: Digital Verification using SV & UVM
//
// Description: FIFO Design 
// 
////////////////////////////////////////////////////////////////////////////////


module FIFO(FIFO_interface.dut intf);
 
        parameter FIFO_WIDTH = 16;
        parameter FIFO_DEPTH = 8;

localparam max_fifo_addr = $clog2(FIFO_DEPTH);

reg [FIFO_WIDTH-1:0] mem [FIFO_DEPTH-1:0];

reg [max_fifo_addr-1:0] wr_ptr, rd_ptr;
reg [max_fifo_addr:0] count;

always @(posedge intf.clk or negedge intf.rst_n) begin
	if (!intf.rst_n) begin
		wr_ptr <= 0;
		intf.wr_ack <= 0; //fixed
		intf.overflow <= 0; //fixed
	end
	else if (intf.wr_en && count < FIFO_DEPTH) begin
		mem[wr_ptr] <= intf.data_in;
		intf.wr_ack <= 1;
		wr_ptr <= wr_ptr + 1;
	end
	else begin 
		intf.wr_ack <= 0; 
		if (intf.full && intf.wr_en) //fixed was & only
			intf.overflow <= 1;
		else
			intf.overflow <= 0;
	end
end

always @(posedge intf.clk or negedge intf.rst_n) begin
	if (!intf.rst_n) begin
		rd_ptr <= 0;
		intf.underflow <= 0; //fixed
		intf.data_out <= 0;  //fixed
	end
	else if (intf.rd_en && count != 0) begin
		intf.data_out <= mem[rd_ptr];
		rd_ptr <= rd_ptr + 1;
	end
	else begin  //fixed underflow is sequential logic
		if (intf.empty && intf.rd_en) 
			intf.underflow <= 1; 
		else
			intf.underflow <= 0; 
	end 
end

always @(posedge intf.clk or negedge intf.rst_n) begin
	if (!intf.rst_n) begin
		count <= 0;
	end
	else begin
		if (({intf.wr_en, intf.rd_en} == 2'b11) && intf.full) //fixed fine if both on but full not handled
			count <= count - 1; 
		else if (({intf.wr_en, intf.rd_en} == 2'b11) && intf.empty) //fixed fine if both on but empty not handled
			count <= count + 1;
		else if	( ({intf.wr_en, intf.rd_en} == 2'b10) && !intf.full) 
			count <= count + 1; 
		else if ( ({intf.wr_en, intf.rd_en} == 2'b01) && !intf.empty) 
			count <= count - 1; 
	end
end

assign intf.full = (count == FIFO_DEPTH)? 1 : 0;
assign intf.empty = (count == 0 && intf.rst_n)? 1 : 0; //fixed
 
assign intf.almostfull = (count == FIFO_DEPTH-1)? 1 : 0; //fixed -1 not -2
assign intf.almostempty = (count == 1)? 1 : 0;


//assertions

`ifdef SIM

// 1. Reset Behavior
always_comb begin : rst_n_assert
    if (!intf.rst_n) begin
        assert final (count == 0);
        assert final (wr_ptr == 0);
        assert final (rd_ptr == 0);

        assert final (intf.wr_ack == 0);
        assert final (intf.overflow == 0);
        assert final (intf.underflow == 0);
        assert final (intf.data_out == 0);

        assert final (intf.full == 0);
        assert final (intf.empty == 0);
        assert final (intf.almostfull == 0);
        assert final (intf.almostempty == 0);
    end
end

// 2. Write Acknowledge
ack: assert property (@(posedge intf.clk) disable iff(!intf.rst_n)
    (intf.wr_en && !intf.full) |=> intf.wr_ack);

// 3. Overflow Detection
overflow: assert property (@(posedge intf.clk) disable iff(!intf.rst_n)
    (intf.full && intf.wr_en) |=> intf.overflow);

// 4. Underflow Detection
underflow: assert property (@(posedge intf.clk) disable iff(!intf.rst_n)
    (intf.empty && intf.rd_en) |=> intf.underflow);

// 5. Empty Flag Assertion
empty: assert property (@(posedge intf.clk) disable iff(!intf.rst_n)
    (count == 0) |-> intf.empty);

// 6. Full Flag Assertion
full: assert property (@(posedge intf.clk) disable iff(!intf.rst_n)
    (count == FIFO_DEPTH) |-> intf.full);

// 7. Almost Full Condition
almostfull: assert property (@(posedge intf.clk) disable iff(!intf.rst_n)
    (count == FIFO_DEPTH-1) |-> intf.almostfull);

// 8. Almost Empty Condition
almostempty: assert property (@(posedge intf.clk) disable iff(!intf.rst_n)
    (count == 1) |-> intf.almostempty);

// 9. Pointer Wraparound
wr_ptr_assert: assert property (@(posedge intf.clk) disable iff(!intf.rst_n)
    (intf.wr_en && count < FIFO_DEPTH) |=> 
    (wr_ptr == 0 ? $past(wr_ptr) == FIFO_DEPTH-1 : wr_ptr == $past(wr_ptr) + 1));

rd_ptr_assert: assert property (@(posedge intf.clk) disable iff(!intf.rst_n)
    (intf.rd_en && count != 0) |=> 
    (rd_ptr == 0 ? $past(rd_ptr) == FIFO_DEPTH-1 : rd_ptr == $past(rd_ptr) + 1));

// 10. Pointer Threshold
count_range: assert property (@(posedge intf.clk) disable iff(!intf.rst_n)
    (count <= FIFO_DEPTH));

wr_ptr_range: assert property (@(posedge intf.clk) disable iff(!intf.rst_n)
    (wr_ptr < FIFO_DEPTH));

rd_ptr_range: assert property (@(posedge intf.clk) disable iff(!intf.rst_n)
    (rd_ptr < FIFO_DEPTH));

`endif


endmodule