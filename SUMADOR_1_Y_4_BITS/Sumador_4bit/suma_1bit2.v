module suma_1bit2 (
    input A, B, Ci,
    output Co, So

);

wire XOR_AB, AND_AB, AND_XOR_AB_Ci;

assign XOR_AB = A ^ B;
assign AND_AB = A & B;
assign So = XOR_AB ^ Ci;
assign AND_XOR_AB_Ci = XOR_AB & Ci;
assign Co = AND_XOR_AB_Ci | AND_AB;

endmodule 
