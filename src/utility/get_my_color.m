% function my_color = get_my_color();
% my_color.seq = {blue_2016, green_2016, yellow_2016, red_2016};

% Copyright: Shaoying Lu and Yingxiao Wang 2011
function my_color = get_my_color()
result = load('my_hsv.mat');
my_color.colormap.hsv = result.my_hsv;

my_color.gray = [0.8 0.8 0.8];
my_color.dark_red = [216 41 0]/255;
my_color.dark_blue = [20 43 140]/255;
my_color.light_pink = [255 153 200]/255;
my_color.light_blue = [185 212 244]/255;
my_color.light_purple = [150 180 255]/255; 
my_color.dark_green = [0 153 0]/255;
my_color.tan_pink = [236 214 214]/255;

blue_2016 = [0 113 188]/255;
green_2016 = [118 171 47]/255;
yellow_2016 = [222 125 0]/255;
red_2016 = [161 19 46]/255;
my_color.seq = {my_color.dark_blue, blue_2016, green_2016, my_color.dark_green, yellow_2016, red_2016};
return;