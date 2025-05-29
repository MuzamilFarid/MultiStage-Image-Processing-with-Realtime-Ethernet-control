`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2025 12:29:55 AM
// Design Name: 
// Module Name: RGB-Grayscale
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

// The RGB data will come from a OV7670 camera, The RGB565 will be converted first to RGB888 and RGB888 is converted to Grayscale

//////////////////////////////////////////////////////////////////////////////////


module RGB-Grayscale(

   input logic PCLK,
   input logic rst,
   input logic[7:0] R,
   input logic[7:0] G,
   input logic[7:0] B,
   output logic [7:0] GRAY_pixel_data,

    );



assign GRAY_pixel_data = (R*77 + G*150 + B*29) >> 8;




endmodule
