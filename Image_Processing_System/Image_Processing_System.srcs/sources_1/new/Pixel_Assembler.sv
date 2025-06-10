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
   



    );

   logic byte_check;
   logic [7:0] byte_1;
   logic [7:0] byte_2;



   always_ff @(posedge PCLK or negedge RST) begin   // Need to confirm active high or low reset
    
      if(RST) begin
        byte_1     <= 0;
        byte_2     <= 0;
        byte_check <= 0;
      end
      else begin

        // Start of a valid frame with a new line
        if(HSYNC && !VSYNC) begin
           if(byte_check) begin
              byte_1      <= DATA;
              byte_check  <= 1;
           end
           else begin
             byte_check  <= 0;
             byte_2      <= DATA;
            
           end
        end
     
        // RGB565 to RGB888  (Double check the order of RGB colours..)
        R <= {byte1[7:3], 3'b000};
        G <= {byte1[2:0], byte2[7:5], 2'b00};
        B <= {byte2[4:0], 3'b000};
      end
   end

   // Always block to generate counters for pixels and each line
   // pixel_counter, line_counter
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
           else if (HSYNC) begin
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














endmodule
