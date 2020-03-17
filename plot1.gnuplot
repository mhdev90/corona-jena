set terminal pngcairo enhanced font "Arial,12" fontscale 1.0 size 800, 600 background rgb '#f2f2f2' dl 2.0
set encoding utf8
set minussign

set output 'plot1.png'

# margins
set lmargin 10.25
set rmargin 2.80
set tmargin 0.75
set bmargin 3.75

# colors and plot style
set style line  1 lc rgb '#0000FF' lt 1 lw 1 pt 7 ps 1.50 

# stats for y
stats "<awk '{ print $1 }' ./cases_jena.dat" using 1 nooutput
set xrange [ STATS_min - 86400 : STATS_max + 86400 ]

# stats for y
stats "<awk '{ print $2 }' ./cases_jena.dat" using 1 nooutput
set yrange [ 0 : int(4.0/3.0*STATS_max) ]

# x-axis setup
unset xlabel
set xdata time
set timefmt "%s"
set format x "%d.%m."
set xtics out nomirror
set mxtics 1

# y-axis setup
set ylabel 'Bestätigte Fälle in Jena'
set format y '%.0f'
set ytics out nomirror
set mytics 2

# key
unset key

# latest update
update_str = "letztes Update: " . system("date +%d.%m.%Y\\ %H\\:%M")
set label 1 at graph 0.98, 0.95 update_str right textcolor ls 0 font ",12"

# data
plot  \
  './cases_jena.dat' using 1:2 with linespoints ls 1 title "Bestätigte Fälle"