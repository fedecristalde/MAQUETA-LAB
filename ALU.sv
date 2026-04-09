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
     logic co0, co1, co2, co3;
    
    or_gate o0 (.a(a_in_0), .b(b_in_0), .y(co0));
    or_gate o1 (.a(a_in_1), .b(b_in_1), .y(co1));
    or_gate o2 (.a(a_in_2), .b(b_in_2), .y(co2));
    or_gate o3 (.a(a_in_3), .b(b_in_3), .y(co3));
        
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
    // Logramos resolver este apartado desde el multiplexor con una asignacion directa.
    //---------------------------- MUX ----------------------------
    
    mux8_1 alu_mux_0 (
        .d0(ca0),    // Resultado AND bit 0
        .d1(co0),     // Resultado OR bit 0
        .d2(sum0),        // Resultado Suma bit 0
        .d3(1'b0),        // Reservado
        .d4(1'b0),        // Reservado
        .d5(1'b0),        // Reservado
        .d6(sum00),       // Resultado Resta bit 0
        .d7(b_in_0),      // Pass Input B bit 0 // AGREGAR ACLARACION DE PIB
        .sel_0(alu_op_0), 
        .sel_1(alu_op_1), 
        .sel_2(alu_op_2),
        .y(alu_result_0) 
    );

    mux8_1 alu_mux_1 (
        .d0(ca1),    // Resultado AND bit 0
        .d1(co1),     // Resultado OR bit 0
        .d2(sum1),        // Resultado Suma bit 0
        .d3(1'b0),        // Reservado
        .d4(1'b0),        // Reservado
        .d5(1'b0),        // Reservado
        .d6(sum01),       // Resultado Resta bit 0
        .d7(b_in_1),      // Pass Input B bit 0 // AGREGAR ACLARACION DE PIB
        .sel_0(alu_op_0), 
        .sel_1(alu_op_1), 
        .sel_2(alu_op_2),
        .y(alu_result_1)
    );
    

    mux8_1 alu_mux_2 (
        .d0(ca2),    // Resultado AND bit 0
        .d1(co2),     // Resultado OR bit 0
        .d2(sum2),        // Resultado Suma bit 0
        .d3(1'b0),        // Reservado
        .d4(1'b0),        // Reservado
        .d5(1'b0),        // Reservado
        .d6(sum02),       // Resultado Resta bit 0
        .d7(b_in_2),      // Pass Input B bit 0 // AGREGAR ACLARACION DE PIB
        .sel_0(alu_op_0), 
        .sel_1(alu_op_1), 
        .sel_2(alu_op_2),
        .y(alu_result_2) 
    );
    
    mux8_1 alu_mux_3 (
        .d0(ca3),    // Resultado AND bit 0
        .d1(co3),     // Resultado OR bit 0
        .d2(sum3),        // Resultado Suma bit 0
        .d3(1'b0),        // Reservado
        .d4(1'b0),        // Reservado
        .d5(1'b0),        // Reservado
        .d6(sum03),       // Resultado Resta bit 0
        .d7(b_in_3),      // Pass Input B bit 0 // AGREGAR ACLARACION DE PIB
        .sel_0(alu_op_0), 
        .sel_1(alu_op_1), 
        .sel_2(alu_op_2),
        .y(alu_result_3) 
    );

     mux8_1 alu_mux_4 (
        .d0(1'b0), 
        .d1(1'b0),    
        .d2(carry_flag_add),    
        .d3(1'b0),      
        .d4(1'b0),       
        .d5(1'b0),        
        .d6(carry_flag_sub),       
        .d7(1'b0),      
        .sel_0(alu_op_0), 
        .sel_1(alu_op_1), 
        .sel_2(alu_op_2),
        .y(carry_flag) 
    );
    
    //--------------------------- FLAGS ---------------------------
    or_gate cerogate0 (.a(alu_result_0), .b(alu_result_1), .y(cero0));
    or_gate cerogate1 (.a(alu_result_2), .b(alu_result_3), .y(cero1));
    or_gate cerogate2 (.a(cero0), .b(cero1), .y(cero3));

    not_gate negacion (.a(cero3), .y(zero_flag)); 
    
  

    
    
    
    
endmodule
