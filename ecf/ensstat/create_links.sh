#!/bin/bash

target=jaigefs_ens_debias.ecf
for i in $(seq -w 0 6 384); do
  ln -s $target jaigefs_ens_debias_f${i}.ecf
done

