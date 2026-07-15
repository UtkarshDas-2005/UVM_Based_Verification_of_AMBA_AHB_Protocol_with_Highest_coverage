//====================================ahb_slave===============================
module ahb_slave(ahb_if vif);

  logic [31:0] mem [0:255];

  logic [31:0] addr_reg;
  logic write_reg;

  initial begin
    vif.HREADY = 1;
    vif.HRDATA = 0;
  end

always @(posedge vif.HCLK) begin

  if(!vif.HRESETn) begin
    vif.HRDATA <= 0;
    vif.HREADY <= 1;
  end
  else begin

    // Default ready
    vif.HREADY <= 1;

    // VALID TRANSFER
    if(vif.HTRANS[1]) begin

      if(vif.HWRITE) begin
        // WRITE
        mem[vif.HADDR[7:0]] <= vif.HWDATA;

        $display("SLAVE WRITE: ADDR=%h DATA=%h",
                  vif.HADDR, vif.HWDATA);
      end
      else begin
        // READ (FIXED TIMING)
        vif.HRDATA <= mem[vif.HADDR[7:0]];

        $display("SLAVE READ: ADDR=%h DATA=%h",
                  vif.HADDR, mem[vif.HADDR[7:0]]);
      end

    end

  end

end
endmodule
