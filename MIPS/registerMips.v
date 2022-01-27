module registerMips ( input [4:0]D,
							 input clk,
							 input rst,
							 input en,
							 output reg[4:0]Q);
       
always @ (posedge clk or posedge rst)
 if (rst)
  Q<=0;
 else if (en)
  Q<=D;
 else 
	Q<=Q;
  
endmodule
