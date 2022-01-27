module mux5bitMips(
							input selec,
							input [4:0]in1,
							input [4:0]in2,
							output reg[4:0]out);
always @ (*)
	begin
	if (selec)
		out = in2;
	else 
		out = in1;
	end
 
endmodule