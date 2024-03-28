`timescale 1ns / 1ps

module n_bit_4_x_1_MUX #(parameter N = 32)(
    input [N-1:0] a,
    input [N-1:0] b,
    input [N-1:0] c,
    input [N-1:0] d,
    input [1:0] s,
    output [N-1:0] o
    );

    genvar i;
    generate
        for(i = 0; i < N; i = i + 1) begin : gen_4x1_mux
            wire ab_mux_out, cd_mux_out;

            MUX mx_ab(.a(a[i]), .b(b[i]), .s(s[0]), .o(ab_mux_out));
            MUX mx_cd(.a(c[i]), .b(d[i]), .s(s[0]), .o(cd_mux_out));

            MUX mx_out(.a(ab_mux_out), .b(cd_mux_out), .s(s[1]), .o(o[i]));
        end
    endgenerate
endmodule
