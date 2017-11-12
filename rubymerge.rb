#!/usr/bin/env ruby

ARGV[0].to_i.times{|x| arr.push(rand(ARGV[0].to_i))}
p mergesort(arr)
