`timescale 1ns/1ps
module tb_register_mygo;

logic clk;
logic rst;
logic [7:0] d;
logic [7:0] q;

register_mygo uut(
    .clk(clk),
    .rst(rst),
    .d(d),
    .q(q)
);

always #5 clk = ~clk;

initial begin
    $dumpfile("register_mygo.vcd");
    $dumpvars(0, tb_register_mygo);

    clk = 0;
    rst = 1;
    d = 0;
    
    #10 rst = 0;
    #10 d = 20;
    #10 d = 10;
    #10 d = 34;
    #10 d = 6;
    #3 d = 104;
    #3 d = 67;
    #4 d = 5;
    #10 rst = 1;
    #10 rst = 0;
    #20 $finish;
end
endmodule
