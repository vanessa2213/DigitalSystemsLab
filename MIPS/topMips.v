module topMips( input clk,
                 input rst,
					  input sM,
					  input [31:0]Data,
					  input enReg,
					  input [2:0]selecMuxi,
					  output mult,
					  output [31:0]ReadData1,
					  output [31:0]ReadData2);


wire [31:0] datarom;
wire [4:0]Q;

wire [5:0]out3126;
wire [5:0]out50;
wire [4:0]out2521;
wire [4:0]out2016;
wire [4:0]out1511;
wire [15:0]out150;
wire [25:0]out250;

wire RegDsto, Brancho, MemReado, MemtoRego, MemWriteo, ALUSrco, RegWriteo, Jumpo;
wire [4:0]WriteRegister;
wire [31:0]ReadData1o;
wire [31:0]ReadData2o;
wire [31:0]bitexto;
wire [31:0]Bwire;
wire [2:0]selecALU;
wire zeroOut;
wire [31:0]Reout;
wire [4:0]ReBiou;
wire [31:0]readDataoM;
wire [31:0]WriteData;
wire selec;

wire [4:0]sum;
wire [4:0]sum2;
wire [4:0] bitext2;
wire [4:0]D;
wire [4:0]mux52;
wire [4:0]redbit250;
reg [4:0]aMux;
reg [31:0]WriteDataf;

always @ (*)
	 begin
		if(selecMuxi == 3'd0)
			aMux = Q;
		else if(selecMuxi == 3'd3)
			aMux = 5'h1e;
		else if(selecMuxi == 3'd4)
			aMux = 5'h1f;
	end

romMips        r1( .address(aMux), .data(datarom));
dividir32Mips d32(.in(datarom), .out3126(out3126), .out50(out50), .out2521(out2521), .out2016(out2016), .out1511(out1511), .out150(out150), .out250(out250));
controlMips    co(.in3126(out3126),.in50(out50), .Mult(mult),  .RegDst(RegDsto), .Branch(Brancho), .MemRead(MemReado), .MemtoReg(MemtoRego), .MemWrite(MemWriteo), .ALUSrc(ALUSrco), .RegWrite(RegWriteo), .Jump(Jumpo));
mux5bitMips    m5(.selec(RegDsto), .in1(out2016), .in2(out1511), .out(WriteRegister)) ;

always @ (*)
	begin 
		if(sM)
			WriteDataf = Data;
		else 
			WriteDataf = WriteData;
	end

RegistersMips re2(.rst(rst), .writeData(WriteDataf),.writeEnable(RegWriteo), .readAddress1(out2521), .readAddress2(out2016), .writeAddress(WriteRegister), .clk(clk), .readData1(ReadData1o), .readData2(ReadData2o));
bitExtMips     bE(.num(out150), .numo(bitexto));
mux32bitMips  m32(.selec(ALUSrco), .in1(ReadData2o), .in2(bitexto), .out(Bwire));
ALUControlMips ac(.bit3126(out3126), .bit50(out50), .selec(selecALU));
ALUMips        al(.A(ReadData1o), .B(Bwire), .selMux(selecALU), .zero(zeroOut), .R(Reout));
ReducirBitMips rb(.num(Reout), .numo(ReBiou));
dataMemoryMips dm(.address(ReBiou), .writedata(ReadData2o), .memwr(MemWriteo), .memrd(MemReado), .clk(clk), .readData(readDataoM));
mux32bitMips   m2(.selec(MemtoRego), .in1(Reout), .in2(readDataoM), .out(WriteData));

ReducirBitMips rb1(.num(bitexto), .numo(bitext2));

assign sum = Q + 1;
assign sum2= bitext2 + sum;
assign selec = zeroOut & Brancho;

mux5bitMips m52(.selec(selec), .in1(sum), .in2(sum2), .out(mux52));
reducirBit26Mips r26(.num(out250), .numo(redbit250));
mux5bitMips m522(.selec(Jumpo), .in1(mux52), .in2(redbit250), .out(D));

registerMips re( .D(D), .clk(clk), .rst(rst),.en(enReg),.Q(Q));

assign ReadData1 = ReadData1o;
assign ReadData2 = ReadData2o;

endmodule

