module branch_sel(
  input                   branch,
  input           [3:0]   flag,
  input           [3:0]   func,
  output    reg           en_branch
);

  always @(*) begin
    case(func[2:0])
      3'b000: begin // beq
        if(flag[3]) begin
          en_branch = 1'b1;
        end
        else begin
          en_branch = 1'b0;
        end
      end

      3'b001: begin // bne
        if(~flag[3]) begin
          en_branch = 1'b1;
        end
        else begin
          en_branch = 1'b0;
        end
      end

      3'b100: begin // blt
        if(flag[2]) begin
          en_branch = 1'b1;
        end
        else begin
          en_branch = 1'b0;
        end
      end

      3'b101: begin // bge
        if(flag[3] || ~flag[2]) begin
          en_branch = 1'b1;
        end
        else begin
          en_branch = 1'b0;
        end
      end

      3'b110: begin // bltu
        if(flag[2]) begin
          en_branch = 1'b1;
        end
        else begin
          en_branch = 1'b0;
        end
      end

      3'b111: begin // bgeu
        if(flag[3] || ~flag[2]) begin
          en_branch = 1'b1;
        end
        else begin
          en_branch = 1'b0;
        end
      end
    endcase
  end
endmodule 