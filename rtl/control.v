module control(
    input [6:0] opcode,
    output reg reg_write,
    output reg alu_src,
    output reg mem_write,
    output reg mem_read,
    output reg branch,
    output reg [2:0] alu_ctrl
);
    always @(*) begin
        reg_write = 0; alu_src = 0;
        mem_write = 0; mem_read = 0;
        branch = 0; alu_ctrl = 3'b000;

        case (opcode)
            7'b0010011: begin // ADDI
                reg_write = 1; alu_src = 1;
            end
            7'b0110011: begin // ADD
                reg_write = 1;
            end
            7'b0000011: begin // LW
                reg_write = 1; alu_src = 1; mem_read = 1;
            end
            7'b0100011: begin // SW
                alu_src = 1; mem_write = 1;
            end
            7'b1100011: begin // BEQ
                branch = 1; alu_ctrl = 3'b001;
            end
        endcase
    end
endmodule
