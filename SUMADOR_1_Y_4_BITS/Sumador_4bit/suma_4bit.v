module suma_4bit (
    input  [3:0] A,
    input  [3:0] B,
    input        Ci,
    output [3:0] S,
    output       Co
);

wire c1, c2, c3;

 // Instanciación de 4 sumadores de 1 bit
    suma_1bit2 FA0 (.A(A[0]), .B(B[0]), .Ci(Ci),  .So(S[0]), .Co(c1));
    suma_1bit2 FA1 (.A(A[1]), .B(B[1]), .Ci(c1),  .So(S[1]), .Co(c2));
    suma_1bit2 FA2 (.A(A[2]), .B(B[2]), .Ci(c2),  .So(S[2]), .Co(c3));
    suma_1bit2 FA3 (.A(A[3]), .B(B[3]), .Ci(c3),  .So(S[3]), .Co(Co));

endmodule



