`timescale 1ns / 1ps
`include "Sumador_1bit/suma_1bit.v"

module suma_1bit_tb;
    // Declaración de señales
    reg A, B, Ci;
    wire Co, So;
    
    // Instanciación del módulo bajo prueba
    suma_1bit uut (
        .A(A),
        .B(B),
        .Ci(Ci),
        .Co(Co),
        .So(So)
    );
    
    // Generación de estímulos
    initial begin
        // Inicializar entradas
        A = 0;
        B = 0;
        Ci = 0;
        
        #10 A = 0; B = 0; Ci = 0;
        #10 A = 0; B = 0; Ci = 1;
        #10 A = 0; B = 1; Ci = 0;
        #10 A = 0; B = 1; Ci = 1;
        #10 A = 1; B = 0; Ci = 0;
        #10 A = 1; B = 0; Ci = 1;
        #10 A = 1; B = 1; Ci = 0;
        #10 A = 1; B = 1; Ci = 1;
        
        // Finalizar simulación
        #10 $finish;
    end
    
    initial begin
        $dumpfile("suma_1bit_tb.vcd");
        $dumpvars(0, suma_1bit_tb);
    end
endmodule