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
