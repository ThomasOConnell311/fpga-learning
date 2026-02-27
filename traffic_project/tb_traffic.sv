`timescale 1ns/1ps
module tb_traffic;
    logic clk;
    logic rst;
    logic red;
    logic yellow;
    logic green;

    traffic uut(
        .clk(clk),  
        .rst(rst),
        .red(red),
        .yellow(yellow),
        .green(green)
    );

    typedef enum logic [1:0] {c_RED, c_YELLOW, c_GREEN} color_t;
    color_t prev_color;
    color_t curr_color;

    int hold_count;
    logic init_done;

    initial begin
        prev_color = c_RED;
        curr_color = c_RED;
        hold_count = 0;
        init_done = 1'b0;
        
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1'b1;
        repeat (2) @(posedge clk);
        rst = 1'b0;
        repeat (60) @(posedge clk);
        $display("PASS: finished without one-hot errors.");
        $display("PASS: finished without sequence errors.");
        $display("PASS: finished without cycling errors.");
        $finish;
    end

    initial begin
        $dumpfile("traffic.vcd");
        $dumpvars(0, tb_traffic);
    end

    always @(posedge clk) begin
        if (rst) begin
            init_done = 1'b0;
            hold_count = 0;
        end
        else if (!init_done) begin
            get_outputs();
            prev_color = curr_color;
            hold_count = 1;
            init_done = 1'b1;
        end
        else begin
            prev_color = curr_color;
            get_outputs();
            check_onehot();

            if (curr_color != prev_color) begin
                sequence_check(prev_color, curr_color);
                duration_check(prev_color, hold_count);
                hold_count = 1;
            end
            else begin
                hold_count++;
            end
        end
    end

    task automatic get_outputs();
        case ({red, yellow, green})
            3'b100: curr_color = c_RED;
            3'b010: curr_color = c_YELLOW;
            3'b001: curr_color = c_GREEN;
            default: begin 
                $display("ERROR: current color is not RED YELLOW or GREEN"); 
                $fatal; 
            end
        endcase   
    endtask
    
    task sequence_check(input color_t prev_color, input color_t curr_color);
        if ((prev_color == c_RED) && (curr_color != c_GREEN )) begin
            $display("ERROR @%0t: color sequence did not go from RED to GREEN", $time);
            $fatal;
        end
        else if ((prev_color == c_GREEN) && (curr_color != c_YELLOW)) begin
            $display("ERROR @%0t: color sequence did not go from GREEN to YELLOW", $time);
            $fatal;
        end
        else if ((prev_color == c_YELLOW) && (curr_color != c_RED)) begin
            $display("ERROR @%0t: color sequence did not go from YELLOW to RED", $time);
            $fatal;
        end
    endtask

    task check_onehot();
        if ((red + yellow + green) != 1) begin
            $display("ERROR @%0t: invalid lights red=%0b yellow=%0b green=%0b", $time, red, yellow, green);
            $fatal;
        end
    endtask

    task duration_check(input color_t prev_color, input int hold_count);
         if ((prev_color == c_RED) && (hold_count != 10)) begin
            $display("ERROR @%0t: Did not hold color RED for 10 cycles, got %0d", $time, (hold_count));
            $fatal;
        end
        else if ((prev_color == c_YELLOW) && (hold_count != 3)) begin
            $display("ERROR @%0t: Did not hold color YELLOW for 3 cycles, got %0d", $time, (hold_count));
            $fatal;
        end
        else if ((prev_color == c_GREEN) && (hold_count != 10)) begin
            $display("ERROR @%0t: Did not hold color GREEN for 10 cycles, got %0d", $time, (hold_count));
            $fatal;
        end       
    endtask
        
endmodule
