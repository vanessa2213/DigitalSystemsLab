module top(	
				input  fpgaclk,
				input  ps2clk,
				input  rst,
				input  datain,
				output [7:0]scancode,
				output [6:0]HEX1,
				output [6:0]HEX2,
				output [6:0]HEX3,
				output [6:0]HEX4,
				output [6:0]HEX5,
				output [6:0]HEX6);
reg clr;
wire [5:0]cout;
wire comp;
wire comp1;
wire rstreg;
reg Qen;
reg [7:0]Q;
reg [7:0]Q2;
wire [10:0]Qreg;
wire [10:0]Qreg0;
wire midout;
wire [5:0]count;
reg [5:0]Qcomp;
wire [7:0]segments0;
wire [7:0]segments1;
wire [7:0]segments2;
wire [7:0]segments3;
wire [7:0]segments4;
wire [7:0]segments5;

shiftreg sfre(.clk(~ps2clk),.rst(~rst),.shren(1),.din(datain),.dout(Qreg0));
assign Qreg = Qreg0[7:2];		
counter c1(.clk(ps2clk),.clr(clr), .rst(~rst),.cout(cout));	
assign comp = (cout == 6'h0a)?1'b1:1'b0;

always @ (posedge fpgaclk)
	begin
		if (fpgaclk)
			Qen <= comp;
		else 
			Qen <= Qen;
	end
	
always @ (posedge fpgaclk)
	begin
		if (fpgaclk)
			clr <= Qen;
		else
			clr <= clr;
	end		

synch s1(.ps2clk(ps2clk),.fpgclk(fpgaclk), .rst(~rst),.midout(midout),.count(count));
always @ (posedge fpgaclk)
	begin
		if (fpgaclk)
			Qcomp <= count;
		else
			Qcomp <= Qcomp;
	end
assign rstreg = (Qcomp == 6'h21)?1'b1:1'b0;

always @ (posedge fpgaclk or posedge rstreg)
	begin
		if (rstreg)
			Q<= 8'd0;
		else if (Qen)
			Q<=Qreg;
		else
			Q<=Q;
	end					

assign comp1 = (Q==8'hf0)?1'b0:1'b1;

always @ (posedge fpgaclk or posedge rstreg)
	begin
		if (rstreg)
			Q2 <= 8'd0;
		else if (comp1)
			Q2<=Q;
		else 
			Q2 <=Q2;
	end

		
shiftreg2 s2(.clk(fpgaclk),.data(Q2),.shren(midout),.dout0(segments0),.dout1(segments1),.dout2(segments2),.dout3(segments3),.dout4(segments4),.dout5(segments5));

decoder d1(.in(segments0),.outSeg(HEX1));
decoder d2(.in(segments1),.outSeg(HEX2));
decoder d3(.in(segments2),.outSeg(HEX3));
decoder d4(.in(segments3),.outSeg(HEX4));
decoder d5(.in(segments4),.outSeg(HEX5));
decoder d6(.in(segments5),.outSeg(HEX6));
assign scancode = Q;
endmodule