module Asynchronous_FIFO(
	input  logic wclk,
	input  logic rclk,
	input  logic w_en,
	input  logic r_en,
	input  logic [7:0] data_in,
	input  logic nRst,
	output logic [7:0] data_out,
	output logic fifo_full,
	output logic fifo_empty
	
);

	logic[3:0] w_ptr;
	logic[3:0] w_ptr_gray;
	logic[3:0] w_ptr_sync_1;
	logic[3:0] w_ptr_sync_2;
	logic[3:0] r_ptr;
	logic[3:0] r_ptr_gray;
	logic[3:0] r_ptr_sync_1;
	logic[3:0] r_ptr_sync_2; 
	
	logic[7:0] mem [0:7];
	
	//In gray code, only one bit changes at a time during each count increment. This
	//minimizes the chances of incorrect or partially updated values when sampled asynchronously
	//in another clock domain.
	//Binary counters can have multiple multiple bits changing simultaneously, 
	//leading to temporary incorrect values.
	//When transferring a multi-bit binary value across asynchronous clock domains,
	//its possible for some bits to transition faster than others, causing glitches.
	
	always_ff @(posedge wclk or negedge nRst)
	begin
		if(!nRst)
		begin
			w_ptr <= 3'b000;
			w_ptr_gray <= 3'b000;
		end
		else if(w_en && !fifo_full)
		begin
			w_ptr <= w_ptr + 1'b1;
			wr_ptr_gray <= (w_ptr + 1) ^ ((w_ptr + 1)>>1);
		end
		else 
		begin
			w_ptr <= wptr;
			w_ptr_gray <= w_ptr_gray;
		end
	end
	always_ff @(posedge rclk or negedge nRst)
	begin
		if(!nRst)
		w_ptr_sync_1 <= 0;
		else
		w_ptr_sync_1 <= w_ptr;
	end
	always_ff @(posedge rclk or negedge nRst)
	begin
		if(!nRst)
		w_ptr_sync_2 <= 0;
		else
		w_ptr_sync_2 <= w_ptr_sync_1;
	end
	always_ff @(posedge rclk or negedge nRst)
	begin
		if(!nRst)
			r_ptr <= 3'b000;
			r_ptr_gray <= 3'b000;
		else if(r_en && !fifo_empty)
			r_ptr <= r_ptr + 1'b1;
			r_ptr_gray <= (r_ptr + 1) ^ ((r_ptr + 1)>>1)
		else
			r_ptr <= r_ptr;
			r_ptr_gray <= r_ptr_gray;
	end
	always_ff @(posedge wclk or negedge nRst)
	begin
		if(!nRst)
		r_ptr_sync_1 <= 0;
		else
		r_ptr_sync_1 <= r_ptr;
	end
	always_ff @(posedge wclk or negedge nRst)
	begin
		if(!nRst)
		r_ptr_sync_2 <= 0;
		else
		r_ptr_sync_2 <= r_ptr_sync_1;
	end
	
	// Full and empty condition when not gray code
	//assign fifo_full  = (w_ptr[3] != r_ptr[3]) && (w_ptr[2:0] == r_ptr[2:0]);
	//assign fifo_empty = (w_ptr == r_ptr);
	
	//Full and empty condition when gray
	assign fifo_full  = (w_ptr_gray == {~r_ptr_gray_sync2[3:2], r_ptr_gray_sync2[1:0]});
	assign fifo_empty = (w_ptr_gray_sync2 == r_ptr_gray);
	
	always_ff @(posedge wclk or negedge nRst)
	begin
		if(!nRst)
			mem[0:7] <= 0;
		else if(w_en && !fifo_full)
			mem[w_ptr[2:0]] <= data_in; 
	end
	
	assign data_out = mem[r_ptr[2:0]];
	
endmodule
	
