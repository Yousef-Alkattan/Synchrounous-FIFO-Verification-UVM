package fifo_test_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import fifo_env_pkg::*;
import fifo_config_pkg::*;
import fifo_sequence_pkg::*;
import fifo_reset_sequence_pkg::*;

class fifo_test extends uvm_test;
   `uvm_component_utils(fifo_test)
    
    fifo_env env;
    fifo_config fifo_cfg;
    fifo_sequence seq1;
    fifo_reset_sequence seq2;

    function new(string name = "fifo_test", uvm_component parent = null);
      	super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      	super.build_phase(phase);
      	env = fifo_env::type_id::create("env", this);
	fifo_cfg = fifo_config::type_id::create("fifo_cfg");
	seq1 = fifo_sequence::type_id::create("seq1");
	seq2 = fifo_reset_sequence::type_id::create("seq2");
      	
	if (!uvm_config_db#(virtual FIFO_interface)::get(this, "", "fifo_vif", fifo_cfg.fifo_vif))
        `uvm_fatal("VIF_GET", "Failed to get virtual interface in fifo_test")

      	uvm_config_db#(fifo_config)::set(this, "*", "CFG", fifo_cfg);
    endfunction

    task run_phase(uvm_phase phase);
	super.run_phase(phase);
      	phase.raise_objection(this);
      	`uvm_info("FIFO_TEST", "Inside the Fifo test", UVM_MEDIUM)
	
	seq2.start(env.m_agent.m_sequencer);
	seq1.start(env.m_agent.m_sequencer);

      	phase.drop_objection(this);
    endtask

endclass

endpackage
