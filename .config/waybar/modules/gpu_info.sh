#/bin/sh

OP=$1

if [ $OP == "-u" ];
then
  UTIL=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
  echo $UTIL%
  else if [ $OP == "-t" ];
  then
  TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)
  echo $TEMP°C
  fi
fi
