package fifo_reset_sequence_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import fifo_sequence_item_pkg::*;

  class fifo_reset_sequence extends uvm_sequence#(fifo_sequence_item);
    `uvm_object_utils(fifo_reset_sequence)
      fifo_sequence_item req;

    function new(string name = "fifo_reset_sequence");
      super.new(name);
    endfunction

    task body();

      req = fifo_sequence_item::type_id::create("req");
        start_item(req);
	req.rst_n=0;
        finish_item(req);

    endtask

  endclass

endpackage