#!/usr/bin/env ruby

require 'optparse'
require 'pathname'

def mergesort(arr)
  if (arr.length < 2)
    Thread.current[:output]=arr
    return arr
  end
  mp=arr.length/2
  left =Thread.new{  mergesort(arr[0...mp]) }
  right =Thread.new{  mergesort(arr[mp...arr.length]) }

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

arr=ARGV
sortedarr=mergesort(arr.to_a)
system( "echo #{sortedarr.join(' ')}" )
