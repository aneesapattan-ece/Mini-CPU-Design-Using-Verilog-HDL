module testbench;

    reg clk;
    reg reset;

    wire [7:0] result;
    wire [2:0] opcode;
    wire [7:0] regA;
    wire [7:0] regB;
    wire [2:0] pc;

    mini_cpu uut(
        .clk(clk),
        .reset(reset),
        .result(result),
        .opcode(opcode),
        .regA(regA),
        .regB(regB),
        .pc(pc)
    );

    always #5 clk = ~clk;

    initial
    begin
        $dumpfile("dump.vcd");
        $dumpvars(0,testbench);

        clk = 0;
        reset = 1;

        #10 reset = 0;

        // Execute all instructions
        #100;

        $finish;
    end

endmodule