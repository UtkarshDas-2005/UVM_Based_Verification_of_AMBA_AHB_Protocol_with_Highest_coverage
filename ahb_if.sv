//=====================================ahb_if==================================
interface ahb_if(input logic HCLK);

  logic [31:0] HADDR;
  logic [31:0] HWDATA;
  logic [31:0] HRDATA;  
  logic HWRITE;
  logic HREADY;
  logic HRESETn;

  logic [1:0] HTRANS;
  logic [2:0] HBURST;
  logic [2:0] HSIZE;

  // Modports
  modport master(output HADDR, HWDATA, HWRITE, HTRANS, HSIZE, HBURST,
                 input HRDATA, HREADY, HRESETn);
  modport slave(input HADDR, HWDATA, HWRITE, HTRANS, HSIZE, HBURST,
                output HRDATA, HREADY, input HRESETn, HCLK);

endinterface
