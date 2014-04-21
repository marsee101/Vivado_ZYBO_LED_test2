// AXI4 bus Master Bus Fucntion Mode
// 2012/10/24 : 修正、S_AXI_AWREADYが1になるのを確認してからS_AXI_WVALIDを1にしていたのでは、AXIバスの非標準となる。
// よって、AXI_MASTER_WAC とAXI_MASTER_WDC をfork ~ join で並列に実行する
// 2013/12/14 : input に DELAYを入れるように変更
//

`default_nettype none

`timescale 100ps / 1ps

module AXI4_Master_BFM #(
	parameter DELAY	= 10 )
(
	input	wire	ACLK,

	output reg [0:0] S_AXI_AWID = 0,
	output reg [31:0] S_AXI_AWADDR = 0,
	output reg [7:0] S_AXI_AWLEN = 0,
	output reg [2:0] S_AXI_AWSIZE = 0,
	output reg [1:0] S_AXI_AWBURST = 0,
	output reg [1:0] S_AXI_AWLOCK = 0,
	output reg [3:0] S_AXI_AWCACHE = 3,	// Normal Non-cacheable bufferable
	output reg [2:0] S_AXI_AWPROT = 0,
	output reg [3:0] S_AXI_AWREGION = 0,
	output reg [3:0] S_AXI_AWQOS = 0,
	output reg [0:0] S_AXI_AWUSER = 0,
	output reg S_AXI_AWVALID = 0,
	output reg [0:0] S_AXI_WID = 0,
	output reg [31:0] S_AXI_WDATA = 0,
	output reg [3:0] S_AXI_WSTRB = 0,
	output reg S_AXI_WLAST = 0,
	output reg [0:0] S_AXI_WUSER = 0,
	output reg S_AXI_WVALID = 0,
	output reg S_AXI_BREADY = 0,
	output reg [0:0] S_AXI_ARID = 0,
	output reg [31:0] S_AXI_ARADDR = 0,
	output reg [7:0] S_AXI_ARLEN = 0,
	output reg [2:0] S_AXI_ARSIZE = 0,
	output reg [1:0] S_AXI_ARBURST = 0,
	output reg [1:0] S_AXI_ARLOCK = 0,
	output reg [3:0] S_AXI_ARCACHE = 2, // Normal Non-cacheable bufferable
	output reg [2:0] S_AXI_ARPROT = 0,
	output reg [3:0] S_AXI_ARREGION = 0,
	output reg [3:0] S_AXI_ARQOS = 0,
	output reg [0:0] S_AXI_ARUSER = 0,
	output reg S_AXI_ARVALID = 0,
	output reg S_AXI_RREADY = 0,

	input wire S_AXI_AWREADY,
	input wire S_AXI_WREADY,
	input wire [0:0] S_AXI_BID,
	input wire [1:0] S_AXI_BRESP,
	input wire [0:0] S_AXI_BUSER,
	input wire S_AXI_BVALID,
	input wire S_AXI_ARREADY,
	input wire [0:0] S_AXI_RID,
	input wire [31:0] S_AXI_RDATA,
	input wire [1:0] S_AXI_RRESP,
	input wire S_AXI_RLAST,
	input wire [0:0] S_AXI_RUSER,
	input wire S_AXI_RVALID
);

	reg	 [7:0]	awlen_hold = 0;
	reg	 [0:0]	wid_hold = 0;
	reg	 axi_w_transaction_active = 0;
	reg	 axi_r_transaction_active = 0;
	reg	 [7:0]	arlen_hold = 0;

	reg	 S_AXI_AWREADY_d;
	reg	 S_AXI_WREADY_d;
	reg	 [0:0] S_AXI_BID_d;
	reg	 [1:0] S_AXI_BRESP_d;
	reg	 [0:0] S_AXI_BUSER_d;
	reg	 S_AXI_BVALID_d;
	reg	 S_AXI_ARREADY_d;
	reg	 [0:0] S_AXI_RID_d;
	reg	 [31:0] S_AXI_RDATA_d;
	reg	 [1:0] S_AXI_RRESP_d;
	reg	 S_AXI_RLAST_d;
	reg	 [0:0] S_AXI_RUSER_d;
	reg	 S_AXI_RVALID_d;

	always @* S_AXI_AWREADY_d <= #DELAY S_AXI_AWREADY;
	always @* S_AXI_WREADY_d <= #DELAY S_AXI_WREADY;
	always @* S_AXI_BID_d <= #DELAY S_AXI_BID;
	always @* S_AXI_BRESP_d <= #DELAY S_AXI_BRESP;
	always @* S_AXI_BUSER_d <= #DELAY S_AXI_BUSER;
	always @* S_AXI_BVALID_d <= #DELAY S_AXI_BVALID;
	always @* S_AXI_ARREADY_d <= #DELAY S_AXI_ARREADY;
	always @* S_AXI_RID_d <= #DELAY S_AXI_RID;
	always @* S_AXI_RDATA_d <= #DELAY S_AXI_RDATA;
	always @* S_AXI_RRESP_d <= #DELAY S_AXI_RRESP;
	always @* S_AXI_RLAST_d <= #DELAY S_AXI_RLAST;
	always @* S_AXI_RUSER_d <= #DELAY S_AXI_RUSER;
	always @* S_AXI_RVALID_d <= #DELAY S_AXI_RVALID;

	// Write Channel
	// wait_clk_bready : 0 - bready の Wait は無し、0以外 - bready の Wait　は wait_clk_bready　の値の Wait が入る
	// wmax_wait : 0 - wvalid の Wait は無し、0以外 - wmax_wait を最大値とするランダムな値の Wait が　wvalid に入る
	task AXI_Master_1Seq_Write;	// Write Address; Write Data, Write Response をシーケンシャルにオーバーラップせずに行う。
		input	[0:0]	awid;
		input	[31:0]	awaddr;
		input	[7:0]	awlen;
		input	[2:0]	awsize;
		input	[1:0]	awburst;
		input	[31:0]	wdata;
		input	[7:0]	wait_clk_bready;
		input	[7:0]	wmax_wait;
		begin
			fork
				AXI_MASTER_WAC(awid, awaddr, awlen, awsize, awburst);
				AXI_MASTER_WDC(wdata, wmax_wait);
			join
			AXI_MASTER_WRC(wait_clk_bready);
		end
	endtask

	// Write Address Channel
	task AXI_MASTER_WAC;
		input	[0:0]	awid;
		input	[31:0]	awaddr;
		input	[7:0]	awlen;
		input	[2:0]	awsize;
		input	[1:0]	awburst;
		begin
			S_AXI_AWID		= awid;
			S_AXI_AWADDR	= awaddr;
			S_AXI_AWLEN		= awlen;
			S_AXI_AWSIZE	= awsize;
			S_AXI_AWBURST	= awburst;
			S_AXI_AWVALID	= 1'b1;

			if (axi_w_transaction_active == 1'b0) begin // AXI Write トランザクションが開始されている場合は戻る
				axi_w_transaction_active = 1'b1; // AXIトランザクション開始

				awlen_hold		= awlen; // Write Data Channel のためにバースト数を取っておく
				@(posedge ACLK);	// 次のクロックへ

				while (~S_AXI_AWREADY_d) begin	// S_AXI_AWREADY が1になるまで待つ
					#DELAY;
					@(posedge ACLK);	// 次のクロックへ
				end

				#DELAY;
				S_AXI_AWID 		= 0;
				S_AXI_AWADDR	= 0;
				S_AXI_AWLEN 	= 0;
				S_AXI_AWSIZE 	= 0;
				S_AXI_AWBURST 	= 0;
				S_AXI_AWVALID 	= 1'b0;
				@(posedge ACLK);	// 次のクロックへ
				#DELAY;
			end
		end
	endtask

	// Write Data Channel
	// wmax_wait : 0 - wvalid の Wait は無し、0以外 - wmax_wait を最大値とするランダムな値の Wait が　wvalid に入る
	task AXI_MASTER_WDC;	// WDATA は+1する
	// とりあえず、WSTRBはオール1にする
		input	[31:0]	wdata;
		input	[7:0]	wmax_wait;	// Write時の最大wait数
		integer	i, j, val;
		begin
			i = 0; j = 0;
			S_AXI_WSTRB = 4'b1111;

			while (~S_AXI_AWVALID) begin	// S_AXI_AWVALID が1になるまで待つ
				@(posedge ACLK);	// 次のクロックへ
				#DELAY;
			end

			while (i<=awlen_hold) begin
				if (wmax_wait == 0) // wmax_wait が0の時は$random を実行しない
					val = 0;
				else
					val = $unsigned($random) % (wmax_wait+1);

				if (val == 0) begin // waitなし
					S_AXI_WVALID = 1'b1;
				end else begin // waitあり
					S_AXI_WVALID = 1'b0;
					for (j=0; j<val; j=j+1) begin
						@(posedge ACLK);	// 次のクロックへ
						#DELAY;
					end
					S_AXI_WVALID = 1'b1; // wait終了
				end

				if (i == awlen_hold)
					S_AXI_WLAST = 1'b1;
				else
					S_AXI_WLAST = 1'b0;
				S_AXI_WDATA = wdata;
				wdata = wdata + 1;

				@(posedge ACLK);	// 次のクロックへ

				while (~S_AXI_WREADY_d) begin	// S_AXI_WREADY が0の時は1になるまで待つ
					#DELAY;
					@(posedge ACLK);	// 次のクロックへ
				end
				#DELAY;

				i = i + 1;
			end
			S_AXI_WVALID = 1'b0;
			S_AXI_WLAST = 1'b0;
			S_AXI_WSTRB = 4'b0000;
		end
	endtask

	// Write Response Channel
	// wait_clk_bready : 0 - bready の Wait は無し、0以外 - bready の Wait　は wait_clk_bready　の値の Wait が入る
	task AXI_MASTER_WRC;	// wait_clk_bready
		input	[7:0]	wait_clk_bready;
		integer	i;
		begin
			for (i=0; i<wait_clk_bready; i=i+1) begin
				@(posedge ACLK);	// 次のクロックへ
				#DELAY;
			end

			S_AXI_BREADY = 1'b1;


			@(posedge ACLK);	// 次のクロックへ

			while (~S_AXI_BVALID_d) begin // S_AXI_BVALID が1になるまでWait
				#DELAY;
				@(posedge ACLK);	// 次のクロックへ
			end
			#DELAY;

			S_AXI_BREADY = 1'b0;

			axi_w_transaction_active = 1'b0; // AXIトランザクション終了
			@(posedge ACLK);
			#DELAY;
		end
	endtask

	// Read Channel
	task AXI_Master_1Seq_Read; // Read Address, Read Data をシーケンシャルに行う。
		input	[0:0]	arid;
		input	[31:0]	araddr;
		input	[7:0]	arlen;
		input	[2:0]	arsize;
		input	[1:0]	arburst;
		input	[7:0]	rmax_wait;	// Read時の最大wait数
		begin
			AXI_MASTER_RAC(arid, araddr, arlen, arsize, arburst);
			AXI_MASTER_RDC(rmax_wait);
		end
	endtask

	// Read Address Channel
	task AXI_MASTER_RAC;
		input	[0:0]	arid;
		input	[31:0]	araddr;
		input	[7:0]	arlen;
		input	[2:0]	arsize;
		input	[1:0]	arburst;
		begin
			S_AXI_ARID 		= arid;
			S_AXI_ARADDR	= araddr;
			S_AXI_ARLEN		= arlen;
			S_AXI_ARSIZE	= arsize;
			S_AXI_ARBURST	= arburst;
			S_AXI_ARVALID 	= 1'b1;

			if (axi_r_transaction_active == 1'b0) begin // AXI Read トランザクションが開始されている場合は戻る
				arlen_hold	=arlen; // Read Data Channel のためにバースト数を取っておく
				@(posedge ACLK);	// 次のクロックへ

				while (~S_AXI_ARREADY_d) begin	// S_AXI_ARREADY が1になるまで待つ
					#DELAY;
					@(posedge ACLK);	// 次のクロックへ
				end

				#DELAY;
				S_AXI_ARID 		= 0;
				S_AXI_ARADDR	= 0;
				S_AXI_ARLEN 	= 0;
				S_AXI_ARSIZE 	= 0;
				S_AXI_ARBURST 	= 0;
				S_AXI_ARVALID 	= 1'b0;
				@(posedge ACLK);	// 次のクロックへ
				#DELAY;
				axi_r_transaction_active = 1'b1; // AXIトランザクション開始
			end
		end
	endtask

	// Read Data Channel
	task AXI_MASTER_RDC; // S_AXI_RLAST がアサートされるまでS_AXI_RREADY をアサートする
		input	[7:0]	rmax_wait;	// Read時の最大wait数
		integer i, val;
		begin
			while (~(S_AXI_RLAST_d & S_AXI_RVALID_d & S_AXI_RREADY)) begin // S_AXI_RLAST & S_AXI_RVALID & S_AXI_RREADY で終了
				if (rmax_wait == 0) begin // rmax_wait が0の時は$random を実行しない
					val = 0;
					S_AXI_RREADY = 1'b1;
				end else begin
					val = $unsigned($random) % (rmax_wait+1);
					if (val == 0)
						S_AXI_RREADY = 1'b1;
					else
						S_AXI_RREADY = 1'b0;
				end
				#DELAY;

				for (i=0; i<val; i=i+1) begin // ランダム値でWait、val=0の時はスキップ
					@(posedge ACLK);	// 次のクロックへ
					#DELAY;
				end

				S_AXI_RREADY = 1'b1;
				@(posedge ACLK);	// 次のクロックへ
				while (~S_AXI_RVALID_d) begin // S_AXI_RVALID が1になるまでWait
					#DELAY;
					@(posedge ACLK);	// 次のクロックへ
				end
				#DELAY;
			end
			#DELAY;

			S_AXI_RREADY = 1'b0;
			axi_r_transaction_active = 1'b0; // AXIトランザクション終了
			@(posedge ACLK);
			#DELAY;
		end
	endtask

endmodule

`default_nettype wire
