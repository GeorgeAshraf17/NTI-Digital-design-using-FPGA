module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);

    wire [31:0] b_mod;
    wire cout_lower;

    assign b_mod = b ^ {32{sub}};

    add16 lower ( .a(a[15:0]), .b(b_mod[15:0]), .cin(sub), .sum(sum[15:0]), .cout(cout_lower) );
    add16 upper ( .a(a[31:16]), .b(b_mod[31:16]), .cin(cout_lower), .sum(sum[31:16]), .cout() );

endmodule
