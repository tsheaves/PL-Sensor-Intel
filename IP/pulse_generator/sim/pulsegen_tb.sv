module pulsegen_tb( );

    bit clk_i;
    bit reset_i;

    always #10 clk_i = ~clk_i;

    // Reset with transport delay
    task reset_pg();
        @(posedge clk) resetn_i <= #1 1'b0;
        @(posedge clk) resetn_i <= #1 1'b1;
    endtask

    task inject_dwn_cnt_val( bit [31:0] cnt_val );
        @(posedge clk) pg0.rValidCounter <= cnt_val;
    endtask

    task inject_ip_sync_enable( bit [31:0] ipsync_val );
        @(posedge clk) ipSyncEnable <= cnt_val;
    endtask

    // Skip AVMM_ifc for now, just initialize to problematic state
    initial begin
        reset_pg();
        inject_ip_sync_enable(32'd0);
        inject_dwn_cnt_val(32'd20);
        repeat(40)
            @(posedge clk);
    end

    pulsegenerator pg0(     .S_AXI_ACLK(clk_i),
                            .S_AXI_ARESETN(reset_i) );
endmodule
