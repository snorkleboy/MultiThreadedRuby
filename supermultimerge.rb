#!/usr/bin/env ruby

require 'optparse'
require 'pathname'
# p Pathname.new($0).realpath()
def manag(arr)
  p arr
  Thread.current[:arr]=arr
  mp = arr.length/2
  left =  Thread.new{ mergesort( arr[0...mp]) }
  right =  Thread.new{ mergesort(arr[mp...arr.length]) }

  [left,right].each do |thr|
    thr.join
    p thr
    p thr[:output]
  end
  p merge(left[:output], right[:output])

  puts "poop"
end
def mergesort(arr)
  if (arr.length < 2)
    Thread.current[:output]=arr
    return arr
  end
  mp=arr.length/2
  left =Thread.new{  mergesort(arr[0...mp]) }
  right =Thread.new{  mergesort(arr[mp...arr.length]) }
  p "left thread = " + left.to_s
  p "left thread = " + right.to_s
  p "current thread = " + Thread.current.to_s
  left.join
  right.join
  Thread.current[:output] = merge(left[:output], right[:output])


end
def merge(left, right)

  ans=[]
  until (left.empty? || right.empty?)
    if (right.first < left.first)
      ans.push(right.shift())
    else
      ans.push(left.shift())
    end
  end

  ans + left + right
end


options = {}
OptionParser.new do |parser|
  parser.on("-r", "--require LIBRARY",
            "Require the LIBRARY before executing your script") do |lib|
    puts "You required #{lib}!"
  end
end.parse!
arr=[]
ARGV[0].to_i.times{|x| arr.push(rand(ARGV[0].to_i))}
p mergesort(arr)
