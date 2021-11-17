#!/bin/sh

string="hi!"

# $string is not null so nothing will be echoed
# && means if [ -z $string ] is TRUE ($? is zero) then $string is echoed
[ -z $string ] && echo $string

# $string is not null so $string is echoed
# || means if [ -z $string ] is FALSE ($? is non-zero) then $string is echoed
[ -z $string ] || echo $string

# $string is not null so $string is echoed
# ! means negation
# the ! makes the test true so $string is echoed
[ ! -z $string ] && echo $string
