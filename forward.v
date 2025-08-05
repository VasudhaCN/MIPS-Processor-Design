`timescale 1ns / 1ps
module forward(
    input [4:0] rs_ex, rt_ex,       // Source registers in EX stage
    input [4:0] rd_mem,             // Destination register in MEM stage
    input [4:0] rd_wb, 
    input RegWrite_mem,
    input RegWrite_wb,            
    output reg [1:0] forwardA,
    output reg [1:0] forwardB
);
always @(*) begin
    // Default: No forwarding
    forwardA = 2'b00;
    forwardB = 2'b00;
    
    // EX/MEM Forwarding (Priority 1)
    if (RegWrite_mem && (rd_mem != 0)) begin
        if (rd_mem == rs_ex) forwardA = 2'b10;
        if (rd_mem == rt_ex) forwardB = 2'b10;
    end
    
    // MEM/WB Forwarding (Priority 2)
    if (RegWrite_wb && (rd_wb != 0)) begin
        // Check for no conflict with higher-priority forwarding
        if (!(RegWrite_mem && (rd_mem != 0) && (rd_mem == rs_ex)))
            if (rd_wb == rs_ex) forwardA = 2'b01;
        if (!(RegWrite_mem && (rd_mem != 0) && (rd_mem == rt_ex)))
            if (rd_wb == rt_ex) forwardB = 2'b01;
    end
end
endmodule


