module full_adder (
    input  a,
    input  b,
    input  cin,
    output SUM,
    output COUT
);

wire sum1, carry1, carry2;

half_adder HA1 (
.a(a),
.b(b),
.sum(sum1),
.carry(carry1)
);

half_adder HA2 (
.a(sum1),
.b(cin),
.sum(SUM),
.carry(carry2)
);

assign COUT = carry1 | carry2;

endmodule