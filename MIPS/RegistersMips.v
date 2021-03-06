module RegistersMips(
						input clk,
						input [4:0] readAddress1,
						input [4:0] readAddress2,
						input [4:0] writeAddress,
						input [31:0] writeData,
						input writeEnable,
						input rst,
						output [31:0] readData1,
						output [31:0] readData2);
     
  reg[31:0] register[31:0];
  
  always @ (posedge clk or posedge rst)
   begin
    if (rst)
		begin
		  register[0] = 0;
		  register[1] = 0;
		  register[2] = 0;
		  register[3] = 0;
		  register[4] = 0;
		  register[5] = 0;
		  register[6] = 0;
		  register[7] = 0;
		  register[8] = 0;
		  register[9] = 0;
		  register[10] = 0;
		  register[11] = 0;
		  register[12] = 0;
		  register[13] = 0;
		  register[14] = 0;
		  register[15] = 0;
		  register[16] = 0;
		  register[17] = 0;
		  register[18] = 0;
		  register[19] = 0;
		  register[20] = 0;
		  register[21] = 0;
		  register[22] = 0;
		  register[23] = 0;
		  register[24] = 0;
		  register[25] = 0;
		  register[26] = 0;
		  register[27] = 0;
		  register[28] = 0;
		  register[29] = 0;
		  register[30] = 0;
		  register[31] = 0;
     
    end
	  else if(writeEnable)
     begin
		register[writeAddress] <= writeData;
     end
   end
   
  assign readData1 = register[readAddress1];
  assign readData2 = register[readAddress2];
  

    
endmodule