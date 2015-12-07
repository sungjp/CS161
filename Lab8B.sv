//Grant Park and Hunter Voegele
module Lab8B(clock, pcQ, instruction, pcD);

// The clock will be driven from the testbench
//  The instruction, pcQ and pcD are sent to the testBecnh to
// make debugging easier


input logic clock;
output logic [31:0] instruction;
output logic [31:0] pcQ;
output logic [31:0] pcD;

// The PC is just a register
// Its ports are above

register PC(pcD,pcQ,clock);

// set up a hard-wired connectin to a value

logic [31:0] const1;

initial
	const1 <= 32'b100;

   // construct the adder for the PC incrementing circuit.

   logic [31:0] addIn1, addIn2, addOut;

      adder psAdd(addIn1,addIn2,addOut);

   // Connect the adder to the right inputs and output
   //  notice that using pcD and pcQ here and above in the PC register is like
   // connecting a wire

   assign addIn1 = pcQ;
   assign addIn2 = const1;
   assign pcD = addOut;


   // construct the instuctionmemory
   // wired to PC and intstruction

   logic [31:0] instAddr;

   instructionMemory imem(instAddr,instruction);

   // Wire instruction memory

   assign instAddr = pcQ;


   // construct the register file with (currently mostly) unused values to connect to it

   logic [4:0] 	writeChoose, readChoose;
   logic 	writeEnable;
   logic [31:0] writeData, read;


	logic [5:0] theOp;
	logic    theMem, theReg;

	controlUnit theCU(theOp,theMem,theReg);


   registerFile theRegisters(readChoose,
		writeChoose, clock, writeEnable, writeData, read);

   // example - attach the readChoose port to 5 bits of the instruction

   assign readChoose = instruction[25:21];
	assign writeChoose = instruction[20:16];
	// assign writeEnable = '1;

	logic     enableWrite;

	assign theOp = instruction[31:26];
	assign writeEnable = theMem; //this is the writeEnable in the registerfile
	assign enableWrite = theReg; //this is the writeEnable in data memory

   logic [31:0] extended;

   assign extended = {16'b0 , instruction[15:0]};

   logic [31:0] aluIn1, aluIn2, aluOut;
   logic [4:0] 	aluSelect;


   ALU theALU(aluIn1, aluIn2, 5'b0,aluOut);

	assign aluIn1 = read;
	assign aluIn2 = extended;


   logic [31:0] dataRead, dataAddr, dataWrite;
	//logic enableWrite;

   dataMemory2 data(dataAddr,dataRead,dataWrite,clock,enableWrite);

	assign dataAddr = aluOut;
	assign dataWrite = 32'b0;
	//assign enableWrite = '0;
	assign writeData = dataRead;




endmodule
