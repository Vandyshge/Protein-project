#!/usr/bin/bash

TOKEN='5324740648:AAG7UIg5l8XWCQ-XIG_TdowGy8daCKFNIs0'
CHATID='432267327'

squeue > tmp.txt
flag=$(awk 'BEGIN{tmp=0} {if ($3="protein") {tmp=1;}} END{print tmp}' tmp.txt)
echo $flag
rm tmp.txt
if [ flag -eq 1 ]
then
  # sed "s/MyTEMP/$temp/g" /home/common/studtscm06/peptide/script/plot_msd.gnuplot > plot_msd.gnuplot
  # gnuplot plot_msd.gnuplot
  # rm plot_msd.gnuplot
  python /home/common/studtscm06/peptide/python/msd.py 270
  curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHATID} -d text="Finished task for T = 270"
  curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendPhoto -F chat_id=${CHATID} -F photo="@/home/common/studtscm06/peptide/figure/msd_270.png"
  crontab -r
fi