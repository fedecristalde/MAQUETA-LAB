`timescale 1ns / 1ps

module alu(
    input a_in_0,
    input a_in_1,
    input a_in_2,
    input a_in_3,
    input b_in_0,
    input b_in_1,
    input b_in_2,
    input b_in_3,
    input alu_op_0,
    input alu_op_1,
    input alu_op_2,
    output alu_result_0,
    output alu_result_1,
    output alu_result_2,
    output alu_result_3,
    output zero_flag,
    output carry_flag
    );
    

       
    //------------------------- AND (000) -------------------------
    
    //------------------------- OR  (001) -------------------------
    
    //------------------------- ADD (010) -------------------------
`timescale 1ns / 1ps

logic c0, c1, c2; // Acarreos intermedios
logic sum0, sum1, sum2, sum3; // Resultados temporales de la suma

adder_1bit bit0 (
    .a(a_in_0), 
    .b(b_in_0), 
    .carry_in(1'b0), //acarreo inicial es 0
    .add(sum0), 
    .carry_out(c0)
);

adder_1bit bit1 (
    .a(a_in_1), 
    .b(b_in_1), 
    .carry_in(c0),
    .add(sum1), 
    .carry_out(c1)
);

adder_1bit bit2 (
    .a(a_in_2), 
    .b(b_in_2), 
    .carry_in(c1),
    .add(sum2), 
    .carry_out(c2)
);

adder_1bit bit3 (
    .a(a_in_3), 
    .b(b_in_3), 
    .carry_in(c2),
    .add(sum3), 
    .carry_out(carry_flag)
);



   
    //------------------------- SUB (110) -------------------------

`timescale 1ns / 1ps

// Cables para inversión (Complemento a 1)
logic nb0, nb1, nb2, nb3; 

// Cables para B en Complemento a 2 (-B)
logic comp_b0, comp_b1, comp_b2, comp_b3;
logic c_c0, c_c1, c_c2, c_c3;

// Cables para el resultado final de la resta (A - B)
logic res_sub0, res_sub1, res_sub2, res_sub3;
logic c_s0, c_s1, c_s2, c_s3;

// Invierto bits de B (NOT)
not_gate u_not0 (.a(b_in_0), .y(nb0));
not_gate u_not1 (.a(b_in_1), .y(nb1));
not_gate u_not2 (.a(b_in_2), .y(nb2));
not_gate u_not3 (.a(b_in_3), .y(nb3));

// Obtener el B negado (sumar 1 bit al valor invertido)
// Se suma nb + 0001
adder_1bit u_comp0 (.a(nb0), .b(1'b1), .carry_in(1'b0), .add(comp_b0), .carry_out(c_c0));
adder_1bit u_comp1 (.a(nb1), .b(1'b0), .carry_in(c_c0), .add(comp_b1), .carry_out(c_c1));
adder_1bit u_comp2 (.a(nb2), .b(1'b0), .carry_in(c_c1), .add(comp_b2), .carry_out(c_c2));
adder_1bit u_comp3 (.a(nb3), .b(1'b0), .carry_in(c_c2), .add(comp_b3), .carry_out(c_c3));

//Realizar A + (-B)
adder_1bit u_sub0 (.a(a_in_0), .b(comp_b0), .carry_in(1'b0), .add(res_sub0), .carry_out(c_s0));
adder_1bit u_sub1 (.a(a_in_1), .b(comp_b1), .carry_in(c_s0), .add(res_sub1), .carry_out(c_s1));
adder_1bit u_sub2 (.a(a_in_2), .b(comp_b2), .carry_in(c_s1), .add(res_sub2), .carry_out(c_s2));
adder_1bit u_sub3 (.a(a_in_3), .b(comp_b3), .carry_in(c_s2), .add(res_sub3), .carry_out(c_s3));

    //------------------------- PIB (111) -------------------------
    
    //---------------------------- MUX ----------------------------
    module mux8_1 (
    input  logic       d0,  // Data input 0 (selected when sel == 3'b000)
    input  logic       d1,  // Data input 1 (selected when sel == 3'b001)
    input  logic       d2,  // Data input 2 (selected when sel == 3'b010)
    input  logic       d3,  // Data input 3 (selected when sel == 3'b011)
    input  logic       d4,  // Data input 4 (selected when sel == 3'b100)
    input  logic       d5,  // Data input 5 (selected when sel == 3'b101)
    input  logic       d6,  // Data input 6 (selected when sel == 3'b110)
    input  logic       d7,  // Data input 7 (selected when sel == 3'b111)
    input  logic       sel_0, // 3-bit Select signal
    input  logic       sel_1, // 3-bit Select signal
    input  logic       sel_2, // 3-bit Select signal
    output logic       y    // Output y
    );
    
    always_comb begin
        case ({sel_2,sel_1,sel_0})
            3'b000:  y = d0;
            3'b001:  y = d1;
            3'b010:  y = d2;
            3'b011:  y = d3;
            3'b100:  y = d4;
            3'b101:  y = d5;
            3'b110:  y = d6;
            3'b111:  y = d7;
            default: y = 'x; // Assign 'x' for unknown select value
        endcase
    end
endmodule

    module mux8_2 (
    input  logic       d0,  // Data input 0 (selected when sel == 3'b000)
    input  logic       d1,  // Data input 1 (selected when sel == 3'b001)
    input  logic       d2,  // Data input 2 (selected when sel == 3'b010)
    input  logic       d3,  // Data input 3 (selected when sel == 3'b011)
    input  logic       d4,  // Data input 4 (selected when sel == 3'b100)
    input  logic       d5,  // Data input 5 (selected when sel == 3'b101)
    input  logic       d6,  // Data input 6 (selected when sel == 3'b110)
    input  logic       d7,  // Data input 7 (selected when sel == 3'b111)
    input  logic       sel_0, // 3-bit Select signal
    input  logic       sel_1, // 3-bit Select signal
    input  logic       sel_2, // 3-bit Select signal
    output logic       y    // Output y
    );
    
    always_comb begin
        case ({sel_2,sel_1,sel_0})
            3'b000:  y = d0;
            3'b001:  y = d1;
            3'b010:  y = d2;
            3'b011:  y = d3;
            3'b100:  y = d4;
            3'b101:  y = d5;
            3'b110:  y = d6;
            3'b111:  y = d7;
            default: y = 'x; // Assign 'x' for unknown select value
        endcase
    end
endmodule
    
    
    //--------------------------- FLAGS ---------------------------
    
    
endmodule
