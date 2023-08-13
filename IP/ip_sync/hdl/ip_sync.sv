module ip_sync
#(
    parameter ADDR_TRIGGER =  8'h8,
    parameter DATA_TRIGGER = 32'd2
)
(
    // Input IP globals
    input  logic          reset,
    input  logic          clk,

    // Input AVMM ifc - TODO AXI-Lite
    input   logic         S_AVMM_R,
    output  logic [31:0]  S_AVMM_RDATA,
    output  logic         S_AVMM_READATAVALID,
    input   logic         S_AVMM_W,
    input   logic [31:0]  S_AVMM_WDATA,
    input   logic [7 :0]  S_AVMM_ADDR,
    output  logic         S_AVMM_WAITREQUEST,
    input   logic         S_AVMM_BURSTCOUNT,
    input   logic [ 3:0]  S_AVMM_BYTEENABLE,

    // Output AVST _ TODO AXI-S
    input  logic         M_AVST_READY,
    output logic  [ 7:0] M_AVST_DATA,
    output logic         M_AVST_VALID,

    // Input AVMM ifc - TODO AXI-Lite
    output  logic         M_AVMM_R,
    input   logic [31:0]  M_AVMM_RDATA,
    input   logic         M_AVMM_READATAVALID,
    output  logic         M_AVMM_W,
    output  logic [31:0]  M_AVMM_WDATA,
    output  logic [7 :0]  M_AVMM_ADDR,
    input   logic         M_AVMM_WAITREQUEST,
    output  logic         M_AVMM_BURSTCOUNT,
    output  logic [ 3:0]  M_AVMM_BYTEENABLE
);

logic [  7:0] trigger;

always_comb trigger = { 7'b0, ((S_AVMM_W == 1'b1) && (S_AVMM_ADDR == ADDR_TRIGGER) && (S_AVMM_WDATA == DATA_TRIGGER))};

// Sync logic
always_ff@(posedge clk) begin
    if(reset) begin
        M_AVST_DATA        <= 8'h0;
        M_AVST_VALID       <= 1'b0;
    end else begin
        M_AVST_DATA         <= trigger;
        M_AVST_VALID        <= 1'b1;
    end
end

always_comb M_AVMM_R = S_AVMM_R;
always_comb S_AVMM_RDATA = M_AVMM_RDATA;
always_comb S_AVMM_READATAVALID = M_AVMM_READATAVALID;
always_comb M_AVMM_W = S_AVMM_W;
always_comb M_AVMM_WDATA = S_AVMM_WDATA;
always_comb M_AVMM_ADDR = S_AVMM_ADDR;
always_comb S_AVMM_WAITREQUEST = M_AVMM_WAITREQUEST;
always_comb M_AVMM_BURSTCOUNT = S_AVMM_BURSTCOUNT;
always_comb M_AVMM_BYTEENABLE = S_AVMM_BYTEENABLE;

endmodule
