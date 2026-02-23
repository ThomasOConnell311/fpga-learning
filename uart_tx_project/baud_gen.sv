module baud_gen #(
    parameter int DIV = 16
)(
    input wire clk,
    input wire rst,
    input reg tick
);

    reg[&clog2(DIV)-1:0] cnt;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cnt <= 0;
            tick <= 0;
        else end begin
            if(cnt == DIV-1) begin
                cnt <= 0;
                tick <= 1;
            end else begin
                cnt <= cnt + 1;
                tick <= 0;
            end
        end
    end
endmodule