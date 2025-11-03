`timescale 1ns / 1ps
`include "Sumador_4bit/suma_4bit.v"
`include "Sumador_4bit/suma_1bit2.v"

module suma_4bit_tb;

    // Entradas
    reg [3:0] A_tb;
    reg [3:0] B_tb;
    reg Ci_tb;
    // Salidas
    wire [3:0] So_tb;
    wire Co_tb;

    // Instancia del módulo bajo prueba
    suma_4bit uut (
        .A(A_tb),
        .B(B_tb),
        .Ci(Ci_tb),
        .S(So_tb),
        .Co(Co_tb)
    );

     initial begin
        A_tb   = 4'd0;
        B_tb   = 4'd0; 
        Ci_tb = 1'd0;

        for (B_tb = 0; B_tb < 15; B_tb = B_tb + 1) begin
            #10;
        end

        B_tb = 4'd15;
        #10;

        for (B_tb = 0; B_tb < 16; B_tb = B_tb + 1) begin
            if (B_tb == 0) begin
                A_tb = A_tb + 1;
            end
            #10;
        end
    end
    
    initial begin
        $dumpfile("suma_4bit_tb.vcd");
        $dumpvars(-1, suma_4bit_tb);

         #2500 $finish;  
    end

endmodule