module alu_control(
  input       [2:0] alu_op,
  input       [3:0] func,
  output reg  [3:0] alu_operation
);
  localparam      R_TYPE       = 3'b 000;
  localparam      I_TYPE_L     = 3'b 100;
  localparam      I_TYPE_A     = 3'b 001;
  localparam      S_TYPE       = 3'b 010;
  localparam      SB_TYPE      = 3'b 011;
  always @(*) begin
    case(alu_op)
      R_TYPE: begin
        case(func)
          4'b 0000: begin // add    ADD     rd ? rs1 + rs2, pc ? pc+4
            alu_operation = 4'b 0000;
          end
          4'b 1000: begin // sub    SUB     rd ? rs1 - rs2, pc ? pc+4
            alu_operation = 4'b 0001;
          end
          4'b 0001: begin // sll    Shift Left Logical  rd ? rs1 << (rs2%XLEN), pc ? pc+4
            alu_operation = 4'b 0101;
          end
          4'b 0010: begin // slt   Set Less Than If the signed integer value in rs1 is less than the signed integer value in rs2 then set rd to 1.
            alu_operation = 4'b 0110;
          end
          4'b 0011: begin // sltu Set Less Than Unsigned    rd ? (rs1 < rs2) ? 1 : 0, pc ? pc+4
            alu_operation = 4'b 0111;
          end
          4'b 0100: begin // xor        rd ? rs1 ^ rs2, pc ? pc+4
            alu_operation = 4'b 0100;
          end
          4'b 0101: begin // srl    Shift Right Logical     rd ? rs1 >> (rs2%XLEN), pc ? pc+4
            alu_operation = 4'b 1000;
          end
          4'b 1101: begin // sra    Shift Right Arithmetic  rd ? rs1 >> (rs2%XLEN), pc ? pc+4
            alu_operation = 4'b 1001;
          end
          4'b 0110: begin // or
            alu_operation = 4'b 0011;
          end
          4'b 0111: begin  // and
            alu_operation = 4'b 0010;
          end
        endcase
      end
      I_TYPE_L: begin
        case(func[2:0])
          3'b 000: begin // lb Load Byte    rd ? sx(m8(rs1+imm i)), pc ? pc+4
            alu_operation = 4'b 0000;
          end
          3'b 001: begin // lh Load Halfword rd ? sx(m16(rs1+imm i)), pc ? pc+4
            alu_operation = 4'b 0000;
          end
          3'b 010: begin // lw Load Word  rd ? sx(m32(rs1+imm i)), pc ? pc+4
            alu_operation = 4'b 0000;
          end
          3'b 100: begin // lbu Load Byte Unsigned  rd ? zx(m8(rs1+imm i)), pc ? pc+4
            alu_operation = 4'b 0000;
          end
          3'b 101: begin // lhu Load Halfword Unsigned  rd ? zx(m16(rs1+imm i)), pc ? pc+4
            alu_operation = 4'b 0000;
          end
        endcase
      end

      I_TYPE_A: begin
        case(func[2:0])
          3'b 000: begin // addi    rd ? rs1 + imm i, pc ? pc+4
            alu_operation = 4'b 0000;
          end
          3'b 010: begin // slti    Set Less Than Immediate  rd ? (rs1 < imm i) ? 1 : 0, pc ? pc+4
            alu_operation = 4'b 0110;
          end
          3'b 011: begin // sltiu   Set Less Than Immediate Unsigned rd ? (rs1 < imm i) ? 1 : 0, pc ? pc+4
            alu_operation = 4'b 0111;
          end
          3'b 100: begin // xori                        rd ? rs1 ^ imm i, pc ? pc+4
            alu_operation = 4'b 0100;
          end
          3'b 110: begin // ori                         rd ? rs1 | imm i, pc ? pc+4
            alu_operation = 4'b 0011;
          end
          3'b 111: begin // andi                        rd ? rs1 & imm i, pc ? pc+4
            alu_operation = 4'b 0010;
          end
          3'b 001: begin // slli                        rd ? rs1 << shamt i, pc ? pc+4
            alu_operation = 4'b 0101;
          end
          3'b 101: begin
            if(func[3]) begin // srai  Shift Right Arithmetic Imm  rd ? rs1 >> shamt i, pc ? pc+4
              alu_operation = 4'b 1001;
            end
            else begin        // srli   Shift Right Logical Imm     rd ? rs1 >> shamt i, pc ? pc+4
              alu_operation = 4'b 1000;
            end
          end
        endcase
      end

      S_TYPE: begin
        case(func[2:0])
          3'b 000: begin // sb      Store Byte  m8(rs1+imm s) ? rs2[7:0], pc ? pc+4
            alu_operation = 4'b 0000;
          end
          3'b 001: begin // sh      Store Halfword  m16(rs1+imm s) ? rs2[15:0], pc ? pc+4
            alu_operation = 4'b 0000;
          end
          3'b 010: begin // sw      Store Word      m32(rs1+imm s) ? rs2[31:0], pc ? pc+4
            alu_operation = 4'b 0000;
          end
        endcase
      end

      SB_TYPE: begin
        case(func[2:0])
          3'b 000: begin // beq     Branch Equal    pc ? pc + ((rs1==rs2) ? imm b : 4)
            alu_operation = 4'b 0001;
          end
          3'b 001: begin // bne     Branch Not Equal    pc ? pc + ((rs1!=rs2) ? imm b : 4)
            alu_operation = 4'b 0001;
          end
          3'b 100: begin // blt     Branch Less Than    pc ? pc + ((rs1<rs2) ? imm b : 4)
            alu_operation = 4'b 0001;
          end
          3'b 101: begin // bge     Branch Greater or Equal pc ? pc + ((rs1>=rs2) ? imm b : 4)
            alu_operation = 4'b 0001;
          end
          3'b 110: begin // bltu    Branch Less Than Unsigned   pc ? pc + ((rs1<rs2) ? imm b : 4)
            alu_operation = 4'b 0001;
          end
          3'b 111: begin // bgeu    Branch Greater or Equal Unsigned    pc ? pc + ((rs1>=rs2) ? imm b : 4)
            alu_operation = 4'b 0001;
          end
        endcase
      end
    endcase
  end
endmodule