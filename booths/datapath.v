module datapath(
						input [7:0]Q,
						input [7:0]M,
						input mux_e,
						input clr,
						input clk,
						input ld,
						input sh,
						output done,
						output [16:0]Sh_out);

wire [16:0]in1_mux1;
wire [16:0]shift_out;
wire [7:0]mux_169;

assign in1_mux1[0] = 0;
assign in1_mux1[8:1]=Q;
assign in1_mux1[16:9]=0;

wire [16:0]in0_mux1;
assign in0_mux1[8:0] = shift_out[8:0];
assign in0_mux1[16:9] = mux_169;

wire [16:0]mux1_out;

assign mux1_out = (mux_e)?in1_mux1:in0_mux1;

shiftreg shi(.clk(clk),.rst(clr),.load(ld),.data(mux1_out),.shren(sh),.din(mux1_out[16]),.dout(shift_out));

wire don;
wire [4:0]sum_count;
wire [4:0]D_count;
reg [4:0]Q_count;
wire en;
assign en = ~don;

assign D_count = Q_count +1;
assign don = (Q_count==19)?1:0;

always @ (posedge clk)
	if(en)
		Q_count<=D_count;
	else
		Q_count <= Q_count;

assign done = don;

reg [16:0]Q_shift;

always @ (posedge clk)
begin
	if(en)
		Q_shift <= shift_out;
end
assign done = don;
assign Sh_out = Q_shift;

wire [7:0]sum1;
assign sum1 = ~M +1;
wire [7:0]mux1_Sum;
assign mux1_Sum = (shift_out[1])?sum1:M;
wire [7:0]sum2;
assign sum2 = mux1_Sum + shift_out[16:9];

wire xor_out;
assign xor_out = shift_out[1] | shift_out[0];


assign mux_169 = (xor_out)?sum2 : shift_out[16:9];




endmodule
