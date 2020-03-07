module addergen_st #( parameter NBITS = 32 )(
output wire[NBITS-1:0] r ,
output wire cout ,
input wire[NBITS-1:0] a ,
input wire[NBITS-1:0] b ,
input wire cin ) ;
wire [NBITS:0] carry;
assign carry[0]= cin ;
genvar k ;
generate
for (k=0; k < NBITS; k = k+1)
begin : blk
fulladder_st FA (
.r(r[k]),
.cout(carry[k+1]),
.a(a[k]),
.b(b[k]),
.cin(carry[k]) ) ;
end
endgenerate
assign cout = carry[NBITS] ;
endmodule