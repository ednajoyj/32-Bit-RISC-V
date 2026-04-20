module data_mem(
    input clk,
    input we,
    input re,
    input [31:0] addr,
    input [31:0] wd,
    output [31:0] rd
);
    reg [31:0] mem [0:255];

    initial begin
        mem[0] = 10;
        mem[1] = 20;
        mem[2] = 30;
        mem[3] = 40;
    end

    assign rd = re ? mem[addr[9:2]] : 0;

    always @(posedge clk) begin
        if (we)
            mem[addr[9:2]] <= wd;
    end
endmodule
