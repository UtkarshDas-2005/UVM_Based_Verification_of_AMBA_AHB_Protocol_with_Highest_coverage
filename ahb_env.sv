//===========================================ahb_env==================================
class ahb_env extends uvm_env;

`uvm_component_utils(ahb_env)

ahb_agent agent;
ahb_scoreboard sb;
ahb_coverage cov;

virtual ahb_if vif; 

function new(string name="ahb_env", uvm_component parent=null);
  super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);

    if(!uvm_config_db#(virtual ahb_if)::get(this, "", "vif", vif))
    `uvm_fatal("ENV","No vif")

  agent = ahb_agent::type_id::create("agent", this);
  sb    = ahb_scoreboard::type_id::create("sb", this);
  cov   = ahb_coverage::type_id::create("cov", this);

  uvm_config_db#(virtual ahb_if)::set(this, "agent.*", "vif", vif);

endfunction

function void connect_phase(uvm_phase phase);
  agent.mon.ap.connect(sb.imp);
  agent.mon.ap.connect(cov.imp);
endfunction

endclass

