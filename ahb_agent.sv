//=====================================ahb_agent=================================
class ahb_agent extends uvm_agent;

ahb_driver drv;
ahb_monitor mon;
ahb_sequencer seqr;

`uvm_component_utils(ahb_agent)

function new(string name="ahb_agent", uvm_component parent=null);
  super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(get_is_active() == UVM_ACTIVE) begin
    drv  = ahb_driver::type_id::create("drv", this);
    seqr = ahb_sequencer::type_id::create("seqr", this);
  end

  mon  = ahb_monitor::type_id::create("mon", this);
endfunction

function void connect_phase(uvm_phase phase);
  if(get_is_active() == UVM_ACTIVE)
    drv.seq_item_port.connect(seqr.seq_item_export);
endfunction

endclass

