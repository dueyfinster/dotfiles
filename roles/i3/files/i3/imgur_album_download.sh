#!/bin/bash
curl "$1" \
  | grep 'thumb-title' \
  | sed 's/^.*data-src="//' \
  | sed 's/" data-index=".*>$//' \
  | sed 's/s././' \
  | xargs -l1 wget -q -nc