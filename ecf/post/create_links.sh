#!/bin/bash

target=jaigefs_post.ecf
for i in $(seq -w 0 6 384); do
  ln -s $target jaigefs_post_f${i}.ecf
done

