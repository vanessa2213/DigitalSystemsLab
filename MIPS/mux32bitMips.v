module mux32bitMips(
							input selec,
							input [31:0]in1,
							input [31:0]in2,
							output reg [31:0]out);
    

always @ (*)
	begin
	if (selec)
		out = in2;
	else 
		out = in1;
	end
endmodule
