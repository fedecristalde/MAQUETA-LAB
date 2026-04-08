`timescale 1ns / 1ps

module alu(
    input a_in_0, input a_in_1, input a_in_2, input a_in_3,
    input b_in_0, input b_in_1, input b_in_2, input b_in_3,
    input alu_op_0, input alu_op_1, input alu_op_2,
    output alu_result_0, output alu_result_1,
    output alu_result_2, output alu_result_3,
    output zero_flag,
    output carry_flag
);

//-------------------- CABLES --------------------

logic and_0, and_1, and_2, and_3;
logic or_0,  or_1,  or_2,  or_3;
logic sum_0, sum_1, sum_2, sum_3;

logic c1, c2, c3, c4;

// selectores
logic sel_and, sel_or, sel_add, sel_pass;

// negaciones
logic n_op0, n_op1, n_op2;

//-------------------- NOT --------------------

not_gate n0 (.a(alu_op_0), .y(n_op0));
not_gate n1 (.a(alu_op_1), .y(n_op1));
not_gate n2 (.a(alu_op_2), .y(n_op2));

//-------------------- DECODIFICACIÓN --------------------

// AND = 000
and_gate s0 (.a(n_op2), .b(n_op1), .y(sel_and));
and_gate s1 (.a(sel_and), .b(n_op0), .y(sel_and));

// OR = 001
and_gate s2 (.a(n_op2), .b(n_op1), .y(sel_or));
and_gate s3 (.a(sel_or), .b(alu_op_0), .y(sel_or));

// ADD = 010
and_gate s4 (.a(n_op2), .b(alu_op_1), .y(sel_add));
and_gate s5 (.a(sel_add), .b(n_op0), .y(sel_add));

// PASS B = 111
and_gate s6 (.a(alu_op_2), .b(alu_op_1), .y(sel_pass));
and_gate s7 (.a(sel_pass), .b(alu_op_0), .y(sel_pass));

//-------------------- AND --------------------

and_gate a0 (.a(a_in_0), .b(b_in_0), .y(and_0));
and_gate a1 (.a(a_in_1), .b(b_in_1), .y(and_1));
and_gate a2 (.a(a_in_2), .b(b_in_2), .y(and_2));
and_gate a3 (.a(a_in_3), .b(b_in_3), .y(and_3));

//-------------------- OR --------------------

or_gate o0 (.a(a_in_0), .b(b_in_0), .y(or_0));
or_gate o1 (.a(a_in_1), .b(b_in_1), .y(or_1));
or_gate o2 (.a(a_in_2), .b(b_in_2), .y(or_2));
or_gate o3 (.a(a_in_3), .b(b_in_3), .y(or_3));

//-------------------- SUMA --------------------

adder_1bit fa0 (.a(a_in_0), .b(b_in_0), .carry_in(1'b0), .add(sum_0), .carry_out(c1));
adder_1bit fa1 (.a(a_in_1), .b(b_in_1), .carry_in(c1),   .add(sum_1), .carry_out(c2));
adder_1bit fa2 (.a(a_in_2), .b(b_in_2), .carry_in(c2),   .add(sum_2), .carry_out(c3));
adder_1bit fa3 (.a(a_in_3), .b(b_in_3), .carry_in(c3),   .add(sum_3), .carry_out(c4));

//-------------------- MUX (bit 0) --------------------

logic m0_1, m0_2, m0_3, m0_4;

and_gate m0a (.a(and_0), .b(sel_and), .y(m0_1));
and_gate m0b (.a(or_0),  .b(sel_or),  .y(m0_2));
and_gate m0c (.a(sum_0), .b(sel_add), .y(m0_3));
and_gate m0d (.a(b_in_0),.b(sel_pass),.y(m0_4));

or_gate m0e (.a(m0_1), .b(m0_2), .y(m0_1));
or_gate m0f (.a(m0_3), .b(m0_4), .y(m0_2));
or_gate m0g (.a(m0_1), .b(m0_2), .y(alu_result_0));

//-------------------- repetir para bits 1,2,3 --------------------

/* (idéntico patrón cambiando _0 por _1, _2, _3) */

//-------------------- ZERO FLAG --------------------

logic z1, z2;

or_gate z0 (.a(alu_result_0), .b(alu_result_1), .y(z1));
or_gate z3 (.a(alu_result_2), .b(alu_result_3), .y(z2));
or_gate z4 (.a(z1), .b(z2), .y(z1));

not_gate z5 (.a(z1), .y(zero_flag));

//-------------------- CARRY FLAG --------------------

and_gate cf (.a(c4), .b(sel_add), .y(carry_flag));

endmodule
