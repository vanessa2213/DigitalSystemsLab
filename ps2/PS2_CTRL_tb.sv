`timescale 1ns/1ns

module PS2_CTRL_tb ();

/* System Verilog Style
logic    	CLOCK_50;
logic    	RST_B;	
logic    	PS2_CLK;
logic    	PS2_CLK2;
logic    	PS2_DAT;
logic    	PS2_DAT2;
logic [7:0] 	SCANCODE;
logic 		VLD;


//  INSTANCE your DESIGN HERE
//	PS2_CTRL uut (.*);
//  INSTANCE
*/

// Verilog Style instance
reg    	CLOCK_50;
reg    	RST_B;	
reg    	PS2_CLK;
reg    	PS2_DAT;

wire [7:0] 	SCANCODE;
wire 		VLD;

//  INSTANCE your DESIGN HERE
//	PS2_CTRL uut (	.clk(),
//				  	.rst(),
//				  	.ps2clk(),
//				  	.din(),
//					.code(),
//					.valid());
//  INSTANCE
//

top uut(.fpgaclk(CLOCK_50),.ps2clk(PS2_CLK),.rst(RST_B),.datain(PS2_DAT),.scancode(SCANCODE),
				.HEX1(),
				.HEX2(),
				.HEX3(),
				.HEX4(),
				.HEX5(),
				.HEX6() );

task PS2_send(bit [7:0] data);
 integer i;
 bit [10:0] ps2_pkt;

  ps2_pkt = {1'b1,^(data), data, 1'b0};

for (i = 0; i < 11; i = i+1) begin

  PS2_CLK <= 1;
  PS2_DAT <= ps2_pkt[i];
  repeat(250) @(CLOCK_50);

  PS2_CLK <= 0;
  repeat(250) @(CLOCK_50);

end

  @(CLOCK_50);
  PS2_CLK <= 'z;
  PS2_DAT <= 'z;
endtask


   initial begin
	RST_B 	 = 0;
	CLOCK_50 = 1;
	PS2_CLK  = 1;
	//uut.count = '0;
 	#2000;
 	RST_B = 1;


	//PS2_send();
	/*PS2_DAT = 0;  // start
	#1000;
	PS2_DAT = 0;
	#1000;
	PS2_DAT = 0;
	#1000;
	PS2_DAT = 0;
	#1000;
	PS2_DAT = 0;
	#1000;
	PS2_DAT = 1;
	#1000;
	PS2_DAT = 1;
	#1000;
	PS2_DAT = 0;
	#1000;
	PS2_DAT = 0;
	#1000;
	PS2_DAT = 1'bx; // parity
	#1000;
	PS2_DAT = 1; // stop bit*/

		// Single Key Pressed & Released
	PS2_send(8'h30);
	#10000;
	PS2_send(8'hF0);
	#10000;
	PS2_send(8'h30);
	#100000;

		// Single Key Pressed & kept Pressed for short amount of time then Released
	PS2_send(8'h31);
	#10000;
	PS2_send(8'h31);
	#10000;
	PS2_send(8'hF0);
	#10000;
	PS2_send(8'h31);
	#10000;


	#100000;
	$finish();
   end
   
   // Testbench signals can treat them like software variables, initializing them to 0 here -
   reg [3:0]  ShiftCnt = 0;
   reg [10:0] ShiftRegister = 0;
   reg [7:0]  refSCANCODE, refPREVSCANCODE;  // reference model
   
   
   // KEEP in mind following Coding Style is for the Testbench Only which is SOFTWARE based coding style -
   // This would never synthesize to valid HARDWARE.
   always @ (negedge PS2_CLK) begin
    ShiftCnt	  = ShiftCnt + 1;
	ShiftRegister = ShiftRegister >> 1;  // Shift Right by 1 position the Variable
	ShiftRegister[10] = PS2_DAT;		 // Assigning MSb to PS2_DAT after Shift
   
	if(ShiftCnt == 11) begin
		
		ShiftCnt = 0;
		refPREVSCANCODE = refSCANCODE;
		refSCANCODE = ShiftRegister[8:1];
		$display(" El SCANCODE leido    es  :   %h",refSCANCODE);
		$display(" El SCANCODE anterior fue :   %h",refPREVSCANCODE);
	end
   end
   
   initial begin
      forever #10 CLOCK_50 = ~CLOCK_50;
   end
   
   //initial begin
   //   forever #500 PS2_CLK = ~PS2_CLK;
   //end

endmodule
