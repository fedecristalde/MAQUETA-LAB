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
    logic and_0, and_1, and_2, and_3;

    and_gate and0 (.a(a_in_0), .b(b_in_0), .y(and_0));
    and_gate and1 (.a(a_in_1), .b(b_in_1), .y(and_1));
    and_gate and2 (.a(a_in_2), .b(b_in_2), .y(and_2));
    and_gate and3 (.a(a_in_3), .b(b_in_3), .y(and_3));

    //------------------------- OR  (001) -------------------------
    logic or_0, or_1, or_2, or_3;

    or_gate or0 (.a(a_in_0), .b(b_in_0), .y(or_0));
    or_gate or1 (.a(a_in_1), .b(b_in_1), .y(or_1));
    or_gate or2 (.a(a_in_2), .b(b_in_2), .y(or_2));
    or_gate or3 (.a(a_in_3), .b(b_in_3), .y(or_3));

    //------------------------- ADD (010) -------------------------
    logic sum_0, sum_1, sum_2, sum_3;
    logic c1, c2, c3, c4;

    adder_1bit fa0 (.a(a_in_0), .b(b_in_0), .carry_in(1'b0), .add(sum_0), .carry_out(c1));
    adder_1bit fa1 (.a(a_in_1), .b(b_in_1), .carry_in(c1),   .add(sum_1), .carry_out(c2));
    adder_1bit fa2 (.a(a_in_2), .b(b_in_2), .carry_in(c2),   .add(sum_2), .carry_out(c3));
    adder_1bit fa3 (.a(a_in_3), .b(b_in_3), .carry_in(c3),   .add(sum_3), .carry_out(c4));

    //------------------------- SUB (110) -------------------------
    // No implementado → todo 0
    logic sub_0, sub_1, sub_2, sub_3;

    assign sub_0 = 1'b0;
    assign sub_1 = 1'b0;
    assign sub_2 = 1'b0;
    assign sub_3 = 1'b0;

    //------------------------- PIB (111) -------------------------
    // Pass input B
    logic pib_0, pib_1, pib_2, pib_3;

    assign pib_0 = b_in_0;
    assign pib_1 = b_in_1;
    assign pib_2 = b_in_2;
    assign pib_3 = b_in_3;

    //---------------------------- MUX ----------------------------

    logic not_op0, not_op1, not_op2;

    not_gate n0 (.a(alu_op_0), .y(not_op0));
    not_gate n1 (.a(alu_op_1), .y(not_op1));
    not_gate n2 (.a(alu_op_2), .y(not_op2));

    logic sel_and, sel_or, sel_add, sel_pib;

    // 000
    logic t_and;
    and_gate d1 (.a(not_op2), .b(not_op1), .y(t_and));
    and_gate d2 (.a(t_and), .b(not_op0), .y(sel_and));

    // 001
    logic t_or;
    and_gate d3 (.a(not_op2), .b(not_op1), .y(t_or));
    and_gate d4 (.a(t_or), .b(alu_op_0), .y(sel_or));

    // 010
    logic t_add;
    and_gate d5 (.a(not_op2), .b(alu_op_1), .y(t_add));
    and_gate d6 (.a(t_add), .b(not_op0), .y(sel_add));

    // 111
    logic t_pib;
    and_gate d7 (.a(alu_op_2), .b(alu_op_1), .y(t_pib));
    and_gate d8 (.a(t_pib), .b(alu_op_0), .y(sel_pib));

    // -------- bit 0 --------
    logic r0a, r0b, r0c, r0d, r0ab, r0cd;

    and_gate m0 (.a(and_0), .b(sel_and), .y(r0a));
    and_gate m1 (.a(or_0),  .b(sel_or),  .y(r0b));
    and_gate m2 (.a(sum_0), .b(sel_add), .y(r0c));
    and_gate m3 (.a(pib_0), .b(sel_pib), .y(r0d));

    or_gate m4 (.a(r0a), .b(r0b), .y(r0ab));
    or_gate m5 (.a(r0c), .b(r0d), .y(r0cd));
    or_gate m6 (.a(r0ab), .b(r0cd), .y(alu_result_0));

    // -------- bit 1 --------
    logic r1a, r1b, r1c, r1d, r1ab, r1cd;

    and_gate m7 (.a(and_1), .b(sel_and), .y(r1a));
    and_gate m8 (.a(or_1),  .b(sel_or),  .y(r1b));
    and_gate m9 (.a(sum_1), .b(sel_add), .y(r1c));
    and_gate m10(.a(pib_1), .b(sel_pib), .y(r1d));

    or_gate m11(.a(r1a), .b(r1b), .y(r1ab));
    or_gate m12(.a(r1c), .b(r1d), .y(r1cd));
    or_gate m13(.a(r1ab), .b(r1cd), .y(alu_result_1));

    // -------- bit 2 --------
    logic r2a, r2b, r2c, r2d, r2ab, r2cd;

    and_gate m14(.a(and_2), .b(sel_and), .y(r2a));
    and_gate m15(.a(or_2),  .b(sel_or),  .y(r2b));
    and_gate m16(.a(sum_2), .b(sel_add), .y(r2c));
    and_gate m17(.a(pib_2), .b(sel_pib), .y(r2d));

    or_gate m18(.a(r2a), .b(r2b), .y(r2ab));
    or_gate m19(.a(r2c), .b(r2d), .y(r2cd));
    or_gate m20(.a(r2ab), .b(r2cd), .y(alu_result_2));

    // -------- bit 3 --------
    logic r3a, r3b, r3c, r3d, r3ab, r3cd;

    and_gate m21(.a(and_3), .b(sel_and), .y(r3a));
    and_gate m22(.a(or_3),  .b(sel_or),  .y(r3b));
    and_gate m23(.a(sum_3), .b(sel_add), .y(r3c));
    and_gate m24(.a(pib_3), .b(sel_pib), .y(r3d));

    or_gate m25(.a(r3a), .b(r3b), .y(r3ab));
    or_gate m26(.a(r3c), .b(r3d), .y(r3cd));
    or_gate m27(.a(r3ab), .b(r3cd), .y(alu_result_3));

    //--------------------------- FLAGS ---------------------------

    // carry solo en suma
    and_gate cf (.a(c4), .b(sel_add), .y(carry_flag));

    // zero flag
    logic or01, or23, or_all;

    or_gate z1 (.a(alu_result_0), .b(alu_result_1), .y(or01));
    or_gate z2 (.a(alu_result_2), .b(alu_result_3), .y(or23));
    or_gate z3 (.a(or01), .b(or23), .y(or_all));

    not_gate z4 (.a(or_all), .y(zero_flag));

endmodule
