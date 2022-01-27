module updocount( 
			input 				clk,
			input 				sw,
			input 				rst,
			output  reg [3:0] count,
			output 				tc);
wire [3:0] sum;
wire [3:0] x;
assign sum  = (~~sw)? count + 1 : count-;

always @ (posedge clk)
	if (rst)
		count <= 0;
	else 
		count <=sum;
assign x = (~sw)? 4'hF : 4'h0;	
assign tc = (count==x);
endmodule 