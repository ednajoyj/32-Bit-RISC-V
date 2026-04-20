module instr_mem(
    input [31:0] addr,
    output [31:0] instr
);
    reg [31:0] mem [0:255];

    initial begin
        // Application: sum of 4 numbers
        mem[0] = 32'h00000093; // addi x1,x0,0   sum=0
        mem[1] = 32'h00000113; // addi x2,x0,0   index=0
        mem[2] = 32'h00400193; // addi x3,x0,4   limit=4
        mem[3] = 32'h00008203; // lw   x4,0(x1)
        mem[4] = 32'h004080b3; // add  x1,x1,x4
        mem[5] = 32'h00410113; // addi x2,x2,1
        mem[6] = 32'hfe219ae3; // bne  x2,x3,loop
        mem[7] = 32'h00102023; // sw   x1,0(x0)
    end

    assign instr = mem[addr[9:2]];
endmodule
