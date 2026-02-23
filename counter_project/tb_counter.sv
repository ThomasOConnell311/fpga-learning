module tb_counter;
    logic clk;
    logic rst;
    logic en;
    logic [7:0] count;

    counter uut(
        .clk(clk),
        .rst(rst),
        .en(en),
        .count(count)
    );

    always #5 clk = ~clk;
    
    initial begin
        $dumpfile ("counter.vcd");
        $dumpvars (0, tb_counter);
        clk = 0;
        rst = 1;
        en = 0;
        #10 rst = 0;
        #10 en = 1;
        #30 en = 0;
        #20 en = 1;
        #50 rst = 1;
        #20 rst = 0;
        #20 en = 0;
        #20 $finish;
    end

endmodule