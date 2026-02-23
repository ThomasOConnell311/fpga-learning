`timescale 1ps/1ps
module tb_and_mod;

logic a;
logic b;
logic and_res;
logic or_res;
logic xor_res;
logic exp_and; 
logic exp_or;
logic exp_xor;

and_mod uut(
    .a(a),
    .b(b),
    .and_res(and_res),
    .or_res(or_res),
    .xor_res(xor_res)
);

initial begin
    $dumpfile("AND_mod.vcd");
    $dumpvars(0, tb_and_mod);

    for (int i = 0; i < 4; i++) begin
        a = i[1];
        b = i[0];

        #1;

        exp_and = a & b;
        exp_or = a | b;
        exp_xor = a ^ b;

        if ({and_res, or_res, xor_res} !== {exp_and, exp_or, exp_xor}) begin
            $display("Error at a=%0d, b=%0d | expected: AND=%0d OR=%0d XOR=%0d | got: AND=%0d OR=%0d XOR=%0d", a, b, exp_and, exp_or, exp_xor, and_res, or_res, xor_res);
            $finish;
        end 
        else begin
            $display("PASS at a=%0d, b=%0d", a, b);
        end
    end
    $display("All tests passed!");
    $finish;
end   
endmodule