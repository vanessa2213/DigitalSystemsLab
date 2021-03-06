module identifyOpMips(
							  input [5:0] A,
							  input [5:0] B,
							  output ADD,
							  output mult,
							  output SLT,
							  output ADDIU,
							  output LW,
							  output ADDI,
							  output BEQ,
							  output SW,
							  output SUB,
							  output AND,
							  output OR,
							  output J);
  
  assign ADD = (~A[5])&(~A[4])&(~A[3])&(~A[2])&(~A[1])&(~A[0])&(B[5])&(~B[4])&(~B[3])&(~B[2])&(~B[1])&(~B[0]);
  assign SLT = (~A[5])&(~A[4])&(~A[3])&(~A[2])&(~A[1])&(~A[0])&(B[5])&(~B[4])&(B[3])&(~B[2])&(B[1])&(~B[0]);
  assign ADDIU = (~A[5])&(~A[4])&(A[3])&(~A[2])&(~A[1])&(A[0]);
  assign LW = (A[5])&(~A[4])&(~A[3])&(~A[2])&(A[1])&(A[0]);
  assign ADDI = (~A[5])&(~A[4])&(A[3])&(~A[2])&(~A[1])&(~A[0]);
  assign BEQ = (~A[5])&(~A[4])&(~A[3])&(A[2])&(~A[1])&(~A[0]);
  assign SW = (A[5])&(~A[4])&(A[3])&(~A[2])&(A[1])&(A[0]);
  assign SUB = (~A[5])&(~A[4])&(~A[3])&(~A[2])&(~A[1])&(~A[0])&(B[5])&(~B[4])&(~B[3])&(~B[2])&(B[1])&(~B[0]);
  assign AND = (~A[5])&(~A[4])&(~A[3])&(~A[2])&(~A[1])&(~A[0])&(B[5])&(~B[4])&(~B[3])&(B[2])&(~B[1])&(~B[0]);
  assign OR = (~A[5])&(~A[4])&(~A[3])&(~A[2])&(~A[1])&(~A[0])&(B[5])&(~B[4])&(~B[3])&(B[2])&(~B[1])&(B[0]);
  assign J = (~A[5])&(~A[4])&(~A[3])&(~A[2])&(A[1])&(~A[0]);
  assign mult = ((~A[5])&(~A[4])&(~A[3])&(~A[2])&(~A[1])&(~A[0])&(~B[5])&(B[4])&(B[3])&(~B[2])&(~B[1])&(~B[0]))&((~A[5])&(~A[4])&(~A[3])&(~A[2])&(~A[1])&(~A[0]));
endmodule
