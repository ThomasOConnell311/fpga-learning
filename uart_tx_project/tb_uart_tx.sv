`timescale 1ns/1ps
module tb_uart_tx;
    logic clk;
    logic rst;
    logic start;
    logic [7:0] data;
    logic baud_tick;
    logic tx;
    logic busy;

    uart_tx uut(
        .clk(clk),
        .rst(rst),
        .start(start),
        .data(data),
        .baud_tick(baud_tick),
        .tx(tx),
        .busy(busy)
    );
