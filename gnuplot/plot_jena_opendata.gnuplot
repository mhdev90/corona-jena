load "template.gnuplot"

set datafile separator ','
set output '../plot_jena_opendata.png'

stats "<awk -F ',' '{print $1}' ../data/cases_jena_opendata.csv" using 1 nooutput
set xrange [ STATS_min - 86400 : STATS_max + 86400 ]

stats "<awk -F ',' '{print $2}' ../data/cases_jena_opendata.csv" using 1 nooutput
set yrange [ 0 : int(4.0/3.0*STATS_max) ]

set xdata time
set timefmt '%s'
set format x '%d.%m'

unset xlabel
unset ylabel

set key at graph 0.02, 0.98 left top invert spacing 1.5 box ls 3

# remove latest update
update_str = ""

plot \
  1/0 lc rgb '#f2f2f2' title update_str, \
  '../data/cases_jena_opendata.csv' using 1:($2-$3-$4) with linespoints ls 1 lc rgb '#133370' title 'aktive Fälle', \
  '../data/cases_jena_opendata.csv' using 1:2 with linespoints ls 1 lc rgb '#C4262E' title 'bestätigte Fälle'
