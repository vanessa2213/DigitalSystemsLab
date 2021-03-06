module dataMemoryMips(
                        input [4:0]   address,
                        input [31:0]  writedata,
                        input          memwr,
                        input         memrd,
                        input         clk,
                        output reg [31:0] readData);

reg [31:0] mem [31:0];

always @ (posedge clk)    
    begin
        
        if (memwr)
            mem[address] <= writedata;
    end

always @ (*)
    begin
               if (memrd)
                   readData <=mem[address];
                else
                    readData <=0;
    end
    initial begin
       mem[0] = 32'd0;
        mem[1] = 32'd3;
        mem[2] = 32'd4;
        mem[3] = 32'd5;
        mem[4] = 32'd6;
        mem[5] = 32'd7;
        mem[6] = 32'd8;
        mem[7] = 32'd9;
        mem[8] = 32'd10;
        mem[9] = 32'd11;
        mem[10] = 32'd12;
        mem[11] = 32'd0;
        mem[12] = 32'd0;
        mem[13] = 32'd0;
        mem[14] = 32'd0;
        mem[15] = 32'd0;
        mem[16] = 32'd0;
        mem[17] = 32'd0;
        mem[18] = 32'd0;
        mem[19] = 32'd0;
        mem[20] = 32'd0;
        mem[21] = 32'd0;
        mem[22] = 32'd0;
        mem[23] = 32'd0;
        mem[24] = 32'd0;
        mem[25] = 32'd0;
        mem[26] = 32'd0;
        mem[27] = 32'd0;
        mem[28] = 32'd0;
        mem[29] = 32'd0;
        mem[30] = 32'd0;
        mem[31] = 32'd0;
    end
endmodule
