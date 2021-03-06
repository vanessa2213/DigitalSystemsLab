module controlMips (
                     input [5:0]in3126,
                     input [5:0]in50,
							output Mult,
                     output RegDst,
                     output Branch,
                     output MemRead,
                     output MemtoReg,
                     output MemWrite,
                     output ALUSrc,
                     output RegWrite,
                     output Jump);
                     
wire add, slt, addiu, lw, addi, beq, sw, sub,annd, orr, j,m;
identifyOpMips io(.A(in3126), .B(in50),.ADD(add),.mult(m),.SLT(slt), .ADDIU(addiu), .LW(lw), .ADDI(addi), .BEQ(beq), .SW(sw), .SUB(sub), .AND(annd), .OR(orr), .J(j));

assign RegDst   = add | slt | sub | annd | orr;
assign Branch   = beq;
assign MemRead  = lw;
assign MemtoReg = lw;
assign MemWrite = sw;

assign ALUSrc = addiu | lw | addi | sw;
assign RegWrite = add | slt | addiu | lw | addi | sub | annd | orr | Mult;
assign Jump     = j;
assign Mult = m;

endmodule
