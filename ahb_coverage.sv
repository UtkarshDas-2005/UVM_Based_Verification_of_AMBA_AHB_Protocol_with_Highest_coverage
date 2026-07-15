//=====================================ahb_coverage=================================
class ahb_coverage extends uvm_component;

`uvm_component_utils(ahb_coverage)

uvm_analysis_imp #(ahb_transaction, ahb_coverage) imp;
ahb_transaction tr;

covergroup cg;

 // Address Coverage
 addr_cp: coverpoint tr.addr {
   bins low  = {[0:63]};
   bins mid1 = {[64:127]};
   bins mid2 = {[128:191]};
   bins high = {[192:255]};
 }

 // Read / Write Coverage
 write_cp: coverpoint tr.write_flag {
   bins READ  = {0};
   bins WRITE = {1};
 }

 // Transfer Size Coverage
 size_cp: coverpoint tr.size {
   bins BYTE = {3'b000};
   bins HALF = {3'b001};
   bins WORD = {3'b010};
 }

 // Burst Coverage
 burst_cp: coverpoint tr.burst {
   bins SINGLE = {3'b000};
   bins INCR4  = {3'b001};
 }

 // Cross Coverage
 cross write_cp, size_cp;
 cross write_cp, burst_cp;
 cross size_cp, burst_cp;

endgroup

function new(string name="ahb_coverage", uvm_component parent=null);
  super.new(name, parent);
  imp = new("imp", this);
  cg = new();
endfunction

function void write(ahb_transaction t);
 tr = t;
 cg.sample();
endfunction

endclass
