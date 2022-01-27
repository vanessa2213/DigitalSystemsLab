module queue(
				  	input clk,
					input pop,
					input [31:0] writeData,
					input push,
					input rst,
					output full,
					output empty,
					output [31:0] readData1);
					
	reg Qpop;
	reg Qpush;
	reg  [4:0]Qcnt;
	reg  [4:0]Qcnt2;
	reg compa1;
	reg compa2;
	reg[31:0] register[31:0];
	
	always @ (posedge clk)
		begin
			if(rst)
				Qpush <= 0;
			else if(clk)
				Qpush <= push;
			else
				Qpush <= Qpush;
			
				
		end
		
	always @ (posedge clk)
		begin
			if(rst)
				Qpop <= 0;
			else if(clk)
				Qpop <= pop;
			else
				Qpop <= Qpop;
			
				
		end
	
	
	always @ (negedge Qpush or posedge rst)
		begin
			if(rst)
				Qcnt <= 0;
			else if(~Qpush)
				Qcnt <= Qcnt + 1;
			else
				Qcnt <= Qcnt;		
		end
	
	
	always @ (posedge Qpop or posedge rst)
		begin
			if(rst)
				Qcnt2 <= 0;
			else if(~Qpop)
				Qcnt2 <= Qcnt2 + 1;
			else
				Qcnt2 <= Qcnt2;		
		end
		
	always @ (*)
		begin
		if (Qcnt == 0)
			compa1 = 1;
		else if (Qcnt==5'h1f )
			compa2 = 1;
		else
			begin	
				compa1 = 0;
				compa2 =0;
			end
		end
		
	assign empty  = (Qpop&compa1);
	assign full = (Qpush & compa2);
	
	always @ (posedge clk or posedge rst)
   begin
    if(rst)
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
	  else if (Qpush)
		begin
		  register[Qcnt] <= writeData;
     
    end
   end
	assign readData1 = (Qpop)? register[Qcnt2]:readData1;
endmodule