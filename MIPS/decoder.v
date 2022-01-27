module decoder(
					input [3:0] binary,
					output reg[7:0] out
					);
	
	always @ (*)
		begin
			case(binary)
				4'h0: out = 8'b11000000;//0
				4'h1: out = 8'b11111001;//1
				4'h2: out = 8'b10100100;//2
				4'h3: out = 8'b10110000;//3
				4'h4: out = 8'b10011001;//4
				4'h5: out = 8'b10010010;//5
				4'h6: out = 8'b10000010;//6
				4'h7: out = 8'b11111000;//7
				4'h8: out = 8'b10000000;//8
				4'h9: out = 8'b10010000;//9
				4'hA: out = 8'b10001000;//A
				4'hB: out = 8'b10000011;//B
				4'hC: out = 8'b11000110;//C
				4'hD: out = 8'b10100001;//D
				4'hE: out = 8'b10000110;//E
				4'hF: out = 8'b10001110;//F
			endcase
		end
		
		
endmodule