set terminal pngcairo enhanced transparent truecolor font "OpenSans,16" size 800, 400 dl 2.0
set encoding utf8
set minussign

set output '../plot_jena_opendata_pie.png'

# setup
unset xlabel
unset ylabel
unset key
unset tics
unset border

# get latest sum of infected
stats "<awk -F, 'END{print $1,$2,$3,$4,$5}' ../data/cases_jena_opendata.csv" u 2 prefix "A" nooutput

# get latest number of recovered
stats "<awk -F, 'END{print $1,$2,$3,$4,$5}' ../data/cases_jena_opendata.csv" u 3 prefix "B" nooutput

# get latest number of deceased
stats "<awk -F, 'END{print $1,$2,$3,$4,$5}' ../data/cases_jena_opendata.csv" u 4 prefix "C" nooutput

# get latest of hospitalized
stats "<awk -F, 'END{print $1,$2,$3,$4,$5,$6}' ../data/cases_jena_opendata.csv | tail -n 1" u 5 prefix "E" nooutput

# get latest of severe
stats "<awk -F, 'END{print $1,$2,$3,$4,$5,$6}' ../data/cases_jena_opendata.csv | tail -n 1" u 6 prefix "F" nooutput

angle(x)=x*360/A_max

centerX=-0.15
centerY=0
radius=0.8

yposmin = 0.0
yposmax = 0.95*radius
xpos = 1.35*radius
ypos(i) = yposmax - i*(yposmax-yposmin)/(4)

set style fill solid 1
set size ratio -1
set xrange [-1.45*radius:3.6*radius]
set yrange [-radius:radius]

pos = 90

filter_inf(x, y)= (y >= 0) ? (x/y) : 0

plot \
  "<echo 0" u (xpos):(ypos(0.25)):(sprintf("%i bestätigte Fälle in Jena", A_max)) w labels left offset 2.5, 0, \
  "<echo 0" u (centerX):(centerY):(radius):(pos):(pos=pos+angle(A_max-B_max-C_max)) w circle fc rgb "#133370", \
  "<echo 0" u (xpos):(ypos(1.75)) w p pt 5 ps 4 lc rgb "#133370", \
  "<echo 0" u (xpos):(ypos(1.75)):(sprintf("%i aktive Fälle (%.1f%%), davon", A_max - B_max - C_max, 100*(A_max-B_max-C_max)/A_max)) w labels left offset 2.5, 0, \
  "<echo 0" u (centerX):(centerY):(radius):(pos):(pos=pos+angle(B_max)) w circle fc rgb "#5B8F22", \
  "<echo 0" u (xpos):(ypos(5.00)) w p pt 5 ps 4 lc rgb "#5B8F22", \
  "<echo 0" u (xpos):(ypos(5.00)):(sprintf("%i Genesene (%.1f%%)", B_max, 100*B_max/A_max)) w labels left offset 2.5, 0, \
  "<echo 0" u (centerX):(centerY):(radius):(pos):(pos=pos+angle(C_max)) w circle fc rgb "#000000", \
  "<echo 0" u (xpos):(ypos(6.00)) w p pt 5 ps 4 lc rgb "#000000", \
  "<echo 0" u (xpos):(ypos(6.00)):(sprintf("%i Verstorbene (%.1f%%)", C_max, 100*C_max/A_max)) w labels left offset 2.5, 0, \
  "<echo 0" u (xpos + 1.5):(ypos(2.75)):(sprintf("stationäre Fälle: %i (%.1f\%)", E_max, 100*filter_inf(E_max, A_max - B_max - C_max))) w labels right offset 2.5, 0, \
  "<echo 0" u (xpos + 1.5):(ypos(3.75)):(sprintf("schwere Verläufe: %i (%.1f\%)", F_max, 100*filter_inf(F_max, A_max - B_max - C_max))) w labels right offset 2.5, 0
