module uart_tx(
    input wire clk,
    input wire rst,
    input wire start,
    input wire [7:0] data,
    input wire baud_tick,
    output wire tx,
    output wire busy
);

always