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
   // RGB ouput to Grayscale converter
   output logic [7:0] R,   
   output logic [7:0] G,
   output logic [7:0] B,
   



    );
endmodule
