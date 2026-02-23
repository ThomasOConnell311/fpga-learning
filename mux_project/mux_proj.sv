module mux_proj(
    input logic in0,
    input logic in1,
    input logic sel,
    output logic y
);

assign y  = sel ? in1 : in0;

endmodule