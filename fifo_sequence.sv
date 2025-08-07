package fifo_sequence_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import fifo_sequence_item_pkg::*;

  class fifo_sequence extends uvm_sequence#(fifo_sequence_item);
    `uvm_object_utils(fifo_sequence)
      fifo_sequence_item req;

    function new(string name = "fifo_sequence");
      super.new(name);
    endfunction

    task body();

      req = fifo_sequence_item::type_id::create("req");
 
     repeat (1000) begin
        start_item(req);
        assert(req.randomize() with { wr_en == 1; rd_en == 0; } );
        finish_item(req);
    end

      repeat (1000) begin
        start_item(req);
        assert(req.randomize() with { wr_en == 0; rd_en == 1; } );
        finish_item(req);
    end


      repeat (2000) begin
        start_item(req);
        assert(req.randomize() );
        finish_item(req);
    end
    endtask

  endclass

endpackage
