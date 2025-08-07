interface FIFO_interface (clk);

    parameter FIFO_WIDTH = 16;
    parameter FIFO_DEPTH = 8;
    input bit clk;

    reg [FIFO_WIDTH-1:0] data_in;
    reg rst_n, wr_en, rd_en;

    reg [FIFO_WIDTH-1:0] data_out;
    reg wr_ack, overflow;
    reg full, empty, almostfull, almostempty, underflow;

    modport dut (
        input clk,
        input data_in, rst_n, wr_en, rd_en,

        output data_out,
        output wr_ack, overflow,
        output full, empty, almostfull, almostempty, underflow
    );


    modport tb (
        input clk,
        input data_out,
        input wr_ack, overflow,
        input full, empty, almostfull, almostempty, underflow,

        output data_in, rst_n, wr_en, rd_en
    );

    modport moniter (
        input clk,
        input data_in, rst_n, wr_en, rd_en,

        input data_out,
        input wr_ack, overflow,
        input full, empty, almostfull, almostempty, underflow

    );
endinterface