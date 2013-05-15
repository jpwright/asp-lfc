//POVRay-File created by 3d41.ulp v20110101
//C:/SPB_Data/eagle/protoCtrl/protoCtrl.brd
//1/19/2013 4:29:25 PM

#version 3.5;

//Set to on if the file should be used as .inc
#local use_file_as_inc = off;
#if(use_file_as_inc=off)


//changes the apperance of resistors (1 Blob / 0 real)
#declare global_res_shape = 1;
//randomize color of resistors 1=random 0=same color
#declare global_res_colselect = 0;
//Number of the color for the resistors
//0=Green, 1="normal color" 2=Blue 3=Brown
#declare global_res_col = 1;
//Set to on if you want to render the PCB upside-down
#declare pcb_upsidedown = off;
//Set to x or z to rotate around the corresponding axis (referring to pcb_upsidedown)
#declare pcb_rotdir = x;
//Set the length off short pins over the PCB
#declare pin_length = 2.5;
#declare global_diode_bend_radius = 1;
#declare global_res_bend_radius = 1;
#declare global_solder = on;

#declare global_show_screws = on;
#declare global_show_washers = on;
#declare global_show_nuts = on;

#declare global_use_radiosity = on;

#declare global_ambient_mul = 1;
#declare global_ambient_mul_emit = 0;

//Animation
#declare global_anim = off;
#local global_anim_showcampath = no;

#declare global_fast_mode = off;

#declare col_preset = 2;
#declare pin_short = on;

#declare e3d_environment = off;

#local cam_x = 0;
#local cam_y = 442;
#local cam_z = -236;
#local cam_a = 20;
#local cam_look_x = 0;
#local cam_look_y = -10;
#local cam_look_z = 0;

#local pcb_rotate_x = 0;
#local pcb_rotate_y = 0;
#local pcb_rotate_z = 0;

#local pcb_board = on;
#local pcb_parts = on;
#local pcb_wire_bridges = off;
#if(global_fast_mode=off)
	#local pcb_polygons = on;
	#local pcb_silkscreen = on;
	#local pcb_wires = on;
	#local pcb_pads_smds = on;
#else
	#local pcb_polygons = off;
	#local pcb_silkscreen = off;
	#local pcb_wires = off;
	#local pcb_pads_smds = off;
#end

#local lgt1_pos_x = 47;
#local lgt1_pos_y = 70;
#local lgt1_pos_z = 54;
#local lgt1_intense = 0.882903;
#local lgt2_pos_x = -47;
#local lgt2_pos_y = 70;
#local lgt2_pos_z = 54;
#local lgt2_intense = 0.882903;
#local lgt3_pos_x = 47;
#local lgt3_pos_y = 70;
#local lgt3_pos_z = -37;
#local lgt3_intense = 0.882903;
#local lgt4_pos_x = -47;
#local lgt4_pos_y = 70;
#local lgt4_pos_z = -37;
#local lgt4_intense = 0.882903;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 124.460000;
#declare pcb_y_size = 102.870000;
#declare pcb_layer1_used = 1;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(73);
#declare global_pcb_layer_dis = array[16]
{
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	1.535000,
}
#declare global_pcb_real_hole = 2.000000;

#include "e3d_tools.inc"
#include "e3d_user.inc"

global_settings{charset utf8}

#if(e3d_environment=on)
sky_sphere {pigment {Navy}
pigment {bozo turbulence 0.65 octaves 7 omega 0.7 lambda 2
color_map {
[0.0 0.1 color rgb <0.85, 0.85, 0.85> color rgb <0.75, 0.75, 0.75>]
[0.1 0.5 color rgb <0.75, 0.75, 0.75> color rgbt <1, 1, 1, 1>]
[0.5 1.0 color rgbt <1, 1, 1, 1> color rgbt <1, 1, 1, 1>]}
scale <0.1, 0.5, 0.1>} rotate -90*x}
plane{y, -10.0-max(pcb_x_size,pcb_y_size)*abs(max(sin((pcb_rotate_x/180)*pi),sin((pcb_rotate_z/180)*pi)))
texture{T_Chrome_2D
normal{waves 0.1 frequency 3000.0 scale 3000.0}} translate<0,0,0>}
#end

//Animation data
#if(global_anim=on)
#declare global_anim_showcampath = no;
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_flight=0;
#warning "No/not enough Animation Data available (min. 3 points) (Flight path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_view=0;
#warning "No/not enough Animation Data available (min. 3 points) (View path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#end

#if((global_anim_showcampath=yes)&(global_anim=off))
#end
#if(global_anim=on)
camera
{
	location global_anim_spline_cam_flight(clock)
	#if(global_anim_npoints_cam_view>2)
		look_at global_anim_spline_cam_view(clock)
	#else
		look_at global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	angle 45
}
light_source
{
	global_anim_spline_cam_flight(clock)
	color rgb <1,1,1>
	spotlight point_at 
	#if(global_anim_npoints_cam_view>2)
		global_anim_spline_cam_view(clock)
	#else
		global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	radius 35 falloff  40
}
#else
camera
{
	location <cam_x,cam_y,cam_z>
	look_at <cam_look_x,cam_look_y,cam_look_z>
	angle cam_a
	//translates the camera that <0,0,0> is over the Eagle <0,0>
	//translate<-62.230000,0,-51.435000>
}
#end

background{col_bgr}
light_source{<lgt1_pos_x,lgt1_pos_y,lgt1_pos_z> White*lgt1_intense}
light_source{<lgt2_pos_x,lgt2_pos_y,lgt2_pos_z> White*lgt2_intense}
light_source{<lgt3_pos_x,lgt3_pos_y,lgt3_pos_z> White*lgt3_intense}
light_source{<lgt4_pos_x,lgt4_pos_y,lgt4_pos_z> White*lgt4_intense}
#end


#macro PROTOCTRL(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Board
prism{-1.500000,0.000000,32
<19.050000,-7.620000><19.050000,76.835000>
<19.050000,76.835000><28.575000,86.360000>
<28.575000,86.360000><124.460000,86.360000>
<124.460000,86.360000><132.080000,78.740000>
<132.080000,78.740000><132.080000,5.080000>
<132.080000,5.080000><133.350000,3.810000>
<133.350000,3.810000><137.160000,3.810000>
<137.160000,3.810000><143.510000,-2.540000>
<143.510000,-2.540000><143.510000,-10.160000>
<143.510000,-10.160000><137.160000,-16.510000>
<137.160000,-16.510000><105.410000,-16.510000>
<105.410000,-16.510000><97.790000,-8.890000>
<97.790000,-8.890000><50.800000,-8.890000>
<50.800000,-8.890000><43.180000,-16.510000>
<43.180000,-16.510000><27.940000,-16.510000>
<27.940000,-16.510000><19.050000,-7.620000>
texture{col_brd}}
}//End union(PCB)
//Holes(real)/Parts
//Holes(real)/Board
//Holes(real)/Vias
cylinder{<31.750000,0.095000,-6.350000><31.750000,-1.595000,-6.350000>2.750000 texture{col_hls}}
cylinder{<31.750000,0.095000,69.850000><31.750000,-1.595000,69.850000>2.750000 texture{col_hls}}
cylinder{<133.350000,0.095000,-6.350000><133.350000,-1.595000,-6.350000>2.750000 texture{col_hls}}
prism{0.1,-1.600000,32
<19.050000,76.835000>
<19.050000,-7.620000><28.575000,86.360000><19.050000,76.835000><28.575000,86.360000>
<124.460000,86.360000><124.460000,86.360000><132.080000,78.740000><132.080000,78.740000>
<132.080000,5.080000><132.080000,5.080000><133.350000,3.810000><133.350000,3.810000>
<137.160000,3.810000><137.160000,3.810000><143.510000,-2.540000><143.510000,-2.540000>
<143.510000,-10.160000><143.510000,-10.160000><137.160000,-16.510000><137.160000,-16.510000>
<105.410000,-16.510000><105.410000,-16.510000><97.790000,-8.890000><97.790000,-8.890000>
<50.800000,-8.890000><50.800000,-8.890000><43.180000,-16.510000><43.180000,-16.510000>
<27.940000,-16.510000><27.940000,-16.510000><19.050000,-7.620000>texture{col_brd}}
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Parts
union{
#ifndef(pack_C1) #declare global_pack_C1=yes; object {CAP_SMD_CHIP_0603()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<26.670000,0.000000,13.970000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C1 4.7uF C0603
#ifndef(pack_C2) #declare global_pack_C2=yes; object {CAP_SMD_CHIP_0603()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<83.185000,0.000000,3.810000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C2 4.7uF C0603
#ifndef(pack_C3) #declare global_pack_C3=yes; object {CAP_SMD_CHIP_0603()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<69.850000,0.000000,10.160000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C3 1uF C0603
#ifndef(pack_C4) #declare global_pack_C4=yes; object {CAP_SMD_CHIP_0603()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<73.660000,0.000000,0.000000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C4 0.1uF C0603
#ifndef(pack_C5) #declare global_pack_C5=yes; object {CAP_SMD_CHIP_0603()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<100.965000,0.000000,8.890000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C5 0.1uF C0603
#ifndef(pack_C6) #declare global_pack_C6=yes; object {CAP_SMD_CHIP_0603()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<115.570000,0.000000,-1.905000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C6 100nF C0603
#ifndef(pack_C7) #declare global_pack_C7=yes; object {CAP_SMD_CHIP_0603()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<111.760000,0.000000,37.465000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C7 100nF C0603
#ifndef(pack_C8) #declare global_pack_C8=yes; object {CAP_SMD_CHIP_0603()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<102.870000,0.000000,36.830000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C8 100nF C0603
#ifndef(pack_C9) #declare global_pack_C9=yes; object {CAP_SMD_CHIP_0603()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<102.870000,0.000000,53.975000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C9 100nF C0603
#ifndef(pack_C10) #declare global_pack_C10=yes; object {CAP_SMD_CHIP_0603()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<112.395000,0.000000,53.975000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C10 100nF C0603
#ifndef(pack_C11) #declare global_pack_C11=yes; object {CAP_SMD_CHIP_0603()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<86.360000,0.000000,52.070000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C11 100nF C0603
#ifndef(pack_C12) #declare global_pack_C12=yes; object {CAP_SMD_CHIP_0603()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<97.790000,0.000000,53.975000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C12 100nF C0603
#ifndef(pack_C13) #declare global_pack_C13=yes; object {CAP_SMD_CHIP_0603()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<108.585000,0.000000,53.975000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C13 100nF C0603
#ifndef(pack_C14) #declare global_pack_C14=yes; object {CAP_SMD_CHIP_0603()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<78.740000,0.000000,34.290000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C14 100nF C0603
#ifndef(pack_C15) #declare global_pack_C15=yes; object {CAP_SMD_CHIP_0603()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<56.515000,0.000000,31.750000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C15 100nF C0603
#ifndef(pack_C16) #declare global_pack_C16=yes; object {CAP_SMD_CHIP_0603()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<78.740000,0.000000,38.100000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C16 100nF C0603
#ifndef(pack_C17) #declare global_pack_C17=yes; object {CAP_SMD_CHIP_0603()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<78.740000,0.000000,41.910000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C17 100nF C0603
#ifndef(pack_C18) #declare global_pack_C18=yes; object {CAP_SMD_CHIP_0603()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<103.505000,0.000000,8.890000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C18 15pF C0603
#ifndef(pack_C19) #declare global_pack_C19=yes; object {CAP_SMD_CHIP_0603()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<87.630000,0.000000,1.905000>translate<0,0.035000,0> }#end		//SMD Capacitor 0603 C19 15pF C0603
#ifndef(pack_CN1) #declare global_pack_CN1=yes; object {IC_BECK_SC12()translate<0,-0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,180> translate<35.560000,-1.500000,33.020000>}#end		//BECK IPC@CHIP SC1x CN1  ILI9325_28INCH_TS
#ifndef(pack_IC1) #declare global_pack_IC1=yes; object {QFP_TQFP_100_050MM("AVR_XMEGA_A1_100A","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<95.250000,0.000000,21.590000>translate<0,0.035000,0> }#end		//TQFP-100 IC1 AVR_XMEGA_A1_100A TQFP100
#ifndef(pack_JP2) #declare global_pack_JP2=yes; object {CON_PH_1X4()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<111.760000,0.000000,74.930000>}#end		//Header 2,54mm Grid 4Pin 1Row (jumper.lib) JP2  1X04
#ifndef(pack_JP3) #declare global_pack_JP3=yes; object {CON_PH_1X30()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<78.740000,0.000000,82.550000>}#end		//Header 2,54mm Grid 30Pin 1Row (jumper.lib) JP3  1X30
#ifndef(pack_JP4) #declare global_pack_JP4=yes; object {CON_PH_2X1J(-1,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<45.720000,0.000000,-2.540000>}#end		//Jumper 2,54mm Grid 2Pin 1Row (jumper.lib) JP4  JP1
#ifndef(pack_JP5) #declare global_pack_JP5=yes; object {CON_PH_2X1J(-1,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<49.530000,0.000000,-2.540000>}#end		//Jumper 2,54mm Grid 2Pin 1Row (jumper.lib) JP5  JP1
#ifndef(pack_JP6) #declare global_pack_JP6=yes; object {CON_PH_1X2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<60.960000,0.000000,0.000000>}#end		//Header 2,54mm Grid 2Pin 1Row (jumper.lib) JP6  1X02
#ifndef(pack_JP7) #declare global_pack_JP7=yes; object {CON_PH_2X3()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<105.410000,0.000000,-1.270000>}#end		//Header 2,54mm Grid 3Pin 2Row (jumper.lib) JP7  2X03
#ifndef(pack_JP8) #declare global_pack_JP8=yes; object {CON_PH_1X3()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<112.395000,0.000000,-1.270000>}#end		//Header 2,54mm Grid 3Pin 1Row (jumper.lib) JP8  1X03
#ifndef(pack_LED2) #declare global_pack_LED2=yes; object {DIODE_DIS_LED_3MM(Red,0.500000,0.000000,)translate<0,-0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,180> translate<125.730000,-1.500000,29.845000>}#end		//Diskrete 3MM LED LED2  LED3MM
#ifndef(pack_Q1) #declare global_pack_Q1=yes; object {IC_SMD_SOT223("","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<69.850000,0.000000,24.130000>translate<0,0.035000,0> }#end		//SOT223 Q1  SOT223
#ifndef(pack_Q2) #declare global_pack_Q2=yes; object {SPC_XTAL_5MM("",3,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<95.250000,0.000000,3.810000>}#end		//Quarz 4,9MM Q2  QS
#ifndef(pack_U1) #declare global_pack_U1=yes; object {IC_SMD_SOT23_5("MCP73831","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<53.340000,0.000000,8.890000>translate<0,0.035000,0> }#end		//SOT23-5 U1 MCP73831 SOT23-5
#ifndef(pack_U2) #declare global_pack_U2=yes; object {IC_SMD_SOT23_5("V_REG_LDOSMD","",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<73.660000,0.000000,6.350000>translate<0,0.035000,0> }#end		//SOT23-5 U2 V_REG_LDOSMD SOT23-5
}//End union
#end
#if(pcb_pads_smds=on)
//Pads&SMD/Parts
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<27.520000,0.000000,13.970000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<25.820000,0.000000,13.970000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<82.335000,0.000000,3.810000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<84.035000,0.000000,3.810000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<70.700000,0.000000,10.160000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<69.000000,0.000000,10.160000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<73.660000,0.000000,-0.850000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<73.660000,0.000000,0.850000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<100.965000,0.000000,8.040000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<100.965000,0.000000,9.740000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<115.570000,0.000000,-1.055000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<115.570000,0.000000,-2.755000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<111.760000,0.000000,36.615000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<111.760000,0.000000,38.315000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<102.870000,0.000000,35.980000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<102.870000,0.000000,37.680000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<103.720000,0.000000,53.975000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<102.020000,0.000000,53.975000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<113.245000,0.000000,53.975000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<111.545000,0.000000,53.975000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<86.360000,0.000000,51.220000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<86.360000,0.000000,52.920000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<98.640000,0.000000,53.975000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<96.940000,0.000000,53.975000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<109.435000,0.000000,53.975000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<107.735000,0.000000,53.975000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<79.590000,0.000000,34.290000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<77.890000,0.000000,34.290000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<56.515000,0.000000,32.600000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<56.515000,0.000000,30.900000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<79.590000,0.000000,38.100000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<77.890000,0.000000,38.100000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<79.590000,0.000000,41.910000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<77.890000,0.000000,41.910000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.505000,0.000000,8.040000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.505000,0.000000,9.740000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.630000,0.000000,1.055000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.630000,0.000000,2.755000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,15.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,16.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,17.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,18.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,19.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,20.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,21.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,22.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,23.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,24.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,25.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,26.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,27.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,28.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,29.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,30.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,31.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,32.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,33.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,34.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,35.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,36.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,37.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,38.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,39.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,40.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,41.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,42.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,43.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,44.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,45.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,46.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,47.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,48.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,49.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,50.020000>}
object{TOOLS_PCB_SMD(0.500000,3.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.330000,-1.537000,51.020000>}
object{TOOLS_PCB_SMD(0.800000,0.800000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<31.000000,0.000000,8.890000>}
object{TOOLS_PCB_SMD(0.800000,0.800000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<32.500000,0.000000,8.890000>}
object{TOOLS_PCB_SMD(0.800000,0.800000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<31.000000,0.000000,10.160000>}
object{TOOLS_PCB_SMD(0.800000,0.800000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<32.500000,0.000000,10.160000>}
#ifndef(global_pack_H1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(9.000000,5.500000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<133.350000,0,-6.350000> texture{col_thl}}
#ifndef(global_pack_H2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(9.000000,5.500000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<31.750000,0,-6.350000> texture{col_thl}}
#ifndef(global_pack_H3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(9.000000,5.500000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<31.750000,0,69.850000> texture{col_thl}}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<89.250000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<89.750000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<90.250000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<90.750000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<91.250000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<91.750000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<92.250000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<92.750000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<93.250000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<93.750000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<94.250000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<94.750000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<95.250000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<95.750000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<96.250000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<96.750000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<97.250000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<97.750000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<98.250000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<98.750000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<99.250000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<99.750000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<100.250000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<100.750000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<101.250000,0.000000,13.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,15.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,16.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,16.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,17.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,17.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,18.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,18.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,19.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,19.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,20.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,20.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,21.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,21.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,22.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,22.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,23.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,23.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,24.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,24.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,25.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,25.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,26.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,26.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,27.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<103.250000,0.000000,27.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<101.250000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<100.750000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<100.250000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<99.750000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<99.250000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<98.750000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<98.250000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<97.750000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<97.250000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<96.750000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<96.250000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<95.750000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<95.250000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<94.750000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<94.250000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<93.750000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<93.250000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<92.750000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<92.250000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<91.750000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<91.250000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<90.750000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<90.250000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<89.750000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(1.500000,0.270000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<89.250000,0.000000,29.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,27.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,27.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,26.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,26.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,25.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,25.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,24.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,24.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,23.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,23.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,22.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,22.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,21.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,21.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,20.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,20.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,19.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,19.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,18.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,18.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,17.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,17.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,16.590000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,16.090000>}
object{TOOLS_PCB_SMD(0.270000,1.500000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<87.250000,0.000000,15.590000>}
object{TOOLS_PCB_SMD(1.000000,4.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<79.010000,0.000000,-4.970000>}
object{TOOLS_PCB_SMD(1.000000,4.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<81.010000,0.000000,-4.970000>}
object{TOOLS_PCB_SMD(3.400000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<76.610000,0.000000,0.230000>}
object{TOOLS_PCB_SMD(3.400000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<83.410000,0.000000,0.230000>}
object{TOOLS_PCB_SMD(2.500000,0.500000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<26.630000,0.000000,6.350000>}
object{TOOLS_PCB_SMD(2.500000,0.500000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<26.630000,0.000000,7.150000>}
object{TOOLS_PCB_SMD(2.500000,0.500000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<26.630000,0.000000,4.750000>}
object{TOOLS_PCB_SMD(2.500000,0.500000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<26.630000,0.000000,5.550000>}
object{TOOLS_PCB_SMD(2.500000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<21.130000,0.000000,10.850000>}
object{TOOLS_PCB_SMD(2.500000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<26.630000,0.000000,10.850000>}
object{TOOLS_PCB_SMD(2.500000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<21.130000,0.000000,1.850000>}
object{TOOLS_PCB_SMD(2.500000,2.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<26.630000,0.000000,1.850000>}
object{TOOLS_PCB_SMD(2.500000,0.500000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<26.630000,0.000000,7.950000>}
#ifndef(global_pack_JP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<107.950000,0,74.930000> texture{col_thl}}
#ifndef(global_pack_JP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<110.490000,0,74.930000> texture{col_thl}}
#ifndef(global_pack_JP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<113.030000,0,74.930000> texture{col_thl}}
#ifndef(global_pack_JP2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<115.570000,0,74.930000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<41.910000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<44.450000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<46.990000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<49.530000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<52.070000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<54.610000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<57.150000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<59.690000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<62.230000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<64.770000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<67.310000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<69.850000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<72.390000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<74.930000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<77.470000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<80.010000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<82.550000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<85.090000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<87.630000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<90.170000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<92.710000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<95.250000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<97.790000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<100.330000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<102.870000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<105.410000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<107.950000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<110.490000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<113.030000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<115.570000,0,82.550000> texture{col_thl}}
#ifndef(global_pack_JP4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<45.720000,0,-1.270000> texture{col_thl}}
#ifndef(global_pack_JP4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<45.720000,0,-3.810000> texture{col_thl}}
#ifndef(global_pack_JP5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<49.530000,0,-1.270000> texture{col_thl}}
#ifndef(global_pack_JP5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,0.914400,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<49.530000,0,-3.810000> texture{col_thl}}
#ifndef(global_pack_JP6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<59.690000,0,0.000000> texture{col_thl}}
#ifndef(global_pack_JP6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<62.230000,0,0.000000> texture{col_thl}}
#ifndef(global_pack_JP7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<107.950000,0,0.000000> texture{col_thl}}
#ifndef(global_pack_JP7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<107.950000,0,-2.540000> texture{col_thl}}
#ifndef(global_pack_JP7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<105.410000,0,0.000000> texture{col_thl}}
#ifndef(global_pack_JP7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<105.410000,0,-2.540000> texture{col_thl}}
#ifndef(global_pack_JP7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<102.870000,0,0.000000> texture{col_thl}}
#ifndef(global_pack_JP7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<102.870000,0,-2.540000> texture{col_thl}}
#ifndef(global_pack_JP8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<112.395000,0,-3.810000> texture{col_thl}}
#ifndef(global_pack_JP8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<112.395000,0,-1.270000> texture{col_thl}}
#ifndef(global_pack_JP8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<112.395000,0,1.270000> texture{col_thl}}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<83.185000,0.000000,20.740000>}
object{TOOLS_PCB_SMD(1.100000,1.000000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<83.185000,0.000000,22.440000>}
object{TOOLS_PCB_SMD(1.200000,1.400000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<56.920000,0.000000,6.985000>}
object{TOOLS_PCB_SMD(1.200000,1.400000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<59.920000,0.000000,6.985000>}
#ifndef(global_pack_LED2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.812800,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<127.000000,0,29.845000> texture{col_thl}}
#ifndef(global_pack_LED2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,0.812800,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<124.460000,0,29.845000> texture{col_thl}}
object{TOOLS_PCB_SMD(1.219200,2.235200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<72.161400,0.000000,27.228800>}
object{TOOLS_PCB_SMD(1.219200,2.235200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<69.850000,0.000000,27.228800>}
object{TOOLS_PCB_SMD(1.219200,2.235200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<67.538600,0.000000,27.228800>}
object{TOOLS_PCB_SMD(3.600000,2.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<69.850000,0.000000,21.031000>}
#ifndef(global_pack_Q2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.219200,0.609600,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<92.710000,0,3.810000> texture{col_thl}}
#ifndef(global_pack_Q2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.219200,0.609600,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<97.790000,0,3.810000> texture{col_thl}}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<53.325000,0.000000,5.715000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<54.625000,0.000000,5.715000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<32.370000,0.000000,13.970000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<33.670000,0.000000,13.970000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<32.370000,0.000000,12.700000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<33.670000,0.000000,12.700000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<57.800000,0.000000,10.160000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<56.500000,0.000000,10.160000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<117.490000,0.000000,1.905000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<116.190000,0.000000,1.905000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<56.530000,0.000000,20.955000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<55.230000,0.000000,20.955000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<56.530000,0.000000,18.415000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<55.230000,0.000000,18.415000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<56.530000,0.000000,16.510000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<55.230000,0.000000,16.510000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<53.340000,0.000000,22.875000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<53.340000,0.000000,21.575000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<53.325000,0.000000,29.210000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<54.625000,0.000000,29.210000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<55.260000,0.000000,40.640000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<53.960000,0.000000,40.640000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<69.200000,0.000000,31.115000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<70.500000,0.000000,31.115000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<69.200000,0.000000,33.020000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<70.500000,0.000000,33.020000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<69.200000,0.000000,34.925000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<70.500000,0.000000,34.925000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<77.470000,0.000000,24.750000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<77.470000,0.000000,26.050000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<74.930000,0.000000,26.050000>}
object{TOOLS_PCB_SMD(0.700000,0.900000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<74.930000,0.000000,24.750000>}
#ifndef(global_pack_S1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<128.346200,0,39.725600> texture{col_thl}}
#ifndef(global_pack_S1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<121.843800,0,39.725600> texture{col_thl}}
#ifndef(global_pack_S1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<128.346200,0,35.204400> texture{col_thl}}
#ifndef(global_pack_S1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.016000,1,16,1+global_tmp,0) rotate<0,-180.000000,0>translate<121.843800,0,35.204400> texture{col_thl}}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<114.210000,0.000000,15.270000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<114.210000,0.000000,14.620000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<109.160000,0.000000,11.370000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<109.160000,0.000000,12.020000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<109.160000,0.000000,12.670000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<109.160000,0.000000,13.320000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<109.160000,0.000000,15.270000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<109.160000,0.000000,15.920000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<109.160000,0.000000,16.570000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<109.160000,0.000000,17.220000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<114.210000,0.000000,17.220000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<114.210000,0.000000,13.320000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<114.210000,0.000000,16.570000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<109.160000,0.000000,13.970000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<114.210000,0.000000,11.370000>}
object{TOOLS_PCB_SMD(0.654000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<114.210000,0.000000,13.970000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<114.210000,0.000000,15.920000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<109.160000,0.000000,14.620000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<114.210000,0.000000,12.670000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<114.210000,0.000000,12.020000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<114.210000,0.000000,25.430000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<114.210000,0.000000,24.780000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<109.160000,0.000000,21.530000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<109.160000,0.000000,22.180000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<109.160000,0.000000,22.830000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<109.160000,0.000000,23.480000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<109.160000,0.000000,25.430000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<109.160000,0.000000,26.080000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<109.160000,0.000000,26.730000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<109.160000,0.000000,27.380000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<114.210000,0.000000,27.380000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<114.210000,0.000000,23.480000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<114.210000,0.000000,26.730000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<109.160000,0.000000,24.130000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<114.210000,0.000000,21.530000>}
object{TOOLS_PCB_SMD(0.654000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<114.210000,0.000000,24.130000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<114.210000,0.000000,26.080000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<109.160000,0.000000,24.780000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<114.210000,0.000000,22.830000>}
object{TOOLS_PCB_SMD(0.650000,0.203200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<114.210000,0.000000,22.180000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<113.270000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<112.470000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<111.670000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<110.870000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<110.070000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<109.270000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<108.470000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<107.670000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<106.870000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<106.070000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<105.270000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<104.470000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<103.670000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<102.870000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<102.070000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<101.270000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<100.470000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<99.670000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<98.870000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<98.070000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<97.270000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<96.470000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<95.670000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<94.870000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<94.070000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<93.270000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<92.470000,0.000000,51.400000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<92.470000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<93.270000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<94.070000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<94.870000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<95.670000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<96.470000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<97.270000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<98.070000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<98.870000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<99.670000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<100.470000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<101.270000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<102.070000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<102.870000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<103.670000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<104.470000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<105.270000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<106.070000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<106.870000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<107.670000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<108.470000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<109.270000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<110.070000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<110.870000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<111.670000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<112.470000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.900000,0.400000,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<113.270000,0.000000,40.040000>}
object{TOOLS_PCB_SMD(0.550000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<54.290000,0.000000,10.190100>}
object{TOOLS_PCB_SMD(0.550000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<53.340000,0.000000,10.190100>}
object{TOOLS_PCB_SMD(0.550000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.390000,0.000000,10.190100>}
object{TOOLS_PCB_SMD(0.550000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<52.390000,0.000000,7.589900>}
object{TOOLS_PCB_SMD(0.550000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<54.290000,0.000000,7.589900>}
object{TOOLS_PCB_SMD(0.550000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<72.710000,0.000000,5.049900>}
object{TOOLS_PCB_SMD(0.550000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<73.660000,0.000000,5.049900>}
object{TOOLS_PCB_SMD(0.550000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<74.610000,0.000000,5.049900>}
object{TOOLS_PCB_SMD(0.550000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<74.610000,0.000000,7.650100>}
object{TOOLS_PCB_SMD(0.550000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<72.710000,0.000000,7.650100>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<48.675000,0.000000,12.546000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<48.025000,0.000000,12.546000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<47.375000,0.000000,12.546000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<46.725000,0.000000,12.546000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<46.075000,0.000000,12.546000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<45.425000,0.000000,12.546000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<44.775000,0.000000,12.546000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<44.125000,0.000000,12.546000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<43.475000,0.000000,12.546000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<42.825000,0.000000,12.546000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<42.175000,0.000000,12.546000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<41.525000,0.000000,12.546000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<40.875000,0.000000,12.546000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<40.225000,0.000000,12.546000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<40.225000,0.000000,5.234000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<40.875000,0.000000,5.234000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<41.525000,0.000000,5.234000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<42.175000,0.000000,5.234000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<42.825000,0.000000,5.234000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<43.475000,0.000000,5.234000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<44.125000,0.000000,5.234000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<44.775000,0.000000,5.234000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<45.425000,0.000000,5.234000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<46.075000,0.000000,5.234000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<46.725000,0.000000,5.234000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<47.375000,0.000000,5.234000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<48.025000,0.000000,5.234000>}
object{TOOLS_PCB_SMD(0.348000,1.397000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<48.675000,0.000000,5.234000>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<77.165200,0.000000,71.323200>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<77.165200,0.000000,70.840600>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<77.165200,0.000000,70.332600>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<77.165200,0.000000,69.824600>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<77.165200,0.000000,69.342000>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<77.165200,0.000000,68.834000>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<77.165200,0.000000,68.326000>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<77.165200,0.000000,67.818000>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<77.165200,0.000000,67.335400>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<77.165200,0.000000,66.827400>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<77.165200,0.000000,66.319400>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<77.165200,0.000000,65.836800>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<78.536800,0.000000,64.465200>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<79.019400,0.000000,64.465200>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<79.527400,0.000000,64.465200>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<80.035400,0.000000,64.465200>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<80.518000,0.000000,64.465200>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<81.026000,0.000000,64.465200>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<81.534000,0.000000,64.465200>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<82.042000,0.000000,64.465200>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<82.524600,0.000000,64.465200>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<83.032600,0.000000,64.465200>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<83.540600,0.000000,64.465200>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<84.023200,0.000000,64.465200>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<85.394800,0.000000,65.836800>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<85.394800,0.000000,66.319400>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<85.394800,0.000000,66.827400>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<85.394800,0.000000,67.335400>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<85.394800,0.000000,67.818000>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<85.394800,0.000000,68.326000>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<85.394800,0.000000,68.834000>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<85.394800,0.000000,69.342000>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<85.394800,0.000000,69.824600>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<85.394800,0.000000,70.332600>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<85.394800,0.000000,70.840600>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<85.394800,0.000000,71.323200>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<84.023200,0.000000,72.694800>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<83.540600,0.000000,72.694800>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<83.032600,0.000000,72.694800>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<82.524600,0.000000,72.694800>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<82.042000,0.000000,72.694800>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<81.534000,0.000000,72.694800>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<81.026000,0.000000,72.694800>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<80.518000,0.000000,72.694800>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<80.035400,0.000000,72.694800>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<79.527400,0.000000,72.694800>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<79.019400,0.000000,72.694800>}
object{TOOLS_PCB_SMD(0.279400,1.473200,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<78.536800,0.000000,72.694800>}
object{TOOLS_PCB_SMD(1.800000,0.900000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<50.530000,0.000000,23.710000>}
object{TOOLS_PCB_SMD(1.800000,0.900000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<50.530000,0.000000,26.210000>}
object{TOOLS_PCB_SMD(1.800000,0.900000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<50.530000,0.000000,27.960000>}
object{TOOLS_PCB_SMD(1.800000,0.900000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<50.530000,0.000000,31.210000>}
object{TOOLS_PCB_SMD(1.800000,0.900000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<50.530000,0.000000,33.710000>}
object{TOOLS_PCB_SMD(1.800000,0.900000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<50.530000,0.000000,36.210000>}
object{TOOLS_PCB_SMD(1.800000,0.900000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<50.530000,0.000000,38.630000>}
object{TOOLS_PCB_SMD(1.800000,0.900000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<50.530000,0.000000,40.330000>}
object{TOOLS_PCB_SMD(1.800000,0.900000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<50.530000,0.000000,21.210000>}
object{TOOLS_PCB_SMD(1.800000,0.900000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<50.530000,0.000000,29.460000>}
object{TOOLS_PCB_SMD(2.000000,1.400000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<29.530000,0.000000,15.730000>}
object{TOOLS_PCB_SMD(2.000000,1.400000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<28.380000,0.000000,45.230000>}
object{TOOLS_PCB_SMD(1.800000,1.100000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<50.530000,0.000000,43.480000>}
//Pads/Vias
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<109.220000,0,38.100000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<55.245000,0,38.100000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<78.740000,0,32.385000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<89.535000,0,27.305000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<60.325000,0,30.480000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<105.410000,0,49.530000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<104.775000,0,52.705000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<92.075000,0,52.705000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<87.630000,0,49.530000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<109.855000,0,45.085000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<109.220000,0,41.910000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<51.435000,0,17.780000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<110.490000,0,26.035000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<100.965000,0,24.765000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<116.840000,0,3.810000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<101.600000,0,71.755000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<101.600000,0,64.135000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<114.300000,0,6.985000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<109.220000,0,33.655000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<107.950000,0,34.925000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<104.140000,0,31.750000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<71.120000,0,23.495000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<73.660000,0,24.765000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<57.150000,0,24.765000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<96.520000,0,24.765000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<84.455000,0,22.860000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<95.250000,0,9.525000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<76.200000,0,46.355000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<51.435000,0,5.080000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<80.645000,0,3.175000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<75.565000,0,3.175000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<72.390000,0,3.175000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<33.020000,0,18.415000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<40.005000,0,8.255000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<43.180000,0,1.905000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<109.855000,0,8.255000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<96.520000,0,20.320000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<36.830000,0,5.080000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<34.290000,0,5.080000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<87.630000,0,13.335000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<82.550000,0,35.560000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<88.265000,0,31.750000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<100.330000,0,53.975000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<103.822500,0,49.212500> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<88.900000,0,54.610000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<48.260000,0,27.305000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<56.515000,0,28.575000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<60.960000,0,35.560000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<80.010000,0,45.720000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<117.475000,0,27.940000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<100.965000,0,23.495000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<110.490000,0,22.860000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<92.075000,0,64.135000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<85.725000,0,54.610000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<69.215000,0,13.335000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<67.945000,0,18.415000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<107.950000,0,18.415000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<93.345000,0,23.495000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<108.585000,0,52.705000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<113.030000,0,17.145000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<113.045000,0,14.620000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<95.885000,0,26.670000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<99.695000,0,27.305000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<101.600000,0,20.955000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<106.045000,0,64.770000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<107.950000,0,66.675000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<59.690000,0,48.260000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<85.725000,0,3.810000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<94.615000,0,12.065000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<90.805000,0,4.445000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<94.615000,0,5.715000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<107.950000,0,10.160000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<113.665000,0,66.675000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<28.575000,0,8.890000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<29.845000,0,4.750000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<52.705000,0,36.195000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<59.055000,0,32.385000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<64.135000,0,7.620000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<99.695000,0,16.510000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<52.705000,0,25.400000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<53.340000,0,15.875000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<64.135000,0,6.350000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<78.740000,0,6.350000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<45.720000,0,3.810000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<34.290000,0,8.890000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<63.500000,0,2.540000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<47.625000,0,10.160000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<36.830000,0,10.160000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<48.895000,0,8.890000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<81.280000,0,68.580000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<118.110000,0,15.240000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<82.550000,0,69.850000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<118.110000,0,25.400000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<45.720000,0,8.890000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<67.945000,0,4.445000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<71.120000,0,4.445000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<93.980000,0,20.955000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<105.410000,0,3.810000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<67.310000,0,31.115000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<67.310000,0,33.020000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<67.310000,0,34.925000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<66.040000,0,35.560000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<88.900000,0,16.510000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<85.090000,0,19.050000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<85.725000,0,20.955000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<106.045000,0,5.080000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<122.555000,0,9.525000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<91.440000,0,20.320000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<90.170000,0,19.685000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<73.660000,0,-2.540000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<116.205000,0,10.795000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<104.775000,0,5.715000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<102.235000,0,5.715000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<111.125000,0,12.065000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<111.760000,0,16.510000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<83.820000,0,19.050000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<74.930000,0,20.955000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<60.325000,0,26.035000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<66.040000,0,38.100000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<44.450000,0,41.910000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<53.975000,0,19.685000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<50.800000,0,19.685000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<59.690000,0,19.050000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<83.820000,0,17.780000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<73.660000,0,20.955000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<60.325000,0,28.575000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<81.280000,0,18.415000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<81.280000,0,19.685000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<81.280000,0,20.955000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<81.280000,0,22.225000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<81.280000,0,23.495000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<81.280000,0,24.765000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<72.390000,0,16.510000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<73.660000,0,13.970000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<74.930000,0,12.065000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<76.200000,0,10.160000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<91.440000,0,15.875000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<90.805000,0,17.145000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<53.340000,0,26.670000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<60.325000,0,16.510000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<64.135000,0,10.160000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<96.520000,0,17.145000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<67.310000,0,36.830000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<55.880000,0,39.370000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<51.435000,0,41.910000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<74.295000,0,22.860000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<88.900000,0,62.865000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<81.280000,0,57.785000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<88.900000,0,61.595000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<82.550000,0,57.785000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<88.900000,0,60.325000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<83.820000,0,57.785000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<88.900000,0,59.055000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<85.090000,0,57.785000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<88.900000,0,57.785000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<86.360000,0,57.785000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<102.870000,0,31.115000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<107.950000,0,60.960000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<106.680000,0,60.960000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<101.600000,0,31.115000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<100.330000,0,33.020000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<102.235000,0,49.530000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<100.330000,0,34.290000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<100.965000,0,49.530000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<100.330000,0,35.560000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<99.695000,0,49.530000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<97.155000,0,46.355000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<96.520000,0,32.385000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<97.790000,0,48.895000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<98.425000,0,27.305000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<99.060000,0,37.465000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<97.155000,0,26.670000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<109.855000,0,49.530000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<98.425000,0,26.035000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<94.615000,0,55.245000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<95.885000,0,34.290000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<93.345000,0,31.750000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<91.440000,0,27.940000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<91.440000,0,34.925000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<91.440000,0,39.370000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<93.980000,0,33.020000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<90.170000,0,32.385000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<86.995000,0,31.750000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<80.645000,0,32.385000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<85.725000,0,31.115000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<80.010000,0,31.115000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<85.090000,0,29.845000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<80.010000,0,29.845000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<80.645000,0,28.575000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<85.090000,0,28.575000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<81.280000,0,27.305000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<85.725000,0,25.400000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<81.915000,0,26.035000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<89.535000,0,26.035000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<83.185000,0,25.400000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<90.805000,0,24.765000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<96.520000,0,5.080000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<96.520000,0,-1.270000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<66.675000,0,1.905000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<96.520000,0,10.795000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<45.720000,0,33.655000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<52.705000,0,34.925000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<64.135000,0,5.080000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<78.740000,0,5.080000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<57.785000,0,13.970000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<55.245000,0,13.335000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<108.585000,0,6.985000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<98.425000,0,19.685000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<53.975000,0,24.765000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<60.325000,0,15.240000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<64.135000,0,8.890000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<98.425000,0,16.510000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<67.945000,0,1.905000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<95.250000,0,-1.270000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<97.790000,0,6.985000> texture{col_thl}}
object{TOOLS_PCB_VIA(1.108000,0.600000,1,16,1,0) translate<97.790000,0,11.430000> texture{col_thl}}
#end
#if(pcb_wires=on)
union{
//Signals
