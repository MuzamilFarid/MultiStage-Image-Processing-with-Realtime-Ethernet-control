`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2025 01:47:41 PM
// Design Name: 
// Module Name: Pixel_Assembler
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:

//  This module will assemble the RGB565 pixels into RGB888 and provide them to Grayscale converter
//  This module takes direct camera input from OV7670 camera 
//////////////////////////////////////////////////////////////////////////////////


module Pixel_Assembler(

   input logic PCLK,  // Pixel clock
   input logic RST, // Camera reset 
   input logic [7:0] DATA,  // 8 bit camera data
   input logic HSYNC,
   input logic VSYNC,
   // RGB ouput to Grayscale converter
   output logic [7:0] R,   
   output logic [7:0] G,
   output logic [7:0] B,
   
   output logic pixel_valid,
   output logic [31:0] bram_addr, // Address calculated based on valid RGB888 pixels, will be passed on to the Grayscale module and then to BRAM instances.. 
   output logic bram_we



    );

   logic byte_check;
   logic [7:0] byte_1;
   logic [7:0] byte_2;



   always_ff @(posedge PCLK or negedge RST) begin   // Need to confirm active high or low reset
    
      if(RST) begin
        byte_1     <= 0;
        byte_2     <= 0;
        byte_check <= 0;
        pixel_valid <= 0;
      end
      else begin
        pixel_valid <= 0;
        // Start of a valid frame with a new line
        if(HSYNC && !VSYNC) begin
           if(!byte_check) begin
              byte_1      <= DATA;
              byte_check  <= 1;
            
           end
           else begin
             byte_check  <= 0;
             byte_2      <= DATA;
             pixel_valid <= 1;
            
           end
      
      
            // Pixel valid activates after 1 PCLK and goes down
        pixel_valid <= 0;
        // RGB565 to RGB888  (Double check the order of RGB colours..), can move it inside the else block of above if else
        R <= {byte1[7:3], 3'b000};
        G <= {byte1[2:0], byte2[7:5], 2'b00};
        B <= {byte2[4:0], 3'b000};

        
       end
   end

end

   // Always block to generate counters for pixels and each line
   // pixel_counter, line_counter

   // Total 640 pixels in one line
   // Total 480 lines
   // Image Resolution ->  640x480
   / Pixel and line counters (X and Y)
   always_ff @(posedge PCLK or posedge RST) begin
       if (RST) begin
           pixel_counter <= 0;
           line_counter  <= 0;
       end
       else begin
           if (VSYNC) begin
               // Start of new frame
               pixel_counter <= 0;
               line_counter <= 0;
           end
           else if (HSYNC && pixel_valid) begin      // Only increment pixel counter when complete RGB888 pixel is ready
                   if (pixel_counter == 639) begin
                    pixel_counter <= 0;
                       if (line_counter != 479)
                        line_counter <= line_counter + 1;
                   end
                   else begin
                    pixel_counter <= pixel_counter + 1;
                   end
           end
       end
   end


   assign bram_addr = line_counter*640 + pixel_counter;
   assign bram_we   = pixel_valid;













endmodule
