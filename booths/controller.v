module controller(
	input go,
	input S1,
	input S0,
	output muxe,
	output ld,
	output sh,
	output N0,
	output N1,
	output clr);
	
	assign N1 = S0 | S1;
	assign N0 = (~S0&go)|(S1&(~S0));
	
	assign muxe = (~S1&S0);
	assign ld = (~S1&S0)|(S1&(~S0));
	
	assign sh = (S1&S0);
	assign clr = (~S1&(~S0)&go);
	
	
	
endmodule
