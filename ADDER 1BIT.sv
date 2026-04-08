`timescale 1ns / 1ps

module adder_1bit(
    input a,
    input b,
    input carry_in,
    output add,
    output carry_out,
     );

    wire s1;
    wire c1,c2;

    XOR(s1, a,b);
    and(c1,a,b);
    
    XOR(add,s1,carry_in);
    and(c2,s1,carry_in);

    or(carry_out,c1,c2);
    
   
    
         
endmodule
