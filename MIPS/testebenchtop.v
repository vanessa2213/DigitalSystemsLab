module testbenchtop;

reg clk, rstM;


top booth(clk,rstM,fullq2,fullq1,emptyq2,emptyq1);

initial begin
clk = 0;
rstM = 1;
#20
rstM = 0;

end

always #5 clk = !clk;


endmodule