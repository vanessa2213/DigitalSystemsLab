module ReducirBitMips(
       input [31:0]num,
       output [4:0] numo);
		 
 assign numo = num[4:0];
 
endmodule