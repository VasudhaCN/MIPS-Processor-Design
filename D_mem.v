`timescale 1ns / 1ps
module D_mem(
    input [31:0]address,
    input [31:0]data,
    input reset,
    input memRead,
    input memWrite,
    output reg [31:0] mem_data  
    );
    reg [7:0] mem[39:0];    
    
always @(negedge reset)
begin
if (reset==0)
begin
mem[0]=8'h0a; mem[1]=8'h0a; mem[2]=8'h00; mem[3]=8'h00; //0
mem[4]=8'h00; mem[5]=8'h00; mem[6]=8'h00; mem[7]=8'h02; //1
mem[8]=8'h00; mem[9]=8'h00; mem[10]=8'h10; mem[11]=8'h00; //2
mem[12]=8'h00; mem[13]=8'h00; mem[14]=8'h00; mem[15]=8'h00; //3
mem[16]=8'h00; mem[17]=8'h00; mem[18]=8'h00; mem[19]=8'h00; //4
mem[20]=8'h00; mem[21]=8'h00; mem[22]=8'h00; mem[23]=8'h00; //5
mem[24]=8'h00; mem[25]=8'h00; mem[26]=8'h00; mem[27]=8'h00; //6
mem[28]=8'h00; mem[29]=8'h00; mem[30]=8'h00; mem[31]=8'h00; //7
mem[32]=8'h00; mem[33]=8'h00; mem[34]=8'h00; mem[35]=8'h00; //8
mem[36]=8'h00; mem[37]=8'h00; mem[38]=8'h00; mem[39]=8'h00; //9
mem[40]=8'h00; mem[41]=8'h00; mem[42]=8'h00; mem[43]=8'h00; //10
mem[44]=8'h00; mem[45]=8'h00; mem[46]=8'h00; mem[47]=8'h00; //11
mem[48]=8'h00; mem[49]=8'h00; mem[50]=8'h00; mem[51]=8'h00; //12
mem[52]=8'h00; mem[53]=8'h00; mem[54]=8'h00; mem[55]=8'h00; //13
mem[56]=8'h00; mem[57]=8'h00; mem[58]=8'h00; mem[59]=8'h00; //14
mem[60]=8'h00; mem[61]=8'h00; mem[62]=8'h00; mem[63]=8'h00; //15
mem[64]=8'h00; mem[65]=8'h00; mem[66]=8'h00; mem[67]=8'h00; //16
mem[68]=8'h00; mem[69]=8'h00; mem[70]=8'h00; mem[71]=8'h00; //17
mem[72]=8'h00; mem[73]=8'h00; mem[74]=8'h00; mem[75]=8'h00; //18
mem[76]=8'h00; mem[77]=8'h00; mem[78]=8'h00; mem[79]=8'h00; //19
mem[80]=8'h00; mem[81]=8'h00; mem[82]=8'h00; mem[83]=8'h00; //20
mem[84]=8'h00; mem[85]=8'h00; mem[86]=8'h00; mem[87]=8'h00; //21
mem[88]=8'h00; mem[89]=8'h00; mem[90]=8'h00; mem[91]=8'h00; //22
mem[92]=8'h00; mem[93]=8'h00; mem[94]=8'h00; mem[95]=8'h00; //23
mem[96]=8'h00; mem[97]=8'h00; mem[98]=8'h00; mem[99]=8'h00; //24
mem[100]=8'h00; mem[101]=8'h00; mem[102]=8'h00; mem[103]=8'h00; //25
mem[104]=8'h00; mem[105]=8'h00; mem[106]=8'h00; mem[107]=8'h00; //26


end
end
    // Memory Read
 always @(*) begin
 
        if (memRead && !memWrite) begin
            mem_data = {mem[address * 4], mem[(address * 4) + 1], mem[(address * 4) + 2], mem[(address * 4) + 3]};
        end
        else begin
            mem_data = 32'hzzzzzzzz; // high impedance when not reading
        end
    end

    // Memory Write
always @(*) begin

        if (!memRead && memWrite) begin
            mem[address * 4]     = data[31:24];
            mem[(address * 4) + 1] = data[23:16];
            mem[(address * 4) + 2] = data[15:8];
            mem[(address * 4) + 3] = data[7:0];
        end
    end
endmodule