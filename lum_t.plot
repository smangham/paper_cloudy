# set term postscript enhanced color font "Times-New-Roman,22" size 12,6
# set output "lum_t.eps"
set term pdf font "Times-New-Roman" size 8,4
set output "lum_t.pdf"
set encoding utf8

# Converts flux/m2 A @ 10 GPc to actual flux
# 1.1965e44 = 1.1965e+54 * 1e-10
c_old = 1.1965e44

# Converts flux/cm2/A @ 100 Pc to flux/cm2/A
c_area = 1.1965e42
c_c4 = c_area * 1350
c_ha = c_area * 5100
c_hb = c_area * 4861
s2d = 86400


set multiplot layout 2,1

set log x
set log y
set style fill solid

set xrange[2e39:2e47]
set xtics font ",20"
set ytics font ",20"
set yrange[0.01:1000]
set key bottom right

set lmargin at screen 0.12
set rmargin at screen 0.55
set tmargin at screen 0.98
set bmargin at screen 0.18


set label 1 'C {/*0.75 IV}' at 1e40,100 font ",24"
#set label 2 sprintf("c_{old} %.2e \n c_{c4} %.2e",c_old, c_c4) at  1e40,10
set xtics format "%.0T"
set xlabel "Log {/Symbol l}L_{/Symbol l}(1350Å) (erg s^{-1})" font ",22"
set ylabel "Delay {/Symbol t} (days)" font ",22" offset 0,0
set key font ",18" right bottom
set key invert


plot \
    '+' using 1:(10**(0.9+0.56*log10(x/1e44))):(10**(1.22+0.66*log10(x/1e44))) with filledcurves closed lc rgb "gray90" notitle, \
		"lum_t_c4_data.csv" u (10**$1):2:(10**$3):(10**$4):5:6 every ::1 w xyerrorbars pt -1 lw 2 lc "gray70" t "Peterson+05 data", \
	  "lum_t_c4_5548.csv" u (10**$1):2:(10**$3):(10**$4):5:6 every ::1 w xyerrorbars pt -1 lw 2 lc "light-pink" t "Peterson+05 NGC5548", \
		(10**(1.06+0.61*log10(x/1e44))) w l lt -1 lw 3 notitle,\
    "ngc5548_lum_t_c4_old.csv" u ($1*c_c4):($3/86400) every ::1 w p pt 1 ps 2 lc 1 lw 3 title "{/Symbol Y}_{E} (1x)", \
    "ngc5548_lum_t_c4_old.csv" u ($1*c_c4):($2/86400) every ::1 w p pt 2 ps 2 lc 1 lw 3 title "{/Symbol Y}_{R} (1x)", \
    "ngc5548_lum_t_c4_new.csv" u ($1*c_c4):($3/86400) every ::1 w p pt 1 ps 2 lc 2 lw 3 title "{/Symbol Y}_{E} (10x)", \
    "ngc5548_lum_t_c4_new.csv" u ($1*c_c4):($2/86400) every ::1 w p pt 2 ps 2 lc 2 lw 3 title "{/Symbol Y}_{R} (10x)", \
    "ngc5548_lum_t_c4_r30.csv" u ($1*c_c4):($3/86400) every ::1 w p pt 1 ps 2 lc 3 lw 3 title "{/Symbol Y}_{E} (30x)", \
    "ngc5548_lum_t_c4_r30.csv" u ($1*c_c4):($2/86400) every ::1 w p pt 2 ps 2 lc 3 lw 3 title "{/Symbol Y}_{R} (30x)"



set lmargin at screen 0.55
set tmargin at screen 0.98
set bmargin at screen 0.18
set rmargin at screen 0.98

set label 1 'H{/Symbol b}' at 1e40,100 font ",24"
#set label 2 sprintf("c_{old} %.2e \n c_{h{/Symbol b}} %.2e",c_old, c_ha) at  1e40,10
set xlabel "Log {/Symbol l}L_{/Symbol l}(5100Å) (erg s^{-1})" font ",22"
unset ylabel
set ytics format ""
plot \
'+' using 1:(10**(1.535+log10($1/1e44)*0.522)):(10**(1.583+log10($1/1e44)*0.587)) w filledcurves closed lc rgb "gray90" notitle,\
		"lum_t_hb_data.csv" u (10**$1):2:(10**$3):(10**$4):5:6 every ::1 w xyerrorbars pt -1 lw 2 lc "gray70" t "Bentz+13 data", \
		"lum_t_hb_5548.csv" u (10**$1):2:(10**$3):(10**$4):5:6 every ::1 w xyerrorbars pt -1 lw 2 lc "light-pink" t "Bentz+13 NGC5548", \
    (10**(1.559+log10(x/1e44)*0.549))   w l lt -1 lw 3 notitle, \
    "ngc5548_lum_t_hb_old.csv" u ($1*c_hb):($3/86400) every ::1 w p pt 1 ps 2 lc 1 lw 3 title "{/Symbol Y}_{E} (1x)", \
    "ngc5548_lum_t_hb_old.csv" u ($1*c_hb):($2/86400) every ::1 w p pt 2 ps 2 lc 1 lw 3 title "{/Symbol Y}_{R} (1x)", \
    "ngc5548_lum_t_hb_new.csv" u ($1*c_hb):($3/86400) every ::1 w p pt 1 ps 2 lc 2 lw 3 title "{/Symbol Y}_{E} (10x)", \
    "ngc5548_lum_t_hb_new.csv" u ($1*c_hb):($2/86400) every ::1 w p pt 2 ps 2 lc 2 lw 3 title "{/Symbol Y}_{R} (10x)", \
    "ngc5548_lum_t_hb_r30.csv" u ($1*c_hb):($3/86400) every ::1 w p pt 1 ps 2 lc 3 lw 3 title "{/Symbol Y}_{E} (30x)", \
    "ngc5548_lum_t_hb_r30.csv" u ($1*c_hb):($2/86400) every ::1 w p pt 2 ps 2 lc 3 lw 3 title "{/Symbol Y}_{R} (30x)"

unset multiplot
