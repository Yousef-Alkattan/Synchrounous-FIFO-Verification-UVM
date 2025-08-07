package fifo_driver_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"
import fifo_config_pkg::*;
import fifo_sequence_item_pkg::*;

class fifo_driver extends uvm_driver #(fifo_sequence_item);
    `uvm_component_utils(fifo_driver)

    virtual interface FIFO_interface fifo_driver_vif;
    fifo_config fifo_cfg;
    fifo_sequence_item req;

    function new(string name = "fifo_driver", uvm_component parent = null);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if (!uvm_config_db#(fifo_config)::get(this, "", "CFG", fifo_cfg))
        `uvm_fatal("build_phase", "Virtual interface not found for fifo_driver")
    endfunction

function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  fifo_driver_vif = fifo_cfg.fifo_vif;
endfunction

    task run_phase(uvm_phase phase);
  	super.run_phase(phase);
      
      forever begin
	req = fifo_sequence_item::type_id::create("req");
	seq_item_port.get_next_item(req);

        fifo_driver_vif.wr_en = req.wr_en;
        fifo_driver_vif.rd_en = req.rd_en;
	fifo_driver_vif.rst_n = req.rst_n;
        fifo_driver_vif.data_in = req.data_in;

	@(negedge fifo_driver_vif.clk);
	seq_item_port.item_done();
      end
    endtask

  endclass

endpackage
