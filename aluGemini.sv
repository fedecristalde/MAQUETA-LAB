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

    // ============================================================
    // 1. PREPARACIÓN DE B PARA RESTA (Complemento a 2)
    // ============================================================
    // Si alu_op_2 es 1, invertimos B (NOT) y luego sumamos 1 con cin
    wire b_p0, b_p1, b_p2, b_p3;
    wire cin_inicial;

    assign b_p0 = alu_op_2 ? ~b_in_0 : b_in_0;
    assign b_p1 = alu_op_2 ? ~b_in_1 : b_in_1;
    assign b_p2 = alu_op_2 ? ~b_in_2 : b_in_2;
    assign b_p3 = alu_op_2 ? ~b_in_3 : b_in_3;
    
    assign cin_inicial = alu_op_2; 

    // ============================================================
    // 2. SUMADOR / RESTADOR ESTRUCTURAL (Usando adder_1bit)
    // ============================================================
    wire s0, s1, s2, s3;
    wire c1, c2, c3, c4;

    // Encadenamiento de acarreos (Ripple Carry)
    adder_1bit FA0 (.a(a_in_0), .b(b_p0), .carry_in(cin_inicial), .add(s0), .carry_out(c1));
    adder_1bit FA1 (.a(a_in_1), .b(b_p1), .carry_in(c1),          .add(s1), .carry_out(c2));
    adder_1bit FA2 (.a(a_in_2), .b(b_p2), .carry_in(c2),          .add(s2), .carry_out(c3));
    adder_1bit FA3 (.a(a_in_3), .b(b_p3), .carry_in(c3),          .add(s3), .carry_out(c4));

    // ============================================================
    // 3. OPERACIONES LÓGICAS (AND y OR bit a bit)
    // ============================================================
    wire and0, and1, and2, and3;
    wire or0, or1, or2, or3;

    assign and0 = a_in_0 & b_in_0;
    assign and1 = a_in_1 & b_in_1;
    assign and2 = a_in_2 & b_in_2;
    assign and3 = a_in_3 & b_in_3;

    assign or0  = a_in_0 | b_in_0;
    assign or1  = a_in_1 | b_in_1;
    assign or2  = a_in_2 | b_in_2;
    assign or3  = a_in_3 | b_in_3;

    // ============================================================
    // 4. MUX (Selección de operación final)
    // ============================================================
    reg r0, r1, r2, r3, cf;

    always_comb begin
        // AND: 000
        if (alu_op_2 == 0 && alu_op_1 == 0 && alu_op_0 == 0) begin
            r0 = and0; r1 = and1; r2 = and2; r3 = and3; cf = 0;
        end 
        // OR: 001
        else if (alu_op_2 == 0 && alu_op_1 == 0 && alu_op_0 == 1) begin
            r0 = or0;  r1 = or1;  r2 = or2;  r3 = or3;  cf = 0;
        end 
        // SUMA: 010
        else if (alu_op_2 == 0 && alu_op_1 == 1 && alu_op_0 == 0) begin
            r0 = s0;   r1 = s1;   r2 = s2;   r3 = s3;   cf = c4;
        end 
        // RESTA: 110
        else if (alu_op_2 == 1 && alu_op_1 == 1 && alu_op_0 == 0) begin
            r0 = s0;   r1 = s1;   r2 = s2;   r3 = s3;   cf = c4;
        end 
        // PIB (Pass In B): 111
        else if (alu_op_2 == 1 && alu_op_1 == 1 && alu_op_0 == 1) begin
            r0 = b_in_0; r1 = b_in_1; r2 = b_in_2; r3 = b_in_3; cf = 0;
        end 
        // Default
        else begin
            r0 = 0; r1 = 0; r2 = 0; r3 = 0; cf = 0;
        end
    end

    // ============================================================
    // 5. SALIDAS Y FLAGS
    // ============================================================
    assign alu_result_0 = r0;
    assign alu_result_1 = r1;
    assign alu_result_2 = r2;
    assign alu_result_3 = r3;
    
    assign carry_flag   = cf;

    // Zero Flag: Si todos los bits del resultado son 0, la bandera es 1
    assign zero_flag = ~(r0 | r1 | r2 | r3);
    
endmodule
