`timescale 1ns / 1ps
module reg_file(
    input [4:0] Read_Reg_Num1,
    input [4:0] Read_Reg_Num2,
    input [4:0] Write_Reg_Num,
    input [31:0] Write_Data,
    input regwrite,
    output reg [31:0] Read_Data1,
    output reg [31:0] Read_Data2,
    input reset
    );
    reg [31:0] RegMemory [31:0];    
    integer i;
    always @(*) begin
        if (reset==0) begin
            RegMemory[0]=32'h00; RegMemory[1]=32'h01; RegMemory[2]=32'h02; RegMemory[3]=32'h03; 
            RegMemory[4]=32'h04; RegMemory[5]=32'h00; RegMemory[6]=32'h00; RegMemory[7]=32'h00; 
            RegMemory[8]=32'h01; RegMemory[9]=32'h00; RegMemory[10]=32'h00; RegMemory[11]=32'h00; 
            RegMemory[12]=32'h01; RegMemory[13]=32'h00; RegMemory[14]=32'h00; RegMemory[15]=32'h00;
            RegMemory[16]=32'h01; RegMemory[17]=32'h00; RegMemory[18]=32'h00; RegMemory[19]=32'h00;
            RegMemory[20]=32'h01; RegMemory[21]=32'h00; RegMemory[22]=32'h00; RegMemory[23]=32'h00; 
            RegMemory[24]=32'h01; RegMemory[25]=32'h00; RegMemory[26]=32'h00; RegMemory[27]=32'h00;
            RegMemory[28]=32'h01; RegMemory[29]=32'h00; RegMemory[30]=32'h00; RegMemory[31]=32'h00;
            end 
         else begin
            if (regwrite == 1) begin
            for (i=1;i<32;i=i+1) begin
            RegMemory[Write_Reg_Num] <= Write_Data;
            
end        end
end
    end
    always@(*)
        begin
            Read_Data1 <= RegMemory[Read_Reg_Num1];
            Read_Data2 <= RegMemory[Read_Reg_Num2];

        end 
endmodule

