[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-2e0aaae1b6195c2367325f4f02e2d04e9abb55f0b24a779b69b11b9e10269abc.svg)](https://classroom.github.com/online_ide?assignment_repo_id=20122907&assignment_repo_type=AssignmentRepo)
# Lab01 - Sumador de 1 bit y sumador de 4 bits

# Integrantes
 
 [MIGUEL ANGEL CUERVO](https://github.com/MiguelAcuervo)

 [JHON ALEXANDER CUADROS LAIS](https://github.com/JhonCuadros)

# Informe

Indice:

1. [Documentación](#documentación-de-los-circuitos-implementados-implementado)
2. [Simulaciones](#simulaciones)
3. [Evidencias de implementación](#evidencias-de-implementación)
4. [Preguntas](#preguntas)
5. [Conclusiones](#conclusiones)
6. [Referencias](#referencias)

## Documentación de los circuitos implementados implementado

## 1. Sumador de 1 bit

#### **1.1 Descripción**

1. **Análisis del bloque funcional**  
   El sumador de 1 bit, es un circuito combinacional que permite realizar la suma de dos bits de entrada junto con un acarreo proveniente de una posición menos significativa. Es un bloque fundamental en el diseño de sistemas aritméticos y se utiliza como base para construir sumadores de mayor tamaño. 


![DIAGRAMA](/IMAGENES/sumador_1bit.png)

Este circuito recibe tres entradas:  
- `A` → primer bit a sumar.  
- `B` → segundo bit a sumar.  
- `Ci` → bit de acarreo de entrada (*carry in*). 

Las salidas del circuito son:  

- `So` → resultado de la suma de un solo bit.  
- `Co` → acarreo de salida (*carry out*), que se transfiere al siguiente bloque de mayor peso en sumadores de más bits.  

#### **1.2 Construcción de la tabla de verdad**  

Para construir la tabla de verdad del sumador de 1 bit se consideraron las tres entradas del circuito:  
- `A` y `B` → bits que se desean sumar.  
- `Ci` → bit de acarreo de entrada.  

Dado que cada entrada puede tomar valores de `0` o `1`, existen en total **2³ = 8 combinaciones posibles**.  
Para cada combinación se calcularon las salidas de acuerdo con la operación de suma binaria.  

1. **Caso base**: cuando `A = 0`, `B = 0` y `Ci = 0`, la suma total es `0`, por lo que `So = 0` y `Co = 0`.  

2. **Un solo 1 en las entradas**: si una de las tres entradas es `1`, la suma total es `1`, por lo tanto `So = 1` y `Co = 0`.  

3. **Dos entradas en 1**: si la suma de las entradas es `2` (por ejemplo, `A = 1`, `B = 1`, `Ci = 0`), en binario este resultado se representa como `10`. El bit menos significativo es la salida `So = 0` y el bit más significativo corresponde al acarreo `Co = 1`.  

4. **Tres entradas en 1**: si `A = 1`, `B = 1` y `Ci = 1`, la suma total es `3`, que en binario se representa como `11`. En este caso, `So = 1` y `Co = 1`.  

De este modo se completan las 8 filas de la tabla de verdad del sumador completo:   

<p align="center">

|   A  |   B  |  Ci |   Co  |   So  |
|------|------|-----|-------|-------|
|   0  |   0  |  0  | **0** | **0** |
|   0  |   0  |  1  | **0** | **1** |
|   0  |   1  |  0  | **0** | **1** |
|   0  |   1  |  1  | **1** | **0** | 
|   1  |   0  |  0  | **0** | **1** |
|   1  |   0  |  1  | **1** | **0** |
|   1  |   1  |  0  | **1** | **0** |
|   1  |   1  |  1  | **1** | **1** | 
</p>

3. **Obtención de expresiones lógicas**  
   Mediante la simplificación con mapas de Karnaugh, se determinaron las ecuaciones booleanas que describen el funcionamiento del sumador:  

**Para S₀:**

![DIAGRAMA](/IMAGENES/M_Karnaugh.png)


$$
\begin{gathered}
S₀ = \overline{AB}C_i + \overline{A}B\overline{C_i} + ABC_i + A\overline{B}C_i \\
S₀ = C_i \cdot (\overline{AB} + AB) + \overline{C_i} \cdot (\overline{AB} + A\overline{B})  \\
S₀ = C_i \cdot \overline{(A \oplus B)} + \overline{C_i} \cdot (A \oplus B)  \\
S₀ = C_i \oplus (A \oplus B)
\end{gathered}
$$

**Para C₀:**

![DIAGRAMA](/IMAGENES/M_KarnaughCo.png)

$$
\begin{gathered}
C₀ = \overline{A}BC_i + AB\overline{C_i} + ABC_i + A\overline{B}C_i \\
C₀ = C_i \cdot (\overline{A}B + A\overline{B}) + AB \cdot (C_i + \overline{C_i}) \\
C₀ = C_i \cdot (A \oplus B) + AB 
\end{gathered}
$$

#### **1.3 Implementación en HDL Verilog**

Para la implementación en HDL se puede hacer de distintas formas, en este caso se van a mostrar 3 formas.

#### **Forma 1: Usando assign**
**1. Definición del módulo**

```verilog
module suma_1bit (
    input A, B, Ci,
    output Co, So
);
```

   Entradas:

   - `A` y `B` son los bits a sumar.

   - `Ci` es el acarreo de entrada (`carry in`).

   Salidas:

   - `So` es el resultado de la suma.

   - `Co` es el acarreo de salida (carry out).

**2. Declaración de señales internas**
```verilog
wire XOR_AB, AND_AB, AND_XOR_AB_Ci;
```
Se definen señales internas de tipo wire que almacenan resultados intermedios de las operaciones lógicas.

**3. Operaciones lógicas paso a paso**

```verilog
assign XOR_AB = A ^ B;
```
 - Calcula la operación XOR entre `A` y `B`.

 - Este resultado será usado tanto para la suma como para el acarreo.

Este resultado será usado tanto para la suma como para el acarreo.

```verilog
assign AND_AB = A & B;
```

 - Calcula el producto lógico entre A y B.

 - Representa la parte del acarreo que se genera cuando ambas entradas son 1.


```verilog
assign So = XOR_AB ^ Ci;
```

 - Calcula la suma final (So).

 - La expresión corresponde a:

$$
\begin{gathered}
S₀ = C_i \oplus (A \oplus B)
\end{gathered}
$$

```verilog
assign AND_XOR_AB_Ci = XOR_AB & Ci;
```
 - Determina si existe un acarreo adicional cuando Ci y A ⊕ B son ambos 1.

```verilog
assign Co = AND_XOR_AB_Ci | AND_AB;
```

 - Calcula el acarreo de salida (Co).

La expresión corresponde a:

$$
\begin{gathered}
C₀ = C_i \cdot (A \oplus B) + AB 
\end{gathered}
$$

**ENLACE A `suma_1bit.v`.**

Para ver a detalle el codigo implementado por favor dar click en el siguiente vinculo

| Archivo          | Descripción           | Tipo       |
|------------------|-----------------------|------------|
| [suma_1bit.v](/Sumador_1bit/suma_1bit.v)  | Archivo Principal | v       |


**Enfoques del diseño**

- Se emplean operadores lógicos (^, &, |) para describir las ecuaciones booleanas.

- Es un punto intermedio entre el nivel aritmético y el nivel de compuertas.

- Ventaja: Más conciso que el uso de primitivas y aún mantiene la relación directa con las expresiones booleanas.

- Desventaja: Menos detallado que el uso de compuertas explícitas.

#### **Forma 2: Usando always**

**Entradas:**

- `A`: Primer bit a sumar (1 bit)

- `B`: Segundo bit a sumar (1 bit)

- `Ci`: Acarreo de entrada (Carry-in) desde la etapa anterior (1 bit)

**Salidas:**

- `So`: Resultado de la suma (Sum-out) (1 bit)

- `Co`: Acarreo de salida (Carry-out) para la siguiente etapa (1 bit)

**Registro temporal**

- `reg [1:0] sum_all;`
Se define un registro de 2 bits que almacenará el resultado completo de la operación.
Esto es necesario porque al sumar tres bits, el resultado puede ser un número entre 0 y 3, lo cual requiere 2 bits en binario.

**Bloque combinacional**

- `always @(*) begin sum_all = A + B + Ci; end`

  - El bloque `always @(*)` indica que el contenido se ejecuta cada vez que alguna de las señales de entrada cambie (`A, B o Ci`).

   - El (`*`) significa "sensibilidad implícita a todas las señales utilizadas dentro del bloque". Esto garantiza que el comportamiento sea combinacional y no secuencial.

   - Dentro del bloque, se realiza la operación aritmética de suma:

$$
\begin{gathered}
sum-all = A + B +C_i 
\end{gathered}
$$
 
  - El resultado se guarda en sum_all.

**Extracción de salidas**

```verilog
assign Co = sum_all[1];
assign So = sum_all[0];
```
- `sum_all[0]` (bit menos significativo) corresponde al resultado de la suma (So).

- `sum_all[1]` (bit más significativo) corresponde al acarreo (Co).

**Enfoques del diseño**

- En el diseño anterior, se utilizaban compuertas lógicas explícitas (XOR, AND, OR) para construir el sumador.

- En este caso, se aprovecha la operación aritmética directa y el almacenamiento en un registro de 2 bits.

- Ambos enfoques son equivalentes en funcionalidad, pero este segundo resulta más compacto y legible, ya que delega la construcción de las compuertas al sintetizador.

#### **Forma 3: Usando directamente primitivas de compuertas lógicas**

Este módulo implementa un sumador completo de 1 bit utilizando únicamente compuertas lógicas básicas (XOR, AND, OR) en lugar del operador aritmético

**Entradas:**

- `A, B:` bits a sumar.

- `Ci:` acarreo de entrada.

**Salidas:**

- `So:` bit de suma resultante.

- `Co:` acarreo de salida.

**Señales internas**

- `x_ab:` resultado de la operación `A ⊕ B`.

- `cout_t:` parte del acarreo generado cuando `(A ⊕ B) · Ci`.

- `a_ab:` parte del acarreo generado cuando `A · B`.

**Construcción de la lógica**

**1. `xor(x_ab, A, B);`**

   - Calcula `A ⊕ B`.

   - Se almacena en la señal `x_ab`.

**2. `xor(So, x_ab, Ci)`;**

   - Calcula So = `(A ⊕ B) ⊕ Ci`.

   - Corresponde al bit de suma final.

**3. `and(cout_t, x_ab, Ci);`**

   - Genera una parte del acarreo cuando el `Ci` y `A ⊕ B` son ambos `1`.

**4. `and(a_ab, A, B);`**

   - Genera otra parte del acarreo cuando tanto `A` como `B` son `1`.

**5. `or(Co, cout_t, a_ab);`**

   - Une las dos condiciones anteriores para producir el acarreo de salida (Co).

   - Equivale a la ecuación:

$$
\begin{gathered}
C₀ = C_i \cdot (A \oplus B) + AB 
\end{gathered}
$$

**Enfoque del diseño**

- Este diseño usa primitivas de compuertas en lugar de operadores lógicos (`^`, `&`, `|`).

- Es un enfoque estructural muy cercano al hardware, ya que cada línea corresponde a una compuerta lógica real.

- Permite visualizar con claridad cómo se construye el sumador a partir de XOR, AND y OR.

#### **¿Como se genera el acarreo en el sumador de 1 bit?**

El acarreo de salida (`Co`) se activa cuando la suma de las entradas excede la capacidad de representar un solo bit. Existen dos casos principales en los que esto ocurre:  

1. **Caso A y B en 1**  
   - Si `A = 1` y `B = 1`, su suma ya es `2` en decimal, que en binario se representa como `10`.  
   - En este caso, la salida de la suma (`So`) es `0` y el acarreo (`Co`) vale `1`.  
   - Esto se representa con la expresión lógica:  

$$
\begin{gathered}
     A \cdot B  
\end{gathered}
$$

2. **Caso Ci y (A ⊕ B) en 1**  
   - Cuando `A` y `B` son diferentes (`A ⊕ B = 1`), el resultado parcial es `1`.  
   - Si además el acarreo de entrada (`Ci`) es `1`, la suma es `2` (binario `10`).  
   - En este caso también se genera un acarreo.  
   - La expresión lógica es:  
     
$$
\begin{gathered}
     Ci \cdot (A \oplus B)
\end{gathered}
$$

3. **Unión de los casos**  
   - El acarreo de salida resulta de la combinación de ambos escenarios mediante una compuerta OR:  
$$
\begin{gathered}
     C₀ = C_i \cdot (A \oplus B) + AB 
\end{gathered}
$$

### **1.4 Diagramas**

#### **Forma 1**

**Diagrama en Proteus**

Recordando las expresiones logicas obtenidas de los mapas de Karnaugh del apartado [Obtencion de expresiones Logicas](#12-construcción-de-la-tabla-de-verdad) se realizo el esquema de conexiones usando las compuertas Logicas.

![DIAGRAMA](/IMAGENES/Diagrama_suma1bit.png)

**Diagrama generado en Quartus**

Una de las formas de mirar el resultado o el progreso del diseño en HDL es visualizarlo en forma de bloque(RTL), Quartus permite ver como se van conectando los componentes a medida de que se valla avanzando en el HDL,para esta paractica este fue el resultado.

![DIAGRAMA](/IMAGENES/Diagrama_suma1bit_q.png)

Como se puede ver el diseño es el mismo que se implemento en Proteus la diferencia es que las compuertas estan ordenadas de otra forma pero las conexiones no cambian por lo que su funcionamiento es igual.

#### **Forma 2**

![DIAGRAMA](/IMAGENES/Diagrama_suma1bit(2forma).png)

**Descripción del diagrama**

El diseño utiliza un enfoque aritmético con `sum_all`. En él, las entradas `A` y `B` se suman primero en el bloque `Add0`, generando un resultado parcial de 2 bits que luego se combina con el acarreo de entrada `Ci` en el bloque `Add1`. El resultado final también es de 2 bits y corresponde al valor almacenado en `sum_all` en el código Verilog. De este resultado, el bit menos significativo se asigna a la salida de la suma (`So`), mientras que el bit más significativo se asigna al acarreo de salida (`Co`). De esta forma, el diagrama confirma cómo el bloque `always @(*)` `sum_all = A + B + Ci` traduce la operación aritmética de la suma en hardware, separando automáticamente las salidas de suma y acarreo.

#### **Forma 3**

![DIAGRAMA](/IMAGENES/Diagrama_suma1bit(3forma).png)

Este diagrama de conexiones entre las compuertas es igual al [enfoque 1](#forma-1), eso es por que se utiliza primitivas como xor, and y or. la diferencia esque este diseño se usan palabras reservadas de verilog para referirse a las compuertas, mientras que en el primero se usan simbolos para definir las compuertas.

## 2. Sumador de 4 bits

#### **2.1 Descripción**

1. **Análisis del bloque funcional**  
  El sumador de 4 bits es un circuito combinacional construido a partir de cuatro sumadores de 1 bit conectados en cascada. Cada sumador de 1 bit se encarga de realizar la suma de dos bits individuales, junto con el acarreo de la etapa anterior, generando como salida un bit de la suma y un nuevo acarreo. De esta forma, el resultado total se obtiene uniendo las salidas de cada bloque.

  ![DIAGRAMA](/IMAGENES/DIAGRAMA_4BIT.png)

#### **Entradas del circuito**

- **A[3:0]** → Primer operando binario de 4 bits (A3, A2, A1, A0).

- **B[3:0]** → Segundo operando binario de 4 bits (B3, B2, B1, B0).

- **Ci (Carry in)** → Acarreo de entrada inicial, normalmente 0 si no hay suma previa.

#### **Salidas del circuito**

- ** `So[3:0] `** → Resultado de la suma en 4 bits (So3, So2, So1, So0).

- ** `Co (Carry out) `** → Acarreo final de salida generado por el último sumador (MSB).

#### **Conexión interna entre los bloques**

- **Sumador de 1 bit (bit 0)**:
Recibe  `A0 `,  `B0 ` y  `Ci `. Genera  `So0 ` y un acarreo interno  `C0 `.

- **Sumador de 1 bit (bit 1)**:
Recibe  `A1 `,  `B1 ` y el acarreo  `C0 `. Genera  `So1 ` y un acarreo  `C1 `.

- **Sumador de 1 bit (bit 2)**:
Recibe  `A2 `,  `B2 ` y el acarreo  `C1 `. Genera  `So2 ` y un acarreo  `C2 `.

- **Sumador de 1 bit (bit 3)**:
Recibe  `A3 `,  `B3 ` y el acarreo  `C2 `. Genera  `So3 ` y el acarreo final  `Co `.


#### **Diseño en HDL Verilog**

**ENLACE A `suma_4bit.v`.**

Para ver a detalle el codigo implementado por favor dar click en el siguiente vinculo

| Archivo          | Descripción           | Tipo       |
|------------------|-----------------------|------------|
| [suma_4bit.v](/Sumador_4bit/suma_4bit.v)  | Archivo Principal | v       |
#### **2.2 Diagramas**

**Diagrama generado en Quartus**

Una de las formas de mirar el resultado o el progreso del diseño en HDL es visualizarlo en forma de bloque(RTL), Quartus permite ver como se van conectando los componentes a medida de que se valla avanzando en el HDL,para esta paractica este fue el resultado.

![DIAGRAMA](/IMAGENES/SIMULACION_4BIT_QUARTUS.png)

## **Simulaciones** 

### **1. Simulación del sumador de 1 bit**

### **1.1 Descripción**

Para verificar el correcto funcionamiento del sumador de 1 bit, se implementó un **testbench** en Visual code.  
Un testbench es un archivo de prueba que no se sintetiza en hardware, sino que se utiliza únicamente en simulación.  
Su función es aplicar estímulos (valores de entrada) al módulo en prueba y observar las respuestas de salida.  

#### **Procedimiento**

**1. Configuración inicial**

 `timescale 1ns / 1ps`

Define la escala de tiempo de la simulación:

  - La unidad de tiempo es 1 nanosegundo (ns).

  - La precisión es de 1 picosegundo (ps).

 `include "Sumador_1bit/suma_1bit.v" `

Incluye el archivo del módulo que se desea probar ( `suma_1bit.v `).

**2. Declaración de señales**

- `reg A, B, Ci;` → Entradas que serán controladas en el testbench
- `wire Co, So;` → Salidas generadas por el módulo bajo prueba

**3. Instanciación del módulo bajo prueba**

Se crea la instancia UUT (Unit Under Test), conectando las señales del testbench con los puertos del sumador.

**4. Generación de estímulos**

Dentro del bloque `initial begin ... end` se aplican todas las combinaciones posibles de entradas:

- Cada combinación se mantiene activa por un retardo de 10 ns (`#10`)
- Se recorren los 8 casos posibles de la tabla de verdad del sumador completo
- Finalmente, `#10 $finish;` termina la simulación

**5. Registro de resultados**

```verilog
initial begin
    $dumpfile("suma_ibit_tb.vcd");
    // ...
end
```
#### **Forma 3 y Forma 3**

El archivo testbench es igual para los dos enfoques solo cambia el archivo [suma_1bit.v](/Sumador_1bit/suma_1bit.v).

### **1.2 Diagrama**

**Señales obtenidas**

![DIAGRAMA](/IMAGENES/Simulación_1bit.png)
 
Las señales de entrada (`A`, `B`, `Ci`) fueron aplicadas secuencialmente en intervalos de 10 ns, recorriendo todas las combinaciones posibles (8 casos).  
Las salidas (`So` y `Co`) responden de acuerdo con la tabla de verdad del sumador completo.  

**Interpretación de resultado**

**Caso de simulación: A = 0, B = 1, Ci = 1**

Cuando se aplican las entradas `A = 0`, `B = 1` y `Ci = 1`, el sumador de 1 bit realiza la siguiente operación:

$$
\begin{gathered}
S₀ = C_i \oplus (A \oplus B)
\end{gathered}
$$

$$
\begin{gathered}
Co = C_i \cdot (A \oplus B) + AB 
\end{gathered}
$$

#### Cálculo paso a paso
1. **Suma parcial**  

$$
\begin{gathered}
   A \oplus B = 0 \oplus 1 = 1
\end{gathered}
$$ 
   Luego,  
$$
\begin{gathered}
   So = (A \oplus B) \oplus Ci = 1 \oplus 1 = 0
\end{gathered}
$$ 

2. **Acarreo de salida**  

- Primer término:  
$$
\begin{gathered}
     A \cdot B = 0 \cdot 1 = 0
\end{gathered}
$$  
   - Segundo término:  
$$
\begin{gathered}
     Ci \cdot (A \oplus B) = 1 \cdot 1 = 1
\end{gathered}
$$ 
   - Sumando ambos:  
$$
\begin{gathered}
     Co = 0 + 1 = 1
\end{gathered}
$$

#### Resultado
- **So = 0**  
- **Co = 1**  

#### Interpretación
En este caso, la suma de las entradas es:  

$$
\begin{gathered}
0 + 1 + 1 = 2 \quad \text{(decimal)}
\end{gathered}
$$

En binario, el número 2 se representa como `10`, donde:  
- El bit menos significativo (`0`) corresponde a la salida **So**.  
- El bit más significativo (`1`) corresponde al **acarreo Co**.  

#### **Digrama forma 2**

![DIAGRAMA](/IMAGENES/Simulación_1bit(forma3).png)

#### **Diagrama forma 3**

![DIAGRAMA](/IMAGENES/Simulación_1bit(forma2).png)

Como se puede ver en todos los enfoques, el resultado es el mismo, por lo que uso del enfoque dependera de cual resulte mas util o cual sea mas sencillo para implementar.

**ENLACE A `suma_1bit_tb.v`.**

Para ver a detalle el codigo implementado por favor dar click en el siguiente vinculo

| Archivo          | Descripción           | Tipo       |
|------------------|-----------------------|------------|
| [suma_1bit_tb.v](/Sumador_1bit/suma_1bit_tb.v)  | Archivo De Prueba | v    

### 2. Simulación del sumador de 4 bits

#### 2.1 Descripción

Con el objetivo de comprobar el correcto funcionamiento del sumador de 4 bits, se elaboró un testbench en Visual Studio Code.
Un testbench no se sintetiza en hardware, sino que se utiliza únicamente en la simulación. Su propósito es aplicar estímulos a las entradas del módulo y verificar que las salidas coincidan con el comportamiento esperado.

#### **Procedimiento**

**Configuración inicial**

```verilog
`timescale 1ns / 1ps
`include "Sumador_4bit/suma_4bit.v"
`include "Sumador_4bit/suma_1bit2.v"
```
   * La unidad de tiempo de la simulación se establece en 1 ns.

* La precisión mínima es de 1 ps.

* Se incluyen los módulos que se desean probar: el sumador de 1 bit y el de 4 bits, ya que el primero se utiliza como bloque dentro del segundo.

**Declaración de señales**

En el testbench se definen las señales que conectan con el módulo bajo prueba:

**Entradas :**

* `A_tb[3:0]:` primer operando binario de 4 bits.

* `B_tb[3:0]:` segundo operando binario de 4 bits.

* `Ci_tb:` acarreo de entrada.

**Salidas :**

* `So_tb[3:0]:` suma de 4 bits.

* `Co_tb:` acarreo de salida.

### Instanciación del módulo bajo prueba
El módulo SUMADOR_4BIT se conecta con las señales declaradas en el testbench mediante la instancia uut (Unit Under Test).
   ```verilog
 suma_4bit uut (
        .A(A_tb),
        .B(B_tb),
        .Ci(Ci_tb),
        .S(So_tb),
        .Co(Co_tb)
    );
   ```
### Generación de estímulos
En el bloque initial begin ... end se aplican combinaciones de entrada para recorrer los posibles valores de A y B.

Cada combinación permanece activa durante 10 ns (#10).

El bucle for incrementa las entradas de manera automática.

   ```verilog
for (B_tb = 0; B_tb < 16; B_tb = B_tb + 1) begin
    if (B_tb == 0) begin
        A_tb = A_tb + 1;
    end
    #10;
end
   ```
   **Función de `if (B_tb == 0)`**

Cada vez que B_tb vuelva a ser 0, el código incrementa en 1 el valor de A_tb.
Esto ocurre al inicio de cada ciclo de 16 valores de B_tb.
**En otras palabras:**

Cuando B_tb recorre de 0 a 15, el número A_tb ya está fijo.

Al regresar a B_tb = 0, A_tb se incrementa y empieza un nuevo bloque de pruebas.
### Generacion de archivo (vcd)

**1.`$dumpfile("suma_4bit_tb.vcd");`**

* Esta instrucción crea un archivo con nombre sumador_4.vcd.

* La extensión .vcd significa Value Change Dump (volcado de cambios de valores).

* Este archivo guarda todas las transiciones de las señales (entradas y salidas) durante la simulación.

* Más adelante puedes abrirlo en un programa como GTKWave para ver las formas de onda gráficamente.

**2. `$dumpvars(-1, suma_4bit_tb);`**

Le indica al simulador qué señales quieres guardar dentro del archivo .vcd.

Los parámetros son:

* `-1` → significa "guardar todas las señales del módulo y de sus submódulos".

* BSUMADOR_4BIT → es el nombre de tu testbench.

En este caso, se van a guardar:

* Las entradas `A_tb`, `B_tb`, `Ci_tb`.

* Las salidas `So_tb`, `Co_tb`.

Y también las señales internas que se generan dentro del sumador de 4 bits y de 1 bit.

#### 2.2 Diagrama

**Señales obtenidas**

![DIAGRAMA](/IMAGENES/SIMULACION_GTKWAVE.png)

### Señales principales dentro del testbench
* `A_tb [3:0]` → primer operando binario de 4 bits (0 a 15).

* `B_tb [3:0]` → segundo operando binario de 4 bits (0 a 15).

* `Ci_tb` → acarreo de entrada (en tu caso siempre en 0).

* `So_tb [3:0]` → salida de la suma, pero limitada a 4 bits.

* `Co_tb` → acarreo de salida, que se activa cuando el resultado es mayor a 15.
### ¿Qué ocurre al desbordarse la suma?
Cuando el resultado de A_tb + B_tb es mayor que 15 (es decir, excede 4 bits):

**So_tb [3:0] muestra únicamente los 4 bits menos significativos del resultado.**

* Ejemplo: A = 9, B = 12 → suma = 21 → binario = 10101.

* Los 4 bits menos significativos son 0101 → So_tb = 5.

**Cout_tb se pone en 1 indicando que hubo un acarreo de salida.**

* En el ejemplo anterior, como la suma fue 10101 (5 bits), el bit extra a la izquierda (1) es el acarreo.
 ### Ejemplo algunos casos de desbordamiento
 | **A\_tb** | **B\_tb** | **Resultado decimal** | **Resultado binario (5 bits)** | **So\_tb \[3:0]** | **Cout\_tb** |
| --------- | --------- | --------------------- | ------------------------------ | ----------------- | ------------ |
| 9         | 12        | 21                    | 10101                          | 0101 (5)          | 1            |
| 7         | 15        | 22                    | 10110                          | 0110 (6)          | 1            |
| 10        | 10        | 20                    | 10100                          | 0100 (4)          | 1            |
| 14        | 3         | 17                    | 10001                          | 0001 (1)          | 1            |
| 15        | 15        | 30                    | 11110                          | 1110 (14)         | 1            |

**ENLACE A `suma_4bit_tb.v`.**

Para ver a detalle el codigo implementado por favor dar click en el siguiente vinculo

| Archivo          | Descripción           | Tipo       |
|------------------|-----------------------|------------|
| [suma_4bit_tb.v](/Sumador_4bit/suma_4bit_tb.v)  | Archivo De Prueba | 

## Evidencias de implementación

**Asignación de Pines: sumador_1bit**
![DIAGRAMA](/IMAGENES/Pines_sumador_1bit.png)

[Sumador_1bit](https://youtube.com/shorts/zZ4dWt2NtYc?feature=share)

**Asignación de Pines: sumador_4bit**

![DIAGRAMA](/IMAGENES/Pines_sumador_4bit.png)
[Sumador_4Bit](https://youtube.com/shorts/ysaNDF5d5DQ?feature=share)

## Preguntas

1. Describa el enfoque estructural y comportamental en el contexto de electrónica digital y cómo los implementó. ¿Qué hace Quartus con cada uno?

**Respuesta**

En electrónica digital, existen dos enfoques principales para describir un circuito en HDL:

- **Enfoque estructural**

  El enfoque estructural consiste en implementar el diseño utilizando compuertas lógicas básicas o interconectando módulos más pequeños. Para el sumador de 1 bit, esto se logró usando tanto primitivas de compuertas (xor, and, or) como operadores lógicos equivalentes (^, &, |). En el caso del sumador de 4 bits, se aplicó el mismo concepto conectando en cascada cuatro sumadores de 1 bit a través de sus señales de acarreo. Quartus interpreta estas conexiones y las traduce directamente en una red de compuertas dentro del hardware de la FPGA, resultando en una implementación muy cercana al nivel físico del circuito.

- **Enfoque comportamental (o conductual)**

  El enfoque comportamental describe el funcionamiento del circuito mediante operaciones aritméticas o bloques always, sin especificar su implementación interna con compuertas. En el sumador de 1 bit, esto se logró utilizando un bloque always con la operación A + B + Ci, cuyo resultado se almacena en un bus de 2 bits para luego separar la suma (So) y el acarreo (Co). Quartus sintetiza esta expresión matemática y genera automáticamente un circuito equivalente basado en compuertas lógicas (XOR, AND, OR), obteniendo el mismo resultado hardware que el enfoque estructural, pero abstraiendo al diseñador de los detalles de implementación.


**2. ¿Qué es la instanciación de un módulo en Verilog y cómo se aplica en un diseño digital?**

**Respuesta**

La instanciación de módulos en Verilog es el proceso de reutilizar un circuito previamente definido como componente dentro de un diseño más grande. Esto permite conectar módulos existentes con las señales del sistema actual, facilitando el diseño jerárquico y modular. Por ejemplo, en el sumador de 4 bits, se crearon cuatro instancias independientes del sumador de 1 bit (suma_1bit2), cada una identificada como FA0, FA1, FA2 y FA3. Estas instancias se interconectaron mediante las señales de acarreo, donde la salida Co de una etapa se convierte en la entrada Ci de la siguiente. Quartus interpreta estas conexiones y genera el hardware correspondiente, demostrando cómo bloques simples pueden combinarse para construir sistemas complejos de manera organizada y eficiente.

**3. Presente el uso de recursos de la FPGA correspondiente a los diseños implementados.**

#### **Recursos implentación: Sumador_1bit**

![DIAGRAMA](/IMAGENES/Recursos_FPGA_1BIT.png)

**Uso de recursos en la FPGA – Sumador de 1 bit**

El reporte de **Quartus Prime** muestra los recursos de la FPGA utilizados por el diseño del sumador de 1 bit. Este análisis permite verificar la eficiencia del circuito y entender su impacto en el hardware.

**Resultados de la síntesis**

- **Logic Cells (celdas lógicas):** 3  
- **Dedicated Logic Registers:** 0 (no se usan flip-flops, ya que es un circuito combinacional).  
- **Memory Bits / M9Ks / UFM Blocks:** 0 (no se usan memorias).  
- **DSP Elements:** 0 (no se requieren bloques aritméticos avanzados).  
- **Pins:** 5 (corresponden a las entradas `A`, `B`, `Ci` y a las salidas `So`, `Co`).  
- **LUTs (Look-Up Tables):** 3, que implementan la lógica de suma y acarreo.  

**Tabla resumen**

| Recurso utilizado        | Cantidad |
|---------------------------|----------|
| Logic Cells (LEs)         | 3        |
| Dedicated Logic Registers | 0        |
| Pins                      | 5        |
| Memory Bits               | 0        |
| DSP Elements              | 0        |

**Analisis**

El reporte confirma que el **sumador de 1 bit es un circuito muy ligero en hardware**, pues únicamente requiere 3 celdas lógicas y 5 pines de entrada/salida. No utiliza registros, memorias ni bloques DSP, lo que concuerda con su naturaleza de **circuito combinacional simple**.

#### **Recursos implentación: Sumador_4bit**

![DIAGRAMA](/IMAGENES/Recursos_FPGA_4BIT.png)

El reporte de **Quartus Prime** muestra los recursos de la FPGA utilizados por el diseño del sumador de 4 bits. En este caso, el diseño se implementó de manera estructural instanciando **cuatro sumadores de 1 bit** en cascada.  

### Resultados de la síntesis
- **Logic Cells (celdas lógicas):** 9 en total  
- **Dedicated Logic Registers:** 0 (diseño combinacional, no requiere almacenamiento).  
- **Memory Bits / M9Ks / UFM Blocks:** 0 (no usa memorias).  
- **DSP Elements:** 0 (no usa bloques aritméticos avanzados).  
- **Pins:** 14 (corresponden a los 4 bits de entrada `A`, 4 bits de entrada `B`, el acarreo de entrada `Ci`, las 4 salidas de la suma `S` y el acarreo de salida `Co`).  
- **LUTs (Look-Up Tables):** 9, distribuidas en las cuatro instancias de sumadores de 1 bit.  

### Tabla resumen

| Recurso utilizado        | Cantidad |
|---------------------------|----------|
| Logic Cells (LEs)         | 9        |
| Dedicated Logic Registers | 0        |
| Pins                      | 14       |
| Memory Bits               | 0        |
| DSP Elements              | 0        |

**Analisis**

El sumador de 4 bits utiliza 9 celdas lógicas y 14 pines de la FPGA, lo que demuestra cómo el consumo de recursos escala al instanciar múltiples sumadores de 1 bit. A pesar de este incremento, el porcentaje de utilización sigue siendo muy bajo en comparación con la capacidad total de la FPGA.

**4. Investigue y describa las diferencias entre los tipos de dato ```wire``` y  ```reg``` en Verilog y compare ambos con el tipo de dato ```logic``` en System Verilog.**

Diferencias entre `wire`, `reg` en Verilog y `logic` en SystemVerilog  

En Verilog, las señales se declaran principalmente con los tipos de datos `wire` y `reg`, mientras que en SystemVerilog se introdujo el tipo `logic` para simplificar y unificar el manejo de señales.  

#### 1. `wire` en Verilog  
- Representa **conexiones físicas** entre módulos o compuertas.  
- No puede almacenar un valor por sí mismo, solo refleja el valor que recibe de una asignación continua (`assign`) o de la salida de otro módulo.  
- Uso típico: señales combinacionales y conexiones entre bloques.  

Ejemplo:  

```verilog
wire s;
assign s = a & b; // asignación continua
```

#### 2. `reg` en Verilog

- Puede almacenar un valor hasta que se le asigne otro, aunque no necesariamente implica un registro físico (flip-flop) a menos que se use en lógica secuencial.

- Se usa dentro de bloques procedimentales (always o initial).

- Uso típico: variables temporales, salidas de lógica secuencial o combinacional descrita con always.

Ejemplo:

```verilog
reg q;
always @(posedge clk) begin
    q <= d; // se comporta como un flip-flop
end
```

#### 3. `logic` en SystemVerilog

- Combina características de wire y reg.

- Puede ser usado en asignaciones continuas y dentro de bloques always.

- Evita la confusión clásica de Verilog entre usar wire o reg.

- Detecta errores de conducción múltiple (dos fuentes asignando a la misma señal).

Ejemplo:

```verilog
logic s;
assign s = a ^ b; // asignación continua válida

always_comb begin
    s = a & b; // también válido en bloque procedimental
end
```
**Comparación**

| Característica         | wire (Verilog) | reg (Verilog) | logic (SystemVerilog) |
|------------------------|----------------|---------------|-----------------------|
| ¿Almacena valor?       |  No           |  Sí          |  Sí                  |
| Tipo de asignación     | assign (continua) | Procedimental (always) | Ambas (assign y always) |
| Uso principal          | Conexiones combinacionales | Variables en bloques secuenciales/combinacionales | Señal genérica unificada |
| ¿Genera flip-flops?    |  Nunca        |  Si está en always @(posedge clk) |  Si está en always_ff |
| Lenguaje               | Verilog        | Verilog       | SystemVerilog         |

**5. Únicamente con lo que se vio en clase, describa cómo se usó el bloque ```always```.** 

En el diseño del **sumador de 1 bit**, se implementó una variante utilizando el bloque `always` para describir el comportamiento aritmético del circuito en lugar de emplear directamente compuertas lógicas o asignaciones continuas.  

El bloque `always @(*)` se activaba cada vez que alguna de las entradas (`A`, `B`, `Ci`) cambiaba de valor. Dentro de este bloque, se realizaba la operación aritmética completa:  

```verilog
reg [1:0] sum_all;

always @(*) begin
    sum_all = A + B + Ci; 
end

assign Co = sum_all[1];
assign So = sum_all[0];
```
**Explicación**

- Dentro del bloque always @(*), se describió el comportamiento esperado del sumador: realizar la operación A + B + Ci.

- Posteriormente, se asignaron las salidas:

  - So (bit menos significativo) representa el resultado de la suma.

  - Co (bit más significativo) corresponde al acarreo de salida.

En resumen el uso del bloque always en este diseño representa un enfoque comportamental, donde se describe qué hace el circuito (sumar tres bits) en lugar de detallar cómo se construye con compuertas lógicas. Quartus, durante la síntesis, traduce esta descripción a un circuito combinacional equivalente compuesto por compuertas XOR, AND y OR

## Conclusiones

1. El sumador de 1 bit permite comprender de manera clara la lógica combinacional de la operación de suma, ya que a partir de su tabla de verdad se definen las expresiones booleanas que generan tanto la suma como el acarreo, sirviendo como bloque elemental en el diseño aritmético digital.

2. El sumador de 4 bits demuestra cómo, mediante la conexión en cascada de sumadores de 1 bit, se logra extender el mismo principio de funcionamiento a números de mayor longitud, asegurando la propagación correcta del acarreo entre cada bit.

3. La importancia del sumador de 1 bit radica en que sin este bloque no sería posible construir sumadores más complejos, pues su funcionamiento modular permite escalar diseños digitales de forma ordenada y reutilizable.

4. La comparación entre ambos diseños evidencia que el paso de un sumador de 1 bit a uno de 4 bits no modifica la lógica fundamental, sino que amplía su aplicación, mostrando cómo los sistemas digitales se desarrollan a partir de bloques básicos interconectados.

## Referencias

🔗 [Documentación del Laboratorio 1](https://github.com/DianaNatali/ECCI-Arquitectura-de-Procesadores-2025-II/blob/main/labs/01_lab01/README.md)

📖 [Documentación oficial de Verilog - UEx](http://digital.unex.es/wiki/doku.php?id=pub:vlog)

[def]: IMAGENES/sumador_1bit.pn