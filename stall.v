`timescale 1ns / 1ps
module stall (
    input [4:0] rs,           
    input [4:0] rt,           
    input [4:0] rt_ex,        
    input MemRead_ex,   
    output reg  nop         
);

always @(*) begin
    nop = 0;
     if (MemRead_ex && ((rt_ex == rs) || (rt_ex == rt))) begin
        nop = 1;
    end
end

endmodule
