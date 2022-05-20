#!/usr/bin/bash

TOKEN='5324740648:AAG7UIg5l8XWCQ-XIG_TdowGy8daCKFNIs0'
CHATID='432267327'

flag=$(squeue | awk 'BEGIN{tmp=0} {if ($3=="protein") tmp=1;} END{print tmp}')
# echo $flag >> /home/common/studtscm06/peptide/test.txt
# echo $flag

if [ $flag -eq 0 ]
then
  T0=270
  T1=320
  step=10
  
  # echo $flag
  
  # echo "53" >> /home/common/studtscm06/peptide/test.txt

  for (( temp=$T0; temp <= $T1 ; temp=temp+$step ))
  do
  # python /home/common/studtscm06/peptide/python/msd.py $temp
  sed "s/MyTEMP/$temp/g" /home/common/studtscm06/peptide/script/plot_msd.gnuplot > plot_msd.gnuplot
  gnuplot plot_msd.gnuplot
  rm plot_msd.gnuplot
  curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendPhoto -F chat_id=${CHATID} -F photo="@/home/common/studtscm06/peptide/data/figure/msd_$temp.png" -F caption="msd for $temp"
  done
  
  crontab -r
fi