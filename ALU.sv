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

module adder_1bit(
    input a,
    input b,
    input carry_in,
    output add,
    output carry_out
    );

    wire s1;
    wire c1,c2;

    xor(s1, a,b);
    and(c1,a,b);
    
    xor(add,s1,carry_in);
    and(c2,s1,carry_in);

    or(carry_out,c1,c2);
    endmodule

module adder_4bit(
    input  a0, a1, a2, a3,
    input  b0, b1, b2, b3,
    output s0, s1, s2, s3,
    output carry_out
);
    wire c0, c1, c2;
   
    adder_1bit bit0(
        .a(a0),
        .b(b0),
        .carry_in(1'b0),  // (1'b0) representa el cero de un bit.
        .add(s0),
        .carry_out(c0)
         );
    adder_1bit bit1(
        .a(a1),
        .b(b1),
        .carry_in(c0),    
        .add(s1),
        .carry_out(c1)
        );

    adder_1bit bit2(
        .a(a2),
        .b(b2),
        .carry_in(c1),    
        .add(s2),
        .carry_out(c2)
        );

    adder_1bit bit3(
        .a(a3),
        .b(b3),
        .carry_in(c2),    
        .add(s3),
        .carry_out(carry_out)  
        );

endmodule
    
    //------------------------- SUB (110) -------------------------
    
logic c0, c1, c2; // Acarreos intermedios
logic sum0, sum1, sum2, sum3; // Resultados temporales de la suma
logic nb0, nb1, nb2, nb3; 


    not_gate u_not0 (.a(b_in_0), .y(nb0));
    not_gate u_not1 .y(nb2));
    not_gate u_not3 (.a(b_in_3), .y(nb3));
    
    
    //------------------------- PIB (111) -------------------------
    
    //---------------------------- MUX ----------------------------

    
    //--------------------------- FLAGS ---------------------------
    
    
endmodule
