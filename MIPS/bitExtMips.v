module bitExtMips(
     input  [15:0]num,
     output [31:0]numo);
     
assign numo[15:0] = num;
assign numo[16]= num[15];
assign numo[17]= num[15];
assign numo[18]= num[15];
assign numo[19]= num[15];
assign numo[20]= num[15];
assign numo[21]= num[15];
assign numo[22]= num[15];
assign numo[23]= num[15];
assign numo[24]= num[15];
assign numo[25]= num[15];
assign numo[26]= num[15];
assign numo[27]= num[15];
assign numo[28]= num[15];
assign numo[29]= num[15];
assign numo[30]= num[15];
assign numo[31]= num[15];
endmodule
