module tb_mux_proj;

logic in0;
logic in1;
logic sel;
logic y;

mux_proj uut(
    .in0(in0),
    .in1(in1),
    .sel(sel),
    .y(y)
);

task run_case(input logic t_in0, input logic t_in1, input logic t_sel);
    logic expected;

    in0 = t_in0;
    in1 = t_in1;
    sel = t_sel;

    #1;

    expected = t_sel ? t_in1 : t_in0;

    if (y !== expected) begin
        $display("ERROR at time=%0t in0=%0d in1=%0d sel=%0d | expected=%0d got=%0d", $time, t_in0, t_in1, t_sel, expected, y);
        $finish;
    end
endtask


initial begin
    $dumpfile("mux_proj.vcd");
    $dumpvars(0, tb_mux_proj);
    run_case(0,1,0);
    run_case(0,1,1);
    run_case(1,0,0);
    run_case(1,0,1);
    run_case(0,0,0);
    run_case(0,0,1);
    run_case(1,1,0);
    run_case(1,1,1);

    $display("All tests passed!");
    $finish;
end

endmodule