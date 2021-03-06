#!/usr/bin/env ruby

require 'optparse'
require 'pathname'
# p Pathname.new($0).realpath()
def manag(arr)
  mp = arr.length/2
  left =  Thread.new{ mergesort( arr[0...mp]) }
  right =  Thread.new{ mergesort(arr[mp...arr.length]) }
  [left,right].each do |thr|
    thr.join

  end
  merge(left[:output], right[:output])

end
def mergesort(arr)
  if (arr.length < 2)
    return arr
  end
  mp=arr.length/2
  left = mergesort(arr[0...mp])
  right = mergesort(arr[mp...arr.length])

  Thread.current[:output] = merge(left, right)


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
arr=ARGV

sortedarr=manag(arr.to_a)
system( "echo #{sortedarr.join(' ')}" )

# options = {}
# OptionParser.new do |parser|
#   parser.on("-r", "--require LIBRARY",
#             "Require the LIBRARY before executing your script") do |lib|
#     puts "You required #{lib}!"
#   end
# end.parse!

# arr=[]
# ARGV[0].to_i.times{|x| arr.push(rand(ARGV[0].to_i))}
# p manag(arr)
