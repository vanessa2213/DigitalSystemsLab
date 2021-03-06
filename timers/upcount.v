module upcount( 
			input 				clk,
			input 				rst,
			output  reg [3:0] count,
			output 				tc);
wire [3:0] sum;
assign sum  = count +1;

always @ (posedge clk)
	if (rst)
		count <= 0;
	else 
		count <=sum;
assign tc = &count;
endmodule 