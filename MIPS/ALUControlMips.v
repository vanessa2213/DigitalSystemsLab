module ALUControlMips( input  [5:0] bit3126,
							  input  [5:0] bit50,
							  output [2:0] selec);

							  
wire ADDwi, SLTwi, ADDIUwi, LWwi, ADDIwi, BEQwi, SWwi, SUBwi, ANDwi, ORwi, Jwi;
wire addw, subw, one, two, zero;
identifyOpMips id(.A(bit3126), .B(bit50),.ADD(ADDwi), .SLT(SLTwi), .ADDIU(ADDIUwi), .LW(LWwi), .ADDI(ADDIwi), .BEQ(BEQwi), .SW(SWwi), .SUB(SUBwi), .AND(ANDwi), .OR(ORwi), .J(Jwi));

assign addw = ADDwi | ADDIUwi | LWwi | ADDIwi | SWwi;
assign subw = BEQwi | SUBwi;
assign one = addw| subw | SLTwi;
assign two = subw | SLTwi ;
assign zero=  SLTwi | ORwi;
assign selec[0] = zero;
assign selec[1] = one;
assign selec[2] = two;

endmodule
