module program_counter(
  input                    clk,
  input                    reset,
  input           [31:0]   pc,
  input                    branch,
  input           [31:0]   branch_target,
  
  output    reg  [31:0]    next_pc 
);
//reg pc =32'b 1;

    always@(posedge clk ) begin
        if(reset) begin
            next_pc =0;
        end 
        else begin
        if(branch==1'b 1) next_pc=pc+branch_target;
        else next_pc=pc+1;
        
            //t_pc = branch ? (pc+branch_target): pc + 1 ;
        end
    end 
endmodule