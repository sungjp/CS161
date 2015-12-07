// this will need more ports later

module dataMemory2(input logic [31:0] addr, 
		output logic [31:0] read,
		  input logic [31:0] writeData,
		  input logic clk, writeEnable);

// allocate 64 word-sized memory locations
   
logic [31:0] theStuff [6:0];

// inittialize some of the dataMemory
initial 
begin
theStuff[0] = 7;
theStuff[1] = 8;
theStuff[2] = 9;
theStuff[3] = 10;
theStuff[4] = 12;
end

assign read = theStuff[addr[6:2]];

// to do writing, you need an always 

always @(posedge clk)
  if (writeEnable)
    theStuff[addr[31:2]] <= writeData;
   
endmodule