module register(
    input logic clk,
    input logic rst,
    input logic en,
    input logic [7:0] d,
    output logic [7:0] q
);

always_ff @(posedge clk or posedge rst) begin
    if (rst)
        q<= 8'b00000000;
    else if (en)
        q <= d;
end

endmodule