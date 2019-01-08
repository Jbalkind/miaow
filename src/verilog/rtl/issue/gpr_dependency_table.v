module gpr_dependency_table
  (/*AUTOARG*/
   // Outputs
   ready_arry_gpr,
   // Inputs
   clk, rst, vgpr_alu_set_data, vgpr_lsu_set_data, sgpr_alu_set_data,
   sgpr_lsu_set_data, sgpr_valu_set_data, decode_instr_data,
   f_vgpr_alu_wr_done_wfid, f_vgpr_lsu_wr_done_wfid,
   f_sgpr_alu_wr_done_wfid, f_sgpr_lsu_instr_done_wfid, f_decode_wfid,
   f_decode_valid
   );

/**********************************************************************
 * The dependency table works this way:                               *
 * Ready bits are set whenever a operand that was not ready retires   *
 * or a operand that does not depends on a inflight instruction       *
 * destination is decoded                                             *
 * Ready bits are cleared whenever a operand that reads or writes to    *
 * the destination of a inflight instruction is decoded.              *
 **********************************************************************/
   input clk, rst;
   
   input [`ISSUE_GPR_RD_BITS_LENGTH-1:0] vgpr_alu_set_data, vgpr_lsu_set_data, 
					 sgpr_alu_set_data, sgpr_lsu_set_data,
					 sgpr_valu_set_data, decode_instr_data;
   input [`WF_ID_LENGTH-1:0]   f_vgpr_alu_wr_done_wfid, f_vgpr_lsu_wr_done_wfid, 
			      f_sgpr_alu_wr_done_wfid, f_sgpr_lsu_instr_done_wfid, 
			      f_decode_wfid;
   
   input 		      f_decode_valid;
   

   output [`WF_PER_CU-1:0]     ready_arry_gpr;
   wire [`WF_PER_CU*`ISSUE_GPR_RD_BITS_LENGTH-1:0] reg_out, reg_in;
   wire [`WF_PER_CU*`ISSUE_GPR_RD_BITS_LENGTH-1:0] 
						   vgpr_alu_set_demuxed, vgpr_lsu_set_demuxed,
						   sgpr_alu_set_demuxed, sgpr_lsu_set_demuxed,
						   sgpr_valu_set_demuxed,
						   decoded_instr_set_demuxed, decoded_instr_clear_demuxed,
						   issue_clear_demuxed;
   
   wire [`WF_PER_CU-1:0] 			 reg_wr_en;
   
   ready_bits_demux vgpr_alu_set_demux
     (
      .in(vgpr_alu_set_data),
      .addr(f_vgpr_alu_wr_done_wfid),
      .out(vgpr_alu_set_demuxed),
      .en(|vgpr_alu_set_data)
      );

   ready_bits_demux vgpr_lsu_set_demux
     (
      .in(vgpr_lsu_set_data),
      .addr(f_vgpr_lsu_wr_done_wfid),
      .out(vgpr_lsu_set_demuxed),
      .en(|vgpr_lsu_set_data)
      );

   ready_bits_demux sgpr_alu_set_demux
     (
      .in(sgpr_alu_set_data),
      .addr(f_sgpr_alu_wr_done_wfid),
      .out(sgpr_alu_set_demuxed),
      .en(|sgpr_alu_set_data)
      );

   ready_bits_demux sgpr_valu_set_demux
     (
      .in(sgpr_valu_set_data),
      .addr(f_vgpr_alu_wr_done_wfid),
      .out(sgpr_valu_set_demuxed),
      .en(|sgpr_valu_set_data)
      );
   
   ready_bits_demux sgpr_lsu_set_demux
     (
      .in(sgpr_lsu_set_data),
      .addr(f_sgpr_lsu_instr_done_wfid),
      .out(sgpr_lsu_set_demuxed),
      .en(|sgpr_lsu_set_data)
      );

   ready_bits_demux decode_instr_set_demux
     (
      .in(~decode_instr_data),
      .addr(f_decode_wfid),
      .out(decoded_instr_set_demuxed),
      .en(f_decode_valid)
      );

   ready_bits_demux decode_instr_clear_demux
     (
      .in(decode_instr_data),
      .addr(f_decode_wfid),
      .out(decoded_instr_clear_demuxed),
      .en(f_decode_valid)
      );
   
		
   assign reg_wr_en = {`WF_PER_CU{1'b1}};			  
   reg_param #(`ISSUE_GPR_RD_BITS_LENGTH) data_bank[`WF_PER_CU-1:0] 
     ( 
       .out(reg_out), 
       .in(reg_in), 
       .wr_en(reg_wr_en),
       .clk(clk), 
       .rst(rst) );

// Generate the ready bits, that are ready only when all depoendency bits are set 
// %%start_veriperl
// my $i;
// for($i=0; $i<40; $i=$i+1)
// {
//   print "assign ready_arry_gpr[$i] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*($i+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*$i];\n";
// }
// %%stop_veriperl
assign ready_arry_gpr[0] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(0+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*0];
assign ready_arry_gpr[1] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(1+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*1];
assign ready_arry_gpr[2] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(2+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*2];
assign ready_arry_gpr[3] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(3+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*3];
assign ready_arry_gpr[4] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(4+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*4];
assign ready_arry_gpr[5] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(5+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*5];
assign ready_arry_gpr[6] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(6+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*6];
assign ready_arry_gpr[7] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(7+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*7];
assign ready_arry_gpr[8] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(8+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*8];
assign ready_arry_gpr[9] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(9+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*9];
assign ready_arry_gpr[10] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(10+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*10];
assign ready_arry_gpr[11] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(11+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*11];
assign ready_arry_gpr[12] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(12+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*12];
assign ready_arry_gpr[13] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(13+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*13];
assign ready_arry_gpr[14] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(14+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*14];
assign ready_arry_gpr[15] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(15+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*15];
assign ready_arry_gpr[16] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(16+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*16];
assign ready_arry_gpr[17] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(17+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*17];
assign ready_arry_gpr[18] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(18+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*18];
assign ready_arry_gpr[19] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(19+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*19];
assign ready_arry_gpr[20] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(20+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*20];
assign ready_arry_gpr[21] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(21+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*21];
assign ready_arry_gpr[22] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(22+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*22];
assign ready_arry_gpr[23] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(23+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*23];
assign ready_arry_gpr[24] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(24+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*24];
assign ready_arry_gpr[25] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(25+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*25];
assign ready_arry_gpr[26] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(26+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*26];
assign ready_arry_gpr[27] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(27+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*27];
assign ready_arry_gpr[28] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(28+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*28];
assign ready_arry_gpr[29] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(29+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*29];
assign ready_arry_gpr[30] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(30+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*30];
assign ready_arry_gpr[31] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(31+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*31];
assign ready_arry_gpr[32] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(32+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*32];
assign ready_arry_gpr[33] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(33+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*33];
assign ready_arry_gpr[34] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(34+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*34];
assign ready_arry_gpr[35] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(35+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*35];
assign ready_arry_gpr[36] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(36+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*36];
assign ready_arry_gpr[37] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(37+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*37];
assign ready_arry_gpr[38] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(38+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*38];
assign ready_arry_gpr[39] = &reg_out[`ISSUE_GPR_RD_BITS_LENGTH*(39+1)-1:`ISSUE_GPR_RD_BITS_LENGTH*39];

// Generate updated dependencies, giving priority to sets over clears
assign reg_in = (   reg_out &
		    // Clear ready bits of all issued and non-ready decoded instructions 
		    ( ~decoded_instr_clear_demuxed   ) |
		    // Set ready bits of all retired and ready decoded instructions
		    ( vgpr_alu_set_demuxed | vgpr_lsu_set_demuxed | 
		    sgpr_alu_set_demuxed | sgpr_lsu_set_demuxed | 
		    sgpr_valu_set_demuxed | decoded_instr_set_demuxed) );

endmodule
