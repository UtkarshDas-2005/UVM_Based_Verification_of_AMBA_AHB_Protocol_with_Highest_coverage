task run_phase(uvm_phase phase);

  ahb_transaction tx;

  bit [31:0] addr_q;
  bit write_q;
  bit [2:0] size_q, burst_q;
  bit [1:0] trans_q;
  bit valid_q;

  forever begin

    // ADDRESS PHASE
    @(posedge vif.HCLK);

    if(vif.HREADY && vif.HTRANS[1]) begin
      addr_q  = vif.HADDR;
      write_q = vif.HWRITE;
      size_q  = vif.HSIZE;
      burst_q = vif.HBURST;
      trans_q = vif.HTRANS;
      valid_q = 1;
    end
    else valid_q = 0;

    // DATA PHASE
    @(posedge vif.HCLK);
    while(!vif.HREADY) @(posedge vif.HCLK);

    if(valid_q) begin

      tx = ahb_transaction::type_id::create("tx");

      tx.addr       = addr_q;
      tx.write_flag = write_q;
      tx.size       = size_q;
      tx.burst      = burst_q;
      tx.trans      = trans_q;

      if(write_q)
        tx.data = vif.HWDATA;
      else
        tx.rdata = vif.HRDATA;

      ap.write(tx);
    end
  end
endtask
