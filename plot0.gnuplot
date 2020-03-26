set terminal pngcairo enhanced transparent truecolor font "Linux Libertine O,16" size 800, 400 dl 2.0 
set encoding utf8
set minussign

set output 'plot0.png'

# pie chart inspired by:
# https://stackoverflow.com/questions/31896718/generation-of-pie-chart-using-gnuplot

# setup
unset xlabel
unset ylabel
unset key
unset tics
unset border

# latest update
update_str = "letztes Update: " . system("date +%d.%m.\\ %H\\:%M")

# get sum
stats "<cat ./cases_jena.dat | tail -n 1" u 2 prefix "A" nooutput

angle(x)=x*360/A_sum

centerX=0
centerY=0
radius=0.8

yposmin = 0.0
yposmax = 0.95*radius
xpos = 1.35*radius
ypos(i) = yposmax - i*(yposmax-yposmin)/(4)

set style fill solid 1
set size ratio -1              # equal scale length
set xrange [-1.75*radius:3.3*radius]  # [-1:2] leaves space for labels
set yrange [-radius:radius]    # [-1:1]

pos = 90

plot \
     "<cat ./cases_jena.dat | tail -n 1" u (xpos):(ypos(1)):(sprintf("%i bestätigte Fälle in Jena", $2)) w labels left offset 2.5, 0, \
     "<cat ./cases_jena.dat | tail -n 1" u (centerX):(centerY):(radius):(pos):(pos=pos+angle($2-$3-$4)) w circle fc rgb "#003D5F", \
     '+' u (xpos):(ypos(2)) w p pt 5 ps 4 lc rgb "#003D5F", \
     "<cat ./cases_jena.dat | tail -n 1" u (xpos):(ypos(2)):(sprintf("%i aktive Fälle (%.1f%%)", $2 - $3 - $4, 100*($2-$3-$4)/A_sum)) w labels left offset 2.5, 0, \
     "<cat ./cases_jena.dat | tail -n 1" u (centerX):(centerY):(radius):(pos):(pos=pos+angle($3)) w circle fc rgb "#006000", \
     '+' u (xpos):(ypos(3)) w p pt 5 ps 4 lc rgb "#006000", \
     "<cat ./cases_jena.dat | tail -n 1" u (xpos):(ypos(3)):(sprintf("%i Genesene (%.1f%%)", $3, 100*$3/A_sum)) w labels left offset 2.5, 0, \
     "<cat ./cases_jena.dat | tail -n 1" u (centerX):(centerY):(radius):(pos):(pos=pos+angle($4)) w circle fc rgb "#000000", \
     '+' u (xpos):(ypos(4)) w p pt 5 ps 4 lc rgb "#000000", \
     "<cat ./cases_jena.dat | tail -n 1" u (xpos):(ypos(4)):(sprintf("%i Verstorbene(r) (%.1f%%)", $4, 100*$4/A_sum)) w labels left offset 2.5, 0, \
     "<cat ./cases_jena.dat | tail -n 1" u (xpos):(ypos(6)):(update_str) w labels font ", 12" left offset 2.5, 0, \
     "<cat ./cases_jena.dat | tail -n 1" u (xpos):(ypos(7)):("Quelle: jena.de/corona") w labels font ", 12" left offset 2.5, 0
