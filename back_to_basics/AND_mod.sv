module and_mod(
input logic a,
input logic b,
output logic and_res,
output logic or_res,
output logic xor_res
);

assign and_res = a & b;
assign or_res = a | b;
assign xor_res = a ^ b;

endmodule
