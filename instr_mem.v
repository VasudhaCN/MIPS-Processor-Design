`timescale 1ns / 1ps
module instr_mem(
    input [31:0] PC,
    input reset,
    output [31:0] instr_code
    );
    reg [7:0] mem[40:0];    
    assign instr_code = {mem[PC], mem[PC+1], mem[PC+2], mem[PC+3]};
always @(reset)
begin
if (reset==0)
begin

//mem[0]=8'h00; mem[1]=8'h43; mem[2]=8'h08; mem[3]=8'h18; //0

//mem[4]=8'h00; mem[5]=8'h23; mem[6]=8'h10; mem[7]=8'h18; //1

//mem[8]=8'h00; mem[9]=8'h44; mem[10]=8'h18; mem[11]=8'h18; //2

mem[0]=8'h8C; mem[1]=8'h01; mem[2]=8'h00; mem[3]=8'h00; //0

mem[4]=8'h8c; mem[5]=8'h02; mem[6]=8'h00; mem[7]=8'h01; //1

mem[8]=8'h00; mem[9]=8'h22; mem[10]=8'h08; mem[11]=8'h18; //2

mem[12]=8'h3c; mem[13]=8'h02; mem[14]=8'h00; mem[15]=8'h0c;//3

mem[16]=8'h08; mem[17]=8'h00; mem[18]=8'h00; mem[19]=8'h06; //4 Jump instr

mem[20]=8'h00; mem[21]=8'h22; mem[22]=8'h10; mem[23]=8'h18; //5

mem[24]=8'h04; mem[25]=8'h24; mem[26]=8'h00; mem[27]=8'h03; //6

mem[28]=8'hac; mem[29]=8'h04; mem[30]=8'h00; mem[31]=8'h04;//7

mem[32]=8'h8c; mem[33]=8'h25; mem[34]=8'h00; mem[35]=8'h05;//8

mem[36]=8'h3c; mem[37]=8'h07; mem[38]=8'h00; mem[39]=8'h1f;//9

end
end
endmodule
