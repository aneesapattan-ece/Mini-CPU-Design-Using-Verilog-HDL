module mini_cpu(
    input clk,
    input reset,
    output reg [7:0] result,
    output reg [2:0] opcode,
    output reg [7:0] regA,
    output reg [7:0] regB,
    output reg [2:0] pc
);

    reg [10:0] instruction_memory [0:7];
    reg [10:0] instruction;

    initial begin
        // opcode + 8-bit operand
        instruction_memory[0] = {3'b000, 8'd5};   // LOADA 5
        instruction_memory[1] = {3'b001, 8'd3};   // LOADB 3
        instruction_memory[2] = {3'b010, 8'd0};   // ADD
        instruction_memory[3] = {3'b011, 8'd0};   // SUB
        instruction_memory[4] = {3'b100, 8'd0};   // AND
        instruction_memory[5] = {3'b101, 8'd0};   // OR
        instruction_memory[6] = {3'b110, 8'd0};   // XOR
        instruction_memory[7] = {3'b111, 8'd0};   // NOP
    end

    always @(posedge clk or posedge reset)
    begin
        if(reset)
        begin
            pc <= 0;
            regA <= 0;
            regB <= 0;
            result <= 0;
            opcode <= 0;
        end
        else
        begin
            instruction = instruction_memory[pc];

            opcode <= instruction[10:8];

            case(instruction[10:8])

                3'b000: regA <= instruction[7:0];           // LOADA

                3'b001: regB <= instruction[7:0];           // LOADB

                3'b010: result <= regA + regB;              // ADD

                3'b011: result <= regA - regB;              // SUB

                3'b100: result <= regA & regB;              // AND

                3'b101: result <= regA | regB;              // OR

                3'b110: result <= regA ^ regB;              // XOR

                3'b111: result <= result;                   // NOP

            endcase

            pc <= pc + 1;
        end
    end

endmodule