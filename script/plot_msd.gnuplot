set terminal png size 1000,500
set output 'data/figure/msd_MyTEMP.png'

set title 'MSD of protein (T = MyTEMP)'
set xlabel 't (fs)'
set ylabel 'msd'
plot "/home/common/studtscm06/peptide/data/msd/temp_MyTEMP.msd" u 1:2 w l