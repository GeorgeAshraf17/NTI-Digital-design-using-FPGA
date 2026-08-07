module controller (
    input clk,
    input rst,
    input zero,
    input [2:0] opcode,
    input [2:0] phase,
    output reg sel,
    output reg rd,
    output reg ld_ir,
    output reg halt,
    output reg inc_pc,
    output reg ld_ac,
    output reg ld_pc,
    output reg wr,
    output reg data_e
);

    localparam HLT   = 3'b000,
               SKZ   = 3'b001,
               ADDOP = 3'b010,
               ANDOP = 3'b011,
               XOROP = 3'b100,
               LDA   = 3'b101,
               STO   = 3'b110,
               JMP   = 3'b111;

    localparam INST_ADDR  = 3'd0,
               INST_FETCH = 3'd1,
               INST_LOAD  = 3'd2,
               IDLE       = 3'd3,
               OP_ADDR    = 3'd4,
               OP_FETCH   = 3'd5,
               ALU_OP     = 3'd6,
               STORE      = 3'd7;

    reg aluop, haltop, skz_zero, jmpop, stoop;

    always @(*) begin
        aluop    = (opcode == ADDOP) || (opcode == ANDOP) || (opcode == XOROP) || (opcode == LDA);
        haltop   = (opcode == HLT);
        skz_zero = (opcode == SKZ) && zero;
        jmpop    = (opcode == JMP);
        stoop    = (opcode == STO);
    end

    always @(posedge clk) 
	begin
        if (rst) 
		begin
            sel <= 0; rd <= 0; ld_ir <= 0; halt <= 0; inc_pc <= 0;
            ld_ac <= 0; ld_pc <= 0; wr <= 0; data_e <= 0;
        end 
		else 
		begin
            sel <= 0; rd <= 0; ld_ir <= 0; halt <= 0; inc_pc <= 0;
            ld_ac <= 0; ld_pc <= 0; wr <= 0; data_e <= 0;

            case (phase)
                INST_ADDR: begin
                    sel <= 1;
                end
                INST_FETCH: begin
                    sel <= 1;
                    rd  <= 1;
                end
                INST_LOAD: begin
                    sel   <= 1;
                    rd    <= 1;
                    ld_ir <= 1;
                end
                IDLE: begin
                    sel   <= 1;
                    rd    <= 1;
                    ld_ir <= 1;
                end
                OP_ADDR: begin
                    halt   <= haltop;
                    inc_pc <= 1;
                end
                OP_FETCH: begin
                    rd <= aluop;
                end
                ALU_OP: begin
                    rd     <= aluop;
                    inc_pc <= skz_zero;
                    ld_ac  <= aluop;
                    ld_pc  <= jmpop;
                    data_e <= stoop;
                end
                STORE: begin
                    rd     <= aluop;
                    ld_pc  <= jmpop;
                    wr     <= stoop;
                    data_e <= stoop;
                end
            endcase
        end
    end

endmodule