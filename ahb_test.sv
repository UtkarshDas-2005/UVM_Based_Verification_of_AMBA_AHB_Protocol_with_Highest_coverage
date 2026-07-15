//===================================ahb_test==================================
class ahb_test extends uvm_test;

`uvm_component_utils(ahb_test)

ahb_env env;
ahb_sequence seq;

function new(string name="ahb_test", uvm_component parent=null);
  super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
 env = ahb_env::type_id::create("env", this);
 uvm_config_db#(uvm_active_passive_enum)::set(this, "env.agent", "is_active", UVM_ACTIVE);
endfunction

task run_phase(uvm_phase phase);

 phase.raise_objection(this);

 seq = ahb_sequence::type_id::create("seq");
 `uvm_info("TEST", "Starting sequence", UVM_LOW)
seq.start(env.agent.seqr);

#1000;
 phase.drop_objection(this);

endtask
endclass
