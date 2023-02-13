module alu(
  input           [3:0]     alu_opr,
  input           [31:0]    operand1,
  input           [31:0]    operand2,
  output   reg    [31:0]    result,
  output   wire   [31:0]    flag
);

  localparam      ADD     = 4'b 0000;
  localparam      SUB     = 4'b 0001;
  localparam      AND     = 4'b 0010;
  localparam      OR      = 4'b 0011;
  localparam      XOR     = 4'b 0100;
  localparam      SLL     = 4'b 0101;
  localparam      SLT     = 4'b 0110;
  localparam      SLTU    = 4'b 0111;
  localparam      SRL     = 4'b 1000;
  localparam      SRA     = 4'b 1001;
  localparam      ADD_S   = 4'b 1010;
  localparam      SUB_S   = 4'b 1011;


  always @(*) begin
    case(alu_opr)
      ADD: begin
        result = operand1 + operand2;
      end
      SUB: begin
        result = operand1 - operand2;
      end
      AND: begin
        result = operand1 & operand2; 
      end
      OR: begin
        result = operand1 | operand2; 
      end
      XOR: begin
        result = operand1 ^ operand2; 
      end
      SLL: begin
        result = operand1 << operand2[4:0]; 
      end
      SLT: begin
        if((operand1[31] == 1'b 0 && operand2[31]== 1'b 1) || (operand1[31] == operand2[31] && operand1 < operand2))begin
          result = 32'd 1; 
        end
        else begin
          result = 32'd 0; 
        end        
      end
      SLTU: begin
        if (operand1 < operand2) begin
          result = 32'd 1; 
        end
        else begin
          result = 32'd 0; 
        end    
      end
      SRL: begin
        result = operand1 >> operand2[4:0]; 
      end
      SRA: begin
        result = {operand1[31], (operand1[30:0] >> operand2[4:0])}; 
      end
      default: begin
        result = operand1;
      end
    endcase
  end

assign flag = {result==32'b 0, result[31], result[31]^result[30:0] == 31'b 0, 1'b 1};  // zero, negative, overload, valid
endmodule
