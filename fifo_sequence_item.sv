package fifo_sequence_item_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  class fifo_sequence_item extends uvm_sequence_item;
    `uvm_object_utils(fifo_sequence_item)

    parameter FIFO_WIDTH = 16;
    parameter FIFO_DEPTH = 8;
    parameter RD_EN_ON_DIST = 30;
    parameter WR_EN_ON_DIST = 70;

    // FIFO inputs and outputs
    rand bit [FIFO_WIDTH-1:0] data_in;
    rand bit rst_n, wr_en, rd_en;
    bit [FIFO_WIDTH-1:0] data_out;
    bit wr_ack, overflow;
    bit full, empty, almostfull, almostempty, underflow;

    // Constraint 1
    constraint reset_less_often {
        rst_n dist {1 := 99, 0 := 1};
    }

    // Constraint 2:
    constraint wr_en_distribution {
        wr_en dist {1 := WR_EN_ON_DIST, 0 := 100 - WR_EN_ON_DIST};
    }

    // Constraint 3:
    constraint rd_en_distribution {
        rd_en dist {1 := RD_EN_ON_DIST, 0 := 100 - RD_EN_ON_DIST};
    }

    function new(string name = "fifo_sequence_item");
      super.new(name);
    endfunction
  
  endclass

endpackage
