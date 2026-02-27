module traffic(
    input logic clk,
    input logic rst,
    output logic red,
    output logic yellow,
    output logic green
);

logic timer_done;

logic [7:0] count;

localparam int g_time = 9;
localparam int y_time = 2;
localparam int r_time = 9; 

typedef enum logic [1:0] {RED, YELLOW, GREEN} state_t;
state_t state;
state_t next_state;

always_comb begin
    red = 0;
    yellow = 0;
    green = 0;

    if (state == RED)
        red = 1;
    else if (state == YELLOW)
        yellow = 1;
    else if (state == GREEN)
        green = 1;
end

always_comb begin
next_state = state;
    case (state)
        RED:
            if (timer_done)
                next_state = GREEN;           
        YELLOW:
            if (timer_done)
                next_state = RED;
        GREEN:
            if (timer_done)
                next_state = YELLOW;
        default: next_state = RED;
    endcase
end

always_comb begin
    timer_done = 1'b0;
    case (state)
        RED: timer_done = (count >= r_time);
        YELLOW: timer_done = (count >= y_time);
        GREEN: timer_done = (count >= g_time);
        default: timer_done = 1'b1;

    endcase
end

always_ff @(posedge clk or posedge rst) begin
    if (rst)
        count <= 8'd0;
    else if (timer_done)
        count <= 8'd0;
    else 
        count <= count + 8'd1;
end

always_ff @(posedge clk or posedge rst) begin
    if (rst)
        state <= RED;
    else 
        state <= next_state;
end

endmodule