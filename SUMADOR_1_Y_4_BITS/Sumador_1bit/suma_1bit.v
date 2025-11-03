module suma_1bit (
    input A, B, Ci,
    output Co, So
);

wire XOR_AB, AND_AB, AND_XOR_AB_Ci;

assign XOR_AB = A ^ B;
assign AND_AB = A & B;
assign So = XOR_AB ^ Ci;
assign AND_XOR_AB_Ci = XOR_AB & Ci;
assign Co = AND_XOR_AB_Ci | AND_AB;

//wire x_ab, cout_t, a_ab;

//xor(x_ab, A, B);
//xor(So, x_ab, Ci);
//and(cout_t, x_ab, Ci);
//and(a_ab, A, B);
//or(Co, cout_t, a_ab);

//reg [1:0] sum_all;

//always @(*) begin
  //  sum_all = A + B + Ci;  
//end

//assign Co = sum_all[1];
//assign So = sum_all[0];

endmodule
