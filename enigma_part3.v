//==================================================================================================
//  Note:          Use only for teaching materials of IC Design Lab, NTHU.
//  Copyright: (c) 2022 Vision Circuits and Systems Lab, NTHU, Taiwan. ALL Rights Reserved.
//==================================================================================================


module enigma_part3(clk, srst_n, load, encrypt, crypt_mode, table_idx, code_in, code_out, code_valid);
input clk;         // clock 
input srst_n;      // synchronous reset (active low)
input load;        // load control signal (level sensitive). 0/1: inactive/active
input encrypt;     // encrypt control signal (level sensitive). 0/1: inactive/active
input crypt_mode;  // 0: encrypt; 1:decrypt;
input [2-1:0] table_idx; // table_idx indicates which rotor to be loaded 
						             // 2'b00: rotorA
						             // 2'b01: rotorB
						             // 2'b10: plugboard
input [6-1:0] code_in;	// When load is active, then code_in is input of rotors. 
							          // When encrypy is active, then code_in is input of code words.
							          // Note: We only use rotorA in part1.
output reg [6-1:0] code_out;   // encrypted code word (register output)
output reg code_valid;         // 0: non-valid code_out; 1: valid code_out (register output)

wire [5:0] rotorA_forward_out;
wire [5:0] rotorA_backward_out;
wire [5:0] rotorB_forward_out;
wire [5:0] rotorB_backward_out;
wire [5:0] plugboard_forward_out;
wire [5:0] plugboard_backward_out;
wire [5:0] reflector_out;
wire [1:0] rotorA_shift_amount;
wire [1:0] rotorB_shift_mode;

reg load_reg;
reg encrypt_reg;
reg [1:0] table_idx_reg;
reg [5:0] code_in_reg;
reg crypt_mode_reg;

reg [5:0] code_out_reg;
reg code_valid_reg;

rotorA rotorA_U0
(
	.clk(clk),
	.srst_n(srst_n),
	.load(load_reg),
	.encrypt(encrypt_reg),
	.table_idx(table_idx_reg),
	.code_in(code_in_reg),
	.rotorB_backward_out(rotorB_backward_out),
	.rotorA_shift_amount(rotorA_shift_amount),
	.rotorA_forward_out(rotorA_forward_out),
	.rotorA_backward_out(rotorA_backward_out)
);

rotorB rotorB_U1
(
	.clk(clk),
	.srst_n(srst_n),
	.load(load_reg),
	.encrypt(encrypt_reg),
	.crypt_mode(crypt_mode_reg),
	.table_idx(table_idx_reg),
	.code_in(code_in_reg),
	.rotorA_forward_out(rotorA_forward_out),
	.plugboard_backward_out(plugboard_backward_out),
	.rotorB_shift_mode(rotorB_shift_mode),
	.rotorB_forward_out(rotorB_forward_out),
	.rotorB_backward_out(rotorB_backward_out),
	.rotorA_shift_amount(rotorA_shift_amount)
);

plugboard plugboard_U2
(
	.clk(clk),
	.srst_n(srst_n),
	.load(load_reg),
	.encrypt(encrypt_reg),
	.crypt_mode(crypt_mode_reg),
	.table_idx(table_idx_reg),
	.code_in(code_in_reg),
	.rotorB_forward_out(rotorB_forward_out),
	.reflector_out(reflector_out),
	.rotorB_shift_mode(rotorB_shift_mode),
	.plugboard_forward_out(plugboard_forward_out),
	.plugboard_backward_out(plugboard_backward_out)
);

reflector reflector_U3
(
	.plugboard_forward_out(plugboard_forward_out),
	.reflector_out(reflector_out)
);

always @(posedge clk) begin
	if (~srst_n) begin
		load_reg <= 0;
		encrypt_reg <= 0;
		table_idx_reg <= 0; 
		code_in_reg <= 0;
		crypt_mode_reg <= 0;
	end else begin
		load_reg <= load;
		encrypt_reg <= encrypt;
		table_idx_reg <= table_idx; 
		code_in_reg <= code_in;
		crypt_mode_reg <= crypt_mode;
	end
end

always @(*) begin
	if (encrypt_reg) begin
		code_out_reg = rotorA_backward_out; 
		code_valid_reg = 1;
	end else begin
		code_out_reg = 0; 
		code_valid_reg = 0;
	end
end

always @(posedge clk) begin
	if (~srst_n) begin
		code_out <= 0; 
		code_valid <= 0;
	end else begin
		code_out <= code_out_reg; 
		code_valid <= code_valid_reg;
	end
end

endmodule
