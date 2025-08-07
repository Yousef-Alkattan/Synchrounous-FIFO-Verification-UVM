package fifo_env_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"
import fifo_agent_pkg::*;
import fifo_coverage_pkg::*;
import fifo_scoreboard_pkg::*;

  class fifo_env extends uvm_env;
    `uvm_component_utils(fifo_env)

    fifo_agent         m_agent;
    fifo_scoreboard    m_scoreboard;
    fifo_coverage      m_coverage;

    function new(string name = "fifo_env", uvm_component parent = null);
      	super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      	super.build_phase(phase);
      m_agent      = fifo_agent::type_id::create("m_agent", this);
      m_coverage   = fifo_coverage::type_id::create("m_coverage", this);
      m_scoreboard = fifo_scoreboard::type_id::create("m_scoreboard", this);
    
    endfunction
    
    function void connect_phase(uvm_phase phase);
      
      m_agent.agt_ap.connect(m_scoreboard.sb_export);
      m_agent.agt_ap.connect(m_coverage.cov_ap);

    endfunction
  
endclass

endpackage
