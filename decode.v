`timescale 1ns / 1ps

module decode(
input [31:0]instruction,
output [5:0]opcode,
output [5:0]func,
output [4:0]rs,
output [4:0]rt,
output [4:0]rd,
output [31:0]offset,
output [25:0]branch
    );
assign opcode = instruction[31:26]; 
assign func = instruction[5:0];
assign rs = instruction[25:21]; 
assign rt= instruction[20:16]; 
assign rd= instruction[15:11]; 
assign offset= instruction[15:0]; 
assign branch = instruction[25:0];
endmodule
