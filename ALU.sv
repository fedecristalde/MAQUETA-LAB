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
    logic ca0, ca1, ca2, ca3;
    
    and_gate y0 (.a(a_in_0), .b(b_in_0), .y(ca0));
    and_gate y1 (.a(a_in_1), .b(b_in_1), .y(ca1));
    and_gate y2 (.a(a_in_2), .b(b_in_2), .y(ca2));
    and_gate y3 (.a(a_in_3), .b(b_in_3), .y(ca3));
        

    
    
    //------------------------- OR  (001) -------------------------
    
    //------------------------- ADD (010) -------------------------
    logic c0, c1, c2; 
    logic sum0, sum1, sum2, sum3; 

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
    .carry_out(carry_flag_add)
);

    
    //------------------------- SUB (110) -------------------------
    
    logic c00, c01, c02; 
    logic sum00, sum01, sum02, sum03; 
    logic nb0, nb1, nb2, nb3; 

not_gate u_not0 (.a(b_in_0), .y(nb0));
not_gate u_not1 (.a(b_in_1), .y(nb1));
not_gate u_not2 (.a(b_in_2), .y(nb2));
not_gate u_not3 (.a(b_in_3), .y(nb3));
    
adder_1bit bit00 (
    .a(a_in_0), 
    .b(nb0), 
    .carry_in(1'b1), //acarreo inicial es 1 (el bit que debo sumar para el c2)
    .add(sum00), 
    .carry_out(c00)
);

adder_1bit bit01 (
    .a(a_in_1), 
    .b(nb1), 
    .carry_in(c00),
    .add(sum01), 
    .carry_out(c01)
);

adder_1bit bit02 (
    .a(a_in_2), 
    .b(nb2), 
    .carry_in(c01),
    .add(sum02), 
    .carry_out(c02)
);

adder_1bit bit03 (
    .a(a_in_3), 
    .b(nb3), 
    .carry_in(c02),
    .add(sum03), 
    .carry_out(carry_flag_sub)
);

    
    
    //------------------------- PIB (111) -------------------------
    
    //---------------------------- MUX ----------------------------

    
    //--------------------------- FLAGS ---------------------------
    
    
endmodule
