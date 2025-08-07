package fifo_monitor_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import fifo_sequence_item_pkg::*;

  class fifo_monitor extends uvm_monitor;
    `uvm_component_utils(fifo_monitor)

    virtual interface FIFO_interface fifo_mon_vif;
    fifo_sequence_item item;
    uvm_analysis_port#(fifo_sequence_item) mon_ap;
    
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      	super.build_phase(phase);
	mon_ap = new("mon_ap", this);
    endfunction

    task run_phase(uvm_phase phase);
      forever begin
        item = fifo_sequence_item::type_id::create("item", this);
        @(negedge fifo_mon_vif.clk);
        item.data_in         = fifo_mon_vif.data_in;
        item.rst_n         = fifo_mon_vif.rst_n;
        item.wr_en       = fifo_mon_vif.wr_en;
        item.rd_en  = fifo_mon_vif.rd_en;
        item.data_out  = fifo_mon_vif.data_out;
        item.wr_ack  = fifo_mon_vif.wr_ack;
        item.overflow  = fifo_mon_vif.overflow;
        item.underflow  = fifo_mon_vif.underflow;
        item.full = fifo_mon_vif.full;
        item.empty = fifo_mon_vif.empty;
        item.almostfull = fifo_mon_vif.almostfull;
        item.almostempty = fifo_mon_vif.almostempty;
        mon_ap.write(item);
      end
    endtask
  endclass

endpackage
