module reducirBit26Mips(
                            input [25:0] num,
                            output [4:0] numo);
assign numo = num[4:0];
endmodule