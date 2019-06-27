`include "32bit_cla.v"

module wallace_mul(input [15:0] a, input [15:0] b, output [32:0] out, input clk);

wire [30:0] m[0:15];
reg [30:0] m15_1,m15_2,m15_3;
reg [30:0] u[14:0];
reg [31:0] v[14:0];
reg [31:0] v10_1,v12_2,v12_1;
reg [31:0] temp;

genvar q,k,i,j;

assign m[0] = b[0] == 0 ? 31'b0 : {15'b0,a};
assign m[1] = b[1] == 0 ? 31'b0 : {14'b0,a,1'b0};
assign m[2] = b[2] == 0 ? 31'b0 : {13'b0,a,2'b0};
assign m[3] = b[3] == 0 ? 31'b0 : {12'b0,a,3'b0};
assign m[4] = b[4] == 0 ? 31'b0 : {11'b0,a,4'b0};
assign m[5] = b[5] == 0 ? 31'b0 : {10'b0,a,5'b0};
assign m[6] = b[6] == 0 ? 31'b0 : {9'b0,a,6'b0};
assign m[7] = b[7] == 0 ? 31'b0 : {8'b0,a,7'b0};
assign m[8] = b[8] == 0 ? 31'b0 : {7'b0,a,8'b0};
assign m[9] = b[9] == 0 ? 31'b0 : {6'b0,a,9'b0};
assign m[10] = b[10] == 0 ? 31'b0 : {5'b0,a,10'b0};
assign m[11] = b[11] == 0 ? 31'b0 : {4'b0,a,11'b0};
assign m[12] = b[12] == 0 ? 31'b0 : {3'b0,a,12'b0};
assign m[13] = b[13] == 0 ? 31'b0 : {2'b0,a,13'b0};
assign m[14] = b[14] == 0 ? 31'b0 : {1'b0,a,14'b0};
assign m[15] = b[15] == 0 ? 31'b0 : {a,15'b0};


generate    for(q=0; q<=14; q=q+1) begin
                  always @ ( posedge clk )
                        v[q][0] <= 0;
            end
endgenerate

generate    for(k=0; k<=12; k=k+3) begin
                  for(q=0; q<=30; q=q+1) begin
                  always @ ( posedge clk ) begin
                        u[k][q] <= m[k][q] ^ m[k+1][q] ^ m[k+2][q];
                        v[k][q+1] <= m[k][q] && m[k+1][q] || m[k+2][q] && ( m[k][q] || m[k+1][q] );
                  end
                  end
            end
            always @ ( posedge clk )
                  m15_1 <= m[15];
//--------------------------------------------------------
            for(q=0; q<=30; q=q+1) begin
            always @ ( posedge clk ) begin
                        u[1][q] <= u[0][q] ^ v[0][q] ^ u[3][q];
                        v[1][q+1] <= u[0][q] && v[0][q] || u[3][q] && ( u[0][q] || v[0][q] );
            end
            end
            for(q=0; q<=30; q=q+1) begin
            always @ ( posedge clk ) begin
                        u[2][q] <= u[6][q] ^ v[6][q] ^ v[3][q];
                        v[2][q+1] <= u[6][q] && v[6][q] || v[3][q] && ( u[6][q] || v[6][q] );
            end
            end
            for(q=0; q<=30; q=q+1) begin
            always @ ( posedge clk ) begin
                  u[4][q] <= u[9][q] ^ v[9][q] ^ u[12][q];
                  v[4][q+1] <= u[9][q] && v[9][q] || u[12][q] && ( u[9][q] || v[9][q] );
            end
            end
            always @ ( posedge clk ) begin
                  m15_2 <= m15_1;
                  v12_1 <= v[12];
            end
//--------------------------------------------------------
            for(q=0; q<=30; q=q+1) begin
            always @ ( posedge clk ) begin
                  u[5][q] <= u[1][q] ^ v[1][q] ^ u[2][q];
                  v[5][q+1] <= u[1][q] && v[1][q] || u[2][q] && ( u[1][q] || v[1][q] );
            end
            end
            for(q=0; q<=30; q=q+1) begin
            always @ ( posedge clk ) begin
                  u[7][q] <= u[4][q] ^ v[4][q] ^ v[2][q];
                  v[7][q+1] <= u[4][q] && v[4][q] || v[2][q] && ( u[4][q] || v[4][q] );
            end
            end
            always @ ( posedge clk ) begin
                  m15_3 <= m15_2;
                  v12_2 <= v12_1;
            end
//--------------------------------------------------------
            for(q=0; q<=30; q=q+1) begin
            always @ ( posedge clk ) begin
                  u[8][q] <= u[5][q] ^ v[5][q] ^ u[7][q];
                  v[8][q+1] <= u[5][q] && v[5][q] || u[7][q] && ( u[5][q] || v[5][q] );
            end
            end
            for(q=0; q<=30; q=q+1) begin
            always @ ( posedge clk ) begin
                  u[10][q] <= m15_3[q] ^ v12_2[q] ^ v[7][q];
                  v[10][q+1] <= m15_3[q] && v12_2[q] || v[7][q] && ( m15_3[q] || v12_2[q] );
            end
            end
//--------------------------------------------------------
            for(q=0; q<=30; q=q+1) begin
            always @ ( posedge clk ) begin
                  u[11][q] <= u[8][q] ^ v[8][q] ^ u[10][q];
                  v[11][q+1] <= u[8][q] && v[8][q] || u[10][q] && ( u[8][q] || v[8][q] );
            end
            end
            always @ ( posedge clk )
                  v10_1 <= v[10];
//--------------------------------------------------------
            for(q=0; q<=30; q=q+1) begin
            always @ ( posedge clk ) begin
                  u[13][q] <= u[11][q] ^ v[11][q] ^ v10_1[q];
                  v[13][q+1] <= u[11][q] && v[11][q] || v10_1[q] && ( u[11][q] || v[11][q] );
            end
            end
endgenerate

always @ ( posedge clk ) begin
      temp <= {1'b0,u[13]};
end

cla32 object(.a(temp),.b(v[13]),.out(out));

endmodule
