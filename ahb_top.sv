//=================================ahb_top====================================
module ahb_top;

  import uvm_pkg::*;
  import ahb_pkg::*;

  bit HCLK = 0;
  always #5 HCLK = ~HCLK;

  ahb_if vif(HCLK);
  ahb_slave dut(vif);

  initial begin
    vif.HRESETn = 0;

    uvm_config_db#(virtual ahb_if)::set(null,"*","vif",vif);

    run_test("ahb_test");   
  end
 
  initial begin
    #20;
    vif.HRESETn = 1;
  end

endmodule
