function void write(ahb_transaction tr);

  //================ BURST TRACKING =================
  if(tr.trans == 2'b10) begin // NONSEQ
    burst_active = 1;
    burst_count  = 1;
    base_addr    = tr.addr;
  end

  else if(tr.trans == 2'b11 && burst_active) begin // SEQ
    burst_count++;

    if(tr.addr != (base_addr + (burst_count-1)*(1<<tr.size))) begin
      `uvm_error("BURST_ERR",
        $sformatf("Address mismatch EXP=%h GOT=%h",
        base_addr + (burst_count-1)*(1<<tr.size), tr.addr))
    end

    if(tr.burst == 3'b001 && burst_count > 4) begin
      `uvm_error("BURST_ERR","INCR4 exceeded")
    end
  end

  else begin
    burst_active = 0;
    burst_count  = 0;
  end


  //================ WRITE =================
  if(tr.write_flag) begin
    model_mem[tr.addr[7:0]] = tr.data;
  end

  //================ READ =================
  else begin
    if(model_mem[tr.addr[7:0]] === tr.rdata)
      pass++;
    else begin
      fail++;
      `uvm_error("SB_FAIL",
        $sformatf("EXP=%h GOT=%h",
        model_mem[tr.addr[7:0]], tr.rdata))
    end
  end

endfunction
