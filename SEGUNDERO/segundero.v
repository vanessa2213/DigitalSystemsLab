module segundero(
						input button,
						input clk,
						output [7:0]HEX1,
						output [7:0]HEX0);
wire [25:0]sum;
wire [25:0]Q;
wire s,rst;
wire b,clo;
assign b = ~button;
comp18 c1(.n(Q), .s(s));
mux m1(.a(s), .b(b),.selec(b), .s(rst));
reg18 r1(.clk(clk), .D(sum), .Q(Q),.rst(rst));
assign sum= Q+1;

wire [7:0]sum1;
wire [7:0]Q1;
wire s1,rst1;
comp8 c8(.n(Q1), .s(s1));
mux m2(.a(s1), .b(b), .selec(b), .s(rst1));
reg8 r2(.clk(s), .D(sum1), .Q(Q1),.rst(rst1) );
assign sum1 =Q1+1;

toHex0 hex0(.num(Q1),.HEX0(HEX0));
toHex1 hex1(.num(Q1),.HEX1(HEX1));


endmodule

module toHex0(input [5:0]num,
					output reg [7:0]HEX0);
always @ (*)
begin
if(num==0 || num ==10 || num == 20 || num==30 || num==40 || num==50)
	HEX0=8'b11000000;
else if(num==1 || num ==11 || num == 21 || num==31 || num==41 || num==51)
	HEX0=8'b11111001;
else if(num==2 || num ==12 || num == 22 || num==32 || num==42 || num==52)
	HEX0=8'b10100100;
else if(num==3 || num ==13 || num == 23 || num==33 || num==43 || num==53)
	HEX0=8'b10110000;
else if(num==4 || num ==14 || num == 24 || num==34 || num==44 || num==54)
	HEX0=8'b10011001;
else if(num==5 || num ==15 || num == 25 || num==35 || num==45 || num==55)
	HEX0=8'b10010010;
else if(num==6|| num ==16 || num == 26 || num==36 || num==46 || num==56)
	HEX0=8'b10000010;
else if(num==7 || num ==17 || num == 27 || num==37 || num==47 || num==57)
	HEX0=8'b11111000;
else if(num==8 || num ==18 || num == 28 || num==38 || num==48 || num==58)
	HEX0=8'b10000000;
else if(num==9 || num ==19 || num == 29 || num==39 || num==49 || num==59)
	HEX0=8'b10011000;
end
endmodule

module toHex1(	input [5:0]num,
					output reg[7:0]HEX1);
always @ (*)
begin
	if (num==0 || num == 1||num==2||num==3||num==4||num==5||num==6||num==7||num==8||num==9)
		HEX1=8'b11000000;
	else if(num==10 || num == 11||num==12||num==13||num==14||num==15||num==16||num==17||num==18||num==19)
		HEX1=8'b11111001;
	else if(num==20 || num == 21||num==22||num==23||num==24||num==25||num==26||num==27||num==28||num==29)
		HEX1=8'b10100100;
	else if(num==30 || num == 31||num==32||num==33||num==34||num==35||num==36||num==37||num==38||num==39)
		HEX1=8'b10110000;
	else if(num==40 || num == 41||num==42||num==43||num==44||num==45||num==46||num==47||num==48||num==49)
		HEX1=8'b10011001;
	else if(num==50 || num == 51||num==52||num==53||num==54||num==55||num==56||num==57||num==58||num==59)
		HEX1=8'b10010010;
end
		
endmodule

module reg18(
				input clk,
				input rst,
				input [25:0]D,
				output reg [25:0]Q);
always @ (posedge clk or posedge rst)
	if (rst)
		Q<=26'd0;
	else 
		Q<=D;
endmodule

module reg8(
				input clk,
				input rst,
				input [7:0]D,
				output reg [7:0]Q);
always @ (posedge clk or posedge rst)
	if (rst)
		Q<=26'd0;
	else 
		Q<=D;
endmodule

module mux(	input a,
				input b,
				input selec,
				output reg s);

always @ (*)
	begin
		case(selec)
		
			1'b0: s=a;
			1'b1: s=b;
		
		endcase
	end
endmodule


module comp18(
				input [25:0]n,
				output reg s);
always @ (*)
begin
if (n==50000000)
	s=1;
else 
	s=0;
end
	
endmodule

module comp8(
				input [7:0]n,
				output reg s);
always @ (*)
begin
if (n==60)
	s=1;
else 
	s=0;
end
	
endmodule
