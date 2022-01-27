module shiftreg (
	input 		clk,
	input 		rst,
	input       load,
	input [16:0] data,
	input 		shren,
	input 		din,
	output [16:0] dout
	);

	reg [16:0] ShiftRegister;
	
	always @ (posedge clk or posedge rst) begin
		if (rst)	// Active High Reset (if Active Low is needed just negate ~rst)
			ShiftRegister <= 0;
		else if (shren)	// Shift Enable input
			ShiftRegister[16:0] <= {din,ShiftRegister[16:1]};
		else if (load)  // Parallel Load input  ( has priority over shren )
			ShiftRegister <= data;
	end
	
	// Combinatorial Output, the output of the Right ShiftRegister is always the LSb
	assign dout = ShiftRegister;
	
endmodule