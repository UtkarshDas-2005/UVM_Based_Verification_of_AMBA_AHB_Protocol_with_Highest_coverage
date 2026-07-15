class ahb_transaction extends uvm_sequence_item;

  rand bit [31:0] addr;
  rand bit [31:0] data;
  rand bit write_flag;
  rand bit [2:0] burst;
  rand bit [2:0] size;

  bit [31:0] rdata;
  bit [1:0]  trans;   //  ADDED (CRITICAL)

  constraint size_c { size inside {3'b000,3'b001,3'b010}; }

  `uvm_object_utils(ahb_transaction)

  function new(string name="ahb_transaction");
    super.new(name);
  endfunction

endclass
