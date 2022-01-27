module romMips(
    input[4:0] address,
    output [31:0] data);
    
 wire [31:0] rom [31:0];
 
  assign rom[0] = 32'h8c010001;
  assign rom[1] = 32'h8c020002;
  assign rom[2] = 32'h8c030003;
  assign rom[3] = 32'h8c040004;
  assign rom[4] = 32'h8c050005;
  assign rom[5] = 32'h8c060006;
  assign rom[6] = 32'h8c070007;
  assign rom[7] = 32'h8c080008;
  assign rom[8] = 32'h8c090009;
  assign rom[9] = 32'h8c0a000a;
  assign rom[10] =32'h00220018;
  assign rom[11] =32'h00640018;
  assign rom[12] =32'h00a60018;
  assign rom[30] =32'h8c1e001e;
  assign rom[31] =32'h8c1f001f;

  assign data = rom[address];
  
endmodule
