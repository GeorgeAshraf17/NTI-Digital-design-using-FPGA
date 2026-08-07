`default_nettype none
module top_module(
    input a,b,c,d,
    output out,out_n  
	); 

	wire and1 , and2 , or3;
	
	assign and1 = a & b;
	assign and2 = c & d;
	assign or3 = and1 | and2;
	assign out = or3;
	assign out_n = ~or3;
	
endmodule
