module shiftreg2( input 		 clk,
						input  [7:0] data,
						input        rst,
						input 		 shren,
						output  [7:0]dout0,
						output  [7:0]dout1,
						output  [7:0]dout2,
						output  [7:0]dout3,
						output  [7:0]dout4,
						output  [7:0]dout5);
	
reg [5:0] sreg [7:0];
always @ (posedge clk)
		 if (rst)
		 begin
			sreg[5]<= 8'd0;
			sreg[4]<= 8'd0;
			sreg[3]<= 8'd0;
			sreg[2]<= 8'd0;
			sreg[1]<= 8'd0;
			sreg[0]<= 8'd0;
			end
		 else if (shren)
		 begin
			sreg[5]<= sreg[4];
			sreg[4]<= sreg[3];
			sreg[3]<= sreg[2];
			sreg[2]<= sreg[1];
			sreg[1]<= sreg[0];
			sreg[0]<= data;
		end
 assign dout0 = sreg[0];
 assign dout1 = sreg[1];
 assign dout2 = sreg[2];
 assign dout3 = sreg[3];
 assign dout4 = sreg[4];
 assign dout5 = sreg[5];
 
endmodule