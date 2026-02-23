`timescale 1ns/1ps
module tb_register;

logic clk;
logic rst;
logic en;
logic [7:0] d;
logic [7:0] q;

register uut (
    .clk(clk),
    .rst(rst),
    .en(en),
    .d(d),
    .q(q)
);

always #5 clk = ~clk;

initial begin
    $dumpfile("register.vcd");
    $dumpvars(0, tb_register);

    clk = 0;
    rst = 1;
    en = 0;
    d = 8'd0;

    #10 rst = 0;

    #10 en = 1; d = 8'd5;
    #10 d = 8'd10;  
    #10 en = 0; d = 8'd20;
    #10 en = 1; d = 8'd42;

    #20 $finish;
end

initial begin

    forever begin
        @(posedge clk);
        #1;
        
        if (rst) begin
            if (q == 8'd0) 
                $display("PASS: register reset to 0");
            else
                $display("ERROR: q is not 0 during reset");
        end

        else if (en) begin
            if (q == d)
                $display("PASS @%0t: register captured input %0d", $time, q);
            else
                $display("ERROR @%0t: expected %0d got %0d", $time, d, q);
        end
    end
end


endmodule