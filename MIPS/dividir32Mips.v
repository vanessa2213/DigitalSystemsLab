module dividir32Mips (
       input  [31:0] in,
       output [5:0]  out3126,
       output [5:0]  out50,
       output [4:0]  out2521,
       output [4:0]  out2016,
       output [4:0]  out1511,
       output [15:0] out150,
       output [25:0] out250);
		 
assign out3126 = in[31:26];
assign out50   = in[5:0];
assign out2521 = in[25:21];
assign out2016 = in[20:16];
assign out1511 = in[15:11];
assign out150  = in[15:0];
assign out250 = in[25:0];
endmodule
