# Conky, a system monitor, based on torsmo
#
# Any original torsmo code is licensed under the BSD license
#
# All code written since the fork of torsmo is licensed under the GPL
#
# Please see COPYING for details
#
# Copyright (c) 2004, Hannu Saransaari and Lauri Hakkarainen
# Copyright (c) 2005-2010 Brenden Matthews, Philip Kovacs, et. al. (see AUTHORS)
# All rights reserved.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

alignment top_right
background true
border_width 5
cpu_avg_samples 2
default_color green
default_outline_color white
default_shade_color white
draw_borders no
draw_graph_borders yes
draw_outline no
draw_shades no
use_xft yes
xftfont Bitstream Vera Sans Mono:size=10
gap_x 10
### Primary (bottom) monitor
#gap_y 110
### Secondary (top) monitor
gap_y -1044
net_avg_samples 2
double_buffer yes
out_to_console no
own_window yes
own_window_type normal
own_window_transparent yes
own_window_argb_visual yes
own_window_color 000000
own_window_argb_value 0
own_window_hints undecorated,below,sticky,skip_taskbar,skip_pager
stippled_borders 0
update_interval 03.0
uppercase no
use_spacer none
show_graph_scale no
show_graph_range no

### My additions
minimum_size 330 5
default_bar_size 0 6
#default_graph_size 32 285

TEXT
${color white}${font Vera Sans Mono:bold:size=12}System Properties${font}
$hr
${color}Hostname:${goto 120}$nodename_short
${color}IP Address:${goto 120}${execi 65535 /sbin/ifconfig enp2s0f0 | grep -E "^\s*inet\s+.*$" | sed 's/^\s*//' | cut -d' ' -f2}
Public IP:${goto 120}${execi 65535 wget http://ipinfo.io/ip -qO -}
${color}MAC Address:${goto 120}${execi 65536 /sbin/ifconfig enp2s0f0 | grep -E "^\s*ether\s+.*$" | sed 's/^\s*//' | cut -d' ' -f2}
#System:${goto 120}$sysname
System:${goto 120}${execi 65535 cat /etc/os-release | grep -E "^NAME" | cut -d'"' -f 2}
Version:${goto 120}${execi 65535 cat /etc/debian_version} (${execi 65535 cat /etc/lsb-release | grep CODENAME | cut -d'=' -f 2})
Kernel:${goto 120}$kernel
Uptime:${goto 120}$uptime
Temperature:${goto 120}${acpitemp} C
${color white}Hardware $hr
${color}MB Vendor:${goto 120}${exec echo $(cat /sys/devices/virtual/dmi/id/board_vendor)}
${color}MB Name:${goto 120}${exec echo $(cat /sys/devices/virtual/dmi/id/board_name)}
${color}BIOS Vendor:${goto 120}${exec echo $(cat /sys/devices/virtual/dmi/id/bios_vendor)}
${color}BIOS Date:${goto 120}${exec echo $(cat /sys/devices/virtual/dmi/id/bios_date)}
${color white}CPU $hr
${color}Type:${goto 120}${exec echo $(cat /proc/cpuinfo | grep -i 'model name' | awk '{print $4" "$5" "$6}' | uniq | sed -r 's/\([a-zA-Z0-9]+\)//ig')}
Clock Speed:${goto 120}${freq} MHz
Core Temperatures:
${exec sensors | grep -iE "^Core\s+[0-9]+" | awk '{print "   "$2" "$3}'}
CPU Utilisation:
${goto 25}CPU 0:${goto 100}${cpu cpu0}%${goto 140}${cpubar cpu0}
#${alignr}${cpugraph cpu0 32,313 d3d3d3 d3d3d3}
${goto 25}CPU 1:${goto 100}${cpu cpu1}%${goto 140}${cpubar cpu1}
#${alignr}${cpugraph cpu1 32,313 d3d3d3 d3d3d3}
${goto 25}CPU 2:${goto 100}${cpu cpu2}%${goto 140}${cpubar cpu2}
#${alignr}${cpugraph cpu2 32,313 d3d3d3 d3d3d3}
${goto 25}CPU 3:${goto 100}${cpu cpu3}%${goto 140}${cpubar cpu3}
#${alignr}${cpugraph cpu3 32,313 d3d3d3 d3d3d3}
${goto 25}CPU 4:${goto 100}${cpu cpu4}%${goto 140}${cpubar cpu4}
#${alignr}${cpugraph cpu4 32,313 d3d3d3 d3d3d3}
${goto 25}CPU 5:${goto 100}${cpu cpu5}%${goto 140}${cpubar cpu5}
#${alignr}${cpugraph cpu5 32,313 d3d3d3 d3d3d3}
${color white}Memory Utilisation $hr
${color}RAM:
${goto 25}Total:${goto 100}$memmax
${goto 25}Usage:${goto 100}$mem ($memperc%)${goto 225}${membar}
Swap:
${goto 25}Total:${goto 100}$swapmax
${goto 25}Usage:${goto 100}$swap ($swapperc%)${goto 225}${swapbar}
${color white}File Systems $hr
${color}Name${goto 75}Used / Size
boot:${goto 75}${fs_used /boot/efi} / ${fs_size /boot/efi}${goto 225}${fs_bar /boot/efi}
root:${goto 75}${fs_used /root} / ${fs_size /root}${goto 225}${fs_bar /root}
home:${goto 75}${fs_used /home} / ${fs_size /home}${goto 225}${fs_bar /home}
#data01:${goto 75}${fs_free /media/data01} / ${fs_size /media/data01}${goto 225}${fs_bar /media/data01}
#data02:${goto 75}${fs_free /media/data02} / ${fs_size /media/data02}${goto 225}${fs_bar /media/data02}
${color white}Networking $hr
${color}Speed:${goto 75}Up: ${upspeedf eno2} KiB/s${goto 200}Down: ${downspeedf eno2} KiB/s
Data:${goto 75}Up: ${exec echo $(cat /proc/net/dev | grep -i eno2 | awk '{print $10}') / 1024 / 1024 | bc} MB${goto 200}Down: ${exec echo $(cat /proc/net/dev | grep -i eno2 | awk '{print $2}') / 1024 / 1024 | bc} MB
${color white}Processes $hr
${color}Processes:${goto 100}$processes${goto 140}Active: $running_processes
Threads:${goto 100}$threads${goto 140}Active: $running_threads

${color white}Name${goto 150}CPU%${goto 210}MEM%${goto 260}USER${color}
${top name 1}${goto 140}${top cpu 1}${goto 195}${top mem 1}${goto 260}${top user 1}
${top name 2}${goto 140}${top cpu 2}${goto 195}${top mem 2}${goto 260}${top user 2}
${top name 3}${goto 140}${top cpu 3}${goto 195}${top mem 3}${goto 260}${top user 3}
${top name 4}${goto 140}${top cpu 4}${goto 195}${top mem 4}${goto 260}${top user 4}
${top name 5}${goto 140}${top cpu 5}${goto 195}${top mem 5}${goto 260}${top user 5}
${top name 6}${goto 140}${top cpu 6}${goto 195}${top mem 6}${goto 260}${top user 6}
${top name 7}${goto 140}${top cpu 7}${goto 195}${top mem 7}${goto 260}${top user 7}
${top name 8}${goto 140}${top cpu 8}${goto 195}${top mem 8}${goto 260}${top user 8}
${color white}$hr
