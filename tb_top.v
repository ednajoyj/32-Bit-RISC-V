module tb_top;
    reg clk = 0, rst = 1;

    top DUT(clk, rst);

    always #5 clk = ~clk;

    initial begin
        #10 rst = 0;
        #300 $finish;
    end
endmodule
