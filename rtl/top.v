module top(input clk, input rst);

    wire [31:0] pc, pc_next, instr, imm;
    wire [31:0] rd1, rd2, alu_out, mem_out;
    wire reg_write, alu_src, mem_write, mem_read, branch;
    wire zero;
    wire [2:0] alu_ctrl;

    pc PC(clk, rst, pc_next, pc);
    instr_mem IM(pc, instr);
    imm_gen IG(instr, imm);
    control CU(instr[6:0], reg_write, alu_src,
               mem_write, mem_read, branch, alu_ctrl);

    reg_file RF(clk, reg_write,
                instr[19:15], instr[24:20], instr[11:7],
                mem_read ? mem_out : alu_out,
                rd1, rd2);

    alu ALU(rd1, alu_src ? imm : rd2, alu_ctrl, alu_out, zero);

    data_mem DM(clk, mem_write, mem_read,
                alu_out, rd2, mem_out);

    assign pc_next = (branch && zero) ? pc + imm : pc + 4;

endmodule
