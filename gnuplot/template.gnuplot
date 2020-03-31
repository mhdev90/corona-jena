set terminal pngcairo enhanced transparent truecolor font "OpenSans,16" size 800, 600 dl 2.0 
set encoding utf8
set minussign

set fit quiet logfile '/dev/null'
set fit errorvariables

# margins
set lmargin 12.25
set rmargin 2.80
set tmargin 0.75
set bmargin 3.75

# colors and plot style
set style line  1 lc rgb '#0000FF' lt 1 lw 1 pt 7 ps 1.50 dt "."
set style line  2 lc rgb '#000000' lt 1 lw 1 pt 7 ps 1.50 dt "."
set style line  3 lc rgb '#000000' lt 1 lw 1 pt 7 ps 1.50
set style line  4 lc rgb '#005000' lt 1 lw 1 pt 7 ps 1.50 dt "."
set style line  5 lc rgb '#000000' lt 1 lw 1 pt 7 ps 1.50 dt "."
set style line  6 lc rgb '#000080' lt 1 lw 1 pt 7 ps 1.50 dt "."
set style line  10 lc rgb '#000000' lw 1 lt 1 dt "  .  "
set style line  11 lc rgb '#aaaaaa' lw 1 lt 1 dt "  .  "

# grid
set grid xtics mxtics ls 10, ls 11
set grid ytics mytics ls 10, ls 11

# misc
set samples 30
set style increment default
set style fill transparent solid 0.20 border

# axes
set xtics out nomirror rotate by 45 offset -2.5, -1.5
set mxtics 2

set format y '%6.0f'
set ytics out nomirror
set mytics 2

# latest update
update_str = "{/*0.75 letztes Update: " . system("date +%d.%m.,\\ %H\\:%M") . " Uhr}"
