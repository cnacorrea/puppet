#!/bin/bash

# generates a random alphanumeric string, 16 characters in length
randomString32() {
	index=0
	str=""
	for i in {a..z}; do arr[index]=$i; index=`expr ${index} + 1`; done
	for i in {A..Z}; do arr[index]=$i; index=`expr ${index} + 1`; done
	for i in {0..9}; do arr[index]=$i; index=`expr ${index} + 1`; done
	for i in {1..16}; do str="$str${arr[$RANDOM%$index]}"; done
	echo $str
}

randomString32
