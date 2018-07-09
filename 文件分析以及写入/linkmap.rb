#!/usr/bin/env ruby
require 'linkmap_ios'
require 'json'

def Analysis(num)
puts "开始分析#{num}"
parser = LinkmapIos::LinkmapParser.new("/Users/chengguozhi/Desktop/download/" + num + "/.txt")
result = parser.hash
puts "分析#{num}完毕"
write(num, result)
end

def write(num, result)
puts "开始写入#{num}.json"
f=File.new(File.join("/Users/chengguozhi/Desktop/download/" + num + ".json"),"w+")
f.puts result.to_json
f.close
puts "写入#{num}.json完毕"
end

arr = ['5364', '5154', '5072', '4838', '4778']
arr.each { |item|  Analysis(item)}
