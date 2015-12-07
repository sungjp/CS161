module instructionMemory(input logic [31:0] addr, 
		output logic [31:0] read);

logic [31:0] instructs [6:0];


initial 
begin
   instructs[0] = 32'b100011_00001_00000_0000000000000000; 
   instructs[1] = 32'b100011_00000_00001_0000000000001100;
   instructs[2] = 32'b100011_00001_00001_0000000000000100;
   instructs[3] = 32'b100011_00000_00000_0000000000001000;
end

assign read = instructs[addr[6:2]];




endmodule


