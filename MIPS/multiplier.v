
module multiplier(
							output reg [63:0] prod,
							output busy,
							input [31:0] mc, 
							input [31:0] mp,
							input clk,
							input rst,
							input start);
reg [31:0] A, Q, M;
reg Q_1;
reg [5:0] count;

wire [31:0] sum, difference;

always @(posedge clk or posedge start)
begin
   if (start) begin
      A <= 32'b0;      
      M <= mc;
      Q <= mp;
      Q_1 <= 1'b0;      
      count <= 6'b0;
   end
	
   else if(busy) begin
      case ({Q[0], Q_1})
         2'b0_1 : {A, Q, Q_1} <= {sum[31], sum, Q};
         2'b1_0 : {A, Q, Q_1} <= {difference[31], difference, Q};
         default: {A, Q, Q_1} <= {A[31], A, Q};
      endcase
      count <= count + 1;
   end
end

alu adder (sum, A, M, 0);
alu subtracter (difference, A, ~M, 1);


assign busy = (count <32);
/*always @ (posedge clk)
	if(~busy)
		busy_c <= busy_c + 1
	else  if (rst)
		busy_c <= 0;
	else
		busy_c <= busy_c*/
always @ (*)
	if (~busy)
		prod <= {A, Q};
	else if(rst)
		prod <= 0;
	else
		prod <= prod;
		
endmodule

//The following is an alu, an adder, but capable of subtraction:

module alu(out, a, b, cin);
output [31:0] out;
input [31:0] a;
input [31:0] b;
input cin;

assign out = a + b + cin;

endmodule

