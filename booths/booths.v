module booths(
					input go,
					input [7:0]M,
					input [7:0]Q,
					input clk,
					output done,
					output [16:0]Result);
					
wire [1:0]D;
reg [1:0]Qreg;
wire N0,N1,S0,S1;
wire don,muxe, ld, sh,clr;
assign D[0] = N0;
assign D[1] = N1;

controller c1(.go(go),.S1(S1),.S0(S0),.muxe(muxe),.ld(ld),.sh(sh),.N0(N0),.N1(N1),.clr(clr));
datapath   dp(.Q(Q),.M(M),.mux_e(muxe),.clr(clr),.clk(clk),.ld(ld),.sh(sh),.done(don),.Sh_out(Result));

always @ (posedge clk )
	begin
	if(~don)
		Qreg <= D;
	else
		Qreg <=0;
	end
	



assign done=don;
endmodule