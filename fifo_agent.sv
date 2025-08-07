package fifo_agent_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import fifo_config_pkg::*;
  import fifo_sequence_item_pkg::*;
  import fifo_sequencer_pkg::*;
  import fifo_driver_pkg::*;
  import fifo_monitor_pkg::*;

  class fifo_agent extends uvm_agent;
    `uvm_component_utils(fifo_agent)

    fifo_driver    m_driver;
    fifo_monitor   m_monitor;
    fifo_sequencer m_sequencer;
    fifo_config fifo_cfg;
    uvm_analysis_port #(fifo_sequence_item) agt_ap;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      if (!uvm_config_db#(fifo_config)::get(this, "", "CFG", fifo_cfg))
        `uvm_fatal("AGENT_VIF", "Failed to get fifo_vif")

      m_driver    = fifo_driver::type_id::create("m_driver", this);
      m_monitor   = fifo_monitor::type_id::create("m_monitor", this);
      m_sequencer = fifo_sequencer::type_id::create("m_sequencer", this);
      agt_ap = new("agt_ap", this);
    endfunction

    function void connect_phase(uvm_phase phase);
      	super.connect_phase(phase);
	m_driver.fifo_driver_vif = fifo_cfg.fifo_vif;
	m_monitor.fifo_mon_vif = fifo_cfg.fifo_vif;
      	m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
	m_monitor.mon_ap.connect(agt_ap);
    endfunction
  endclass

endpackage