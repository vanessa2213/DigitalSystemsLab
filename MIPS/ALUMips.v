module ALUMips(
    input  [31:0]A,
    input  [31:0]B,
    input  [2:0]selMux,
    output reg zero,
    output reg[31:0]R);
always @ (*)
 begin
  case(selMux)
   3'b000: R = A&B;
   3'b001: R = A|B;
   3'b010: R = A+B;
   3'b110: R = A-B;
   3'b111: R = A<B ;
  endcase
 end
 always @ (*)
	begin
	if (R == 0)
		zero = 1;
	else 
		zero = 0;
	end

endmodule
