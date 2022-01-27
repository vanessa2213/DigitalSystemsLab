module top(	input clk, 
				input rstM,
				output fullq2,
				output fullq1,
				output emptyq2,
				output emptyq1);

wire mult;
wire [31:0]RD1;
wire [31:0]RD2;
wire [31:0]rd2o;
wire [31:0]rd1o;
reg rst;
reg [4:0]Q1;
reg [2:0]Q26;
reg compaTiene;
reg compa2;
reg [4:0]Qque;
//reg compaqueue;
reg [31:0]Qrd2;
reg [31:0]Qrd1;
wire don;
wire [63:0]outBoothsg;
wire [31:0]outBooths1;
wire [31:0]outBooths2;
reg [31:0]QB1;
reg [31:0]QB2;
reg [31:0]muxW;
reg Q_0;
reg Q_1;
reg Q_2;
reg Q_3;
reg Q_4;
wire bus;
wire ORout;
reg [31:0]QW;
reg clk2;
reg done;
reg pop_sign;
reg start_mult;
reg sM;

//registro que va al comparador tiene que ser 31
always @ (posedge clk)
	begin
		if (mult)
			Q1 <= Q1+5'd1;
		else if(rst)
			Q1 <= 5'd0;
		else if(rstM)
			Q1<=5'd0;
		else
			Q1 <= Q1;
	end
//comparador tiene que ser 31
always @ (*)
	begin
	if(Q1 > 5'd1)
		compaTiene = 1'b1;
	else
		compaTiene = 1'b0;
	end
//registro que va a los comparadores 2 y 6
always @ (posedge clk)
	begin
		if (compaTiene)
			Q26 <= Q26+3'd1;
		else if(rst)
			Q26 <= 3'd0;
		else if(rstM)
			Q26<=3'd0;
		else
			Q26 <= Q26;
	end
//comparador 6 = rst	
always @ (*)
	begin
	if(Q26 ==  3'd6)
		rst = 1'b1;
	else
		rst = 1'b0;
	end
// comparador 2
always @ (*)
	begin
	if(Q26 ==  3'd2)
		compa2 = 1'b1;
	else
		compa2 = 1'b0;
	end
	
always @ (posedge clk)
			if(rstM)
				clk2 <= 0;
			else if (clk)
				clk2 <= ~clk2;
			else
				clk2 <= clk2;	
always @ (posedge clk or posedge rstM)	
				if(rstM)
					sM <=0;
				else if(don)
					sM <= 1;
				else
					sM <= sM;
					
topMips mips(.clk(clk2),.rst(rstM), .sM(sM), .Data(outBooths1),.enReg(~ORout),.selecMuxi(Q26), .mult(mult), .ReadData1(RD1), .ReadData2(RD2));
				
//assign clk2 = ~clk;

//registro comparador queues

always @ (posedge clk)
	begin
		if (mult)
			Qque <= Qque+4'd1;
		else if(compa2)
			Qque <= 4'd0;
		else if(rstM)
			Qque<=4'd0;
		else
			Qque <= Qque;
	end

//comparador queues 
always @ (*)
	begin
	if(Qque < 2)
		pop_sign <= Qque;
	else
		pop_sign <= don;
	end

//registro queue readdata2
always @ (posedge clk or posedge rstM)
	begin
		if (rstM)
			Qrd2 <= 32'd0;
		else if(clk)
			Qrd2 <= RD2;
		else
			Qrd2 <= Qrd2;
	end
	
queue qrd2(.clk(clk),.pop(pop_sign),.writeData(Qrd2),.push(mult),.rst(rstM),.full(fullq2),.empty(emptyq2),.readData1(rd2o));

//registro queue readdata1
always @ (posedge clk or posedge rstM)
	begin
		if (rstM)
			Qrd1 <= 32'd0;
		else if(clk)
			Qrd1 <= RD1;
		else
			Qrd1 <= Qrd1;
	end
queue qrd1(.clk(clk),.pop(pop_sign),.writeData(Qrd1),.push(mult),.rst(rstM),.full(fullq1),.empty(emptyq1),.readData1(rd1o));
 
 //comparador despues del comparador de queues
 always @ (*)
	begin
	if(Qque > 5'd1)
		done = 1'b1;
	else
		done = 1'b0;
	end



always @ (posedge clk)
	begin 
		if(Qque < 2)
			start_mult = mult;
		else
			start_mult = pop_sign;
	end
	
multiplier  booth(.prod(outBoothsg),.busy(bus),.mc(rd1o), .mp(rd2o),.clk(clk), .rst(rstM),.start(start_mult));

assign don = ~bus;

assign outBooths1 = outBoothsg[31:0];
assign outBooths2 = outBoothsg[63:32];

//registro 1 de output1 booths
always @ (posedge clk or posedge rstM)
	begin
		if(rstM)
			QB1 <= 32'd0;
		else if (don)
			QB1 <= outBooths1;
		else
			QB1 <= QB1;
	end

//registro 2 de output 2 booths
always @ (posedge clk)
	begin
		if (don)
			QB2 <= outBooths2;
		else if(rstM)
			QB2 <= 32'd0;
		else
			QB2 <= QB2;
	end
//registros para mux que escribe el resultado
always @ (posedge clk or posedge rstM)
	begin
		if (clk)
			Q_0<= ~Q_2;
		else if(rstM)
			Q_0 <= 1'b0;
		else
			Q_0 <= Q_0;
	end

always @ (posedge clk or posedge rstM)
	begin
		if (rstM)
			Q_1<= 1'b0;
		else if(clk)
			Q_1 <= Q_0;
		else
			Q_1 <= Q_1;
	end

always @ (posedge clk or posedge rstM)
	begin
		if (clk)
			Q_2<= Q_1;
		else if(rstM)
			Q_2 <= 1'b0;
		else
			Q_2 <= Q_2;
	end
/*always @ (posedge clk or posedge rstM)
	begin
		if (clk)
			Q_3<= Q_2;
		else if(rstM)
			Q_3<= 1'b0;
		else
			Q_3 <= Q_3;
	end
always @ (posedge clk or posedge rstM)
	begin
		if (clk)
			Q_4<= Q_4;
		else if(rstM)
			Q_4<= 1'b0;
		else
			Q_4 <= Q_4;
	end*/
		
//mux para escribir resultado
always @ (*)
	begin
		if(Q_1)
			muxW = outBooths2;
		else
			muxW = outBooths1;
	end
//registro despues de mux 
/*always @ (posedge clk or posedge rstM)
	begin
		if (rstM)
			QW<= 1'b0;
		else if(clk)
			QW <= muxW;
		else
			QW<= QW;
	end*/
//assign ORout = (compaTiene|don);
assign ORout = (compaTiene|done);			
	
endmodule