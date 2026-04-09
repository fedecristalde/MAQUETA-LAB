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

module adder_1bit_0(
    input a_in_0,
    input b_in_0,
    input carry_in_0,
    output s1,
    output carry_out_0
    );

    wire s0;
    wire c0,c1;

    xor(s0, a_in_0,b_in_0);
    and(c0,a_in_0,b_in_0);

    assign carry_in_0 = 0;
    
    xor(s1,s0,carry_in_0);
    and(c1,s0,carry_in_0);

    or(carry_out_0,c0,c1);
    
   
    
         
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
