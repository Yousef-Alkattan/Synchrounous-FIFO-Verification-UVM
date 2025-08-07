package fifo_scoreboard_pkg;

  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import fifo_sequence_item_pkg::*;

  class fifo_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(fifo_scoreboard)
    parameter FIFO_WIDTH = 16;
    parameter FIFO_DEPTH = 8;

    uvm_analysis_export #(fifo_sequence_item) sb_export;
    uvm_tlm_analysis_fifo #(fifo_sequence_item) sb_fifo;

    fifo_sequence_item seq_item_sb;

    int correct_count = 0;
    int error_count = 0;

    // Output reference variables
    bit [FIFO_WIDTH-1:0] data_out_ref;
    bit wr_ack_ref, overflow_ref;
    bit full_ref, empty_ref, almostfull_ref;
    bit almostempty_ref, underflow_ref;

    // Reference model
    function void reference_model(
      input bit [FIFO_WIDTH-1:0] data_out1,
      input bit wr_ack1, overflow1, full1, empty1,
      input bit almostfull1, almostempty1, underflow1
    );
      data_out_ref     = data_out1;
      wr_ack_ref       = wr_ack1;
      overflow_ref     = overflow1;
      full_ref         = full1;
      empty_ref        = empty1;
      almostfull_ref   = almostfull1;
      almostempty_ref  = almostempty1;
      underflow_ref    = underflow1;
    endfunction

    function new(string name = "fifo_scoreboard", uvm_component parent = null);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      sb_export = new("sb_export", this);
      sb_fifo = new("sb_fifo", this);
    endfunction

    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      sb_export.connect (sb_fifo.analysis_export);
    endfunction

    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      forever begin
	sb_fifo.get(seq_item_sb);
        reference_model(seq_item_sb.data_out, seq_item_sb.wr_ack, seq_item_sb.overflow, 
                      seq_item_sb.full, seq_item_sb.empty, seq_item_sb.almostfull,
                      seq_item_sb.almostempty, seq_item_sb.underflow);

        if (seq_item_sb.data_out != data_out_ref) begin
          `uvm_error("run_phase", $sformatf("Mismatch: DUT=%0d, REF=%0d", 
                                            seq_item_sb.data_out, data_out_ref))
          error_count++;
        end 
	else begin
          correct_count++;
        end
      end
    endtask

    function void report_phase(uvm_phase phase);
      super.report_phase(phase);
      `uvm_info("report_phase", $sformatf("Correct transactions: %0d", correct_count), UVM_MEDIUM)
      `uvm_info("report_phase", $sformatf("Failed transactions: %0d", error_count), UVM_MEDIUM)
    endfunction


endclass

endpackage


