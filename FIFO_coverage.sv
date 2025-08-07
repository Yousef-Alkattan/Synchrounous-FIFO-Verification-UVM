package fifo_coverage_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import fifo_sequence_item_pkg::*;

class fifo_coverage extends uvm_component;
  `uvm_component_utils(fifo_coverage)

  uvm_analysis_export #(fifo_sequence_item) cov_ap;
  uvm_tlm_analysis_fifo #(fifo_sequence_item) cov_fifo;
  fifo_sequence_item item;

  // Mirror interface signals here
    logic wr_en, rd_en;

    logic wr_ack, overflow;
    logic full, empty, almostfull, almostempty, underflow;


  covergroup CVG;

    // Coverpoints
    wr_en_cp:     	coverpoint wr_en { bins active = {1}; bins inactive = {0}; }
    rd_en_cp:     	coverpoint rd_en { bins active = {1}; bins inactive = {0}; }

    wr_ack_cp:    	coverpoint wr_ack { bins active = {1}; bins inactive = {0}; }
    full_cp:      	coverpoint full { bins active = {1}; bins inactive = {0}; }
    empty_cp:     	coverpoint empty { bins active = {1}; bins inactive = {0}; }
    almostfull_cp:  	coverpoint almostfull { bins active = {1}; bins inactive = {0}; }
    almostempty_cp: 	coverpoint almostempty { bins active = {1}; bins inactive = {0}; }
    underflow_cp:    	coverpoint underflow {bins active = {1};bins inactive = {0}; }
    overflow_cp:     	coverpoint overflow {bins active = {1};bins inactive = {0}; }

    // 7 required cross coverages
    cross_wr_rd_wrack:        cross wr_en_cp, rd_en_cp, wr_ack_cp;
    cross_wr_rd_full:         cross wr_en_cp, rd_en_cp, full_cp;
    cross_wr_rd_empty:        cross wr_en_cp, rd_en_cp, empty_cp;
    cross_wr_rd_almostfull:   cross wr_en_cp, rd_en_cp, almostfull_cp;
    cross_wr_rd_almostempty:  cross wr_en_cp, rd_en_cp, almostempty_cp;
    cross_wr_rd_underflow:   cross wr_en_cp, rd_en_cp, underflow_cp;
    cross_wr_rd_overflow:  cross wr_en_cp, rd_en_cp, overflow_cp;

  endgroup

  function new(string name = "fifo_coverage", uvm_component parent = null);
    super.new(name, parent);
    CVG = new();
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cov_ap = new("cov_ap", this);
    cov_fifo = new("cov_fifo", this);

  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    cov_ap.connect(cov_fifo.analysis_export);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      cov_fifo.get(item);

      wr_en          = item.wr_en;
      rd_en          = item.rd_en;
      wr_ack         = item.wr_ack;
      overflow       = item.overflow;
      full  	     = item.full;
      empty          = item.empty;
      almostfull     = item.almostfull;
      almostempty    = item.almostempty;
      underflow      = item.underflow;

      CVG.sample(); 

    end
  endtask

endclass

endpackage




