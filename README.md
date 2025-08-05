This is a 5 stage Pipelined MIPS Processor design which can handle data hazards using flush, stall and forwarding (EX/MEM or MEM/WB to ID/EX). 


The 5 stages Implemented are:
1. Fetch
2. Decode
3. Execute
4. Memory
5. Writeback

The instructions handled by this processor are:
1. i type - load word, store word, load upper immediate
2. r type - mul, shift right logical
3. j type - jump
