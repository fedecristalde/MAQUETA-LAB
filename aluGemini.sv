module alu_4bit (
    input  logic [3:0] a,         // Operando A de 4 bits
    input  logic [3:0] b,         // Operando B de 4 bits
    input  logic [1:0] opcode,    // Selector de 2 bits (0 a 3)
    output logic [3:0] result,    // Resultado de 4 bits
    output logic       zero_flag, // Se activa si el resultado es 0
    output logic       carry_out  // Se activa si hay acarreo/prestamo
);

    // Usamos 5 bits internamente para no perder el acarreo de la suma/resta
    logic [4:0] res_ext;

    always_comb begin
        case (opcode)
            2'b00: res_ext = a + b;          // SUMA
            2'b01: res_ext = a - b;          // RESTA
            2'b10: res_ext = {1'b0, a & b};  // AND
            2'b11: res_ext = {1'b0, a | b};  // OR
            default: res_ext = 5'b0;
        endcase

        // Asignamos las salidas desde la variable extendida
        result    = res_ext[3:0]; 
        carry_out = res_ext[4];
        
        // El Zero Flag mira el resultado final de 4 bits
        zero_flag = (result == 4'b0000);
    end

endmodule
