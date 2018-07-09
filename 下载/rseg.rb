$KCODE = 'UTF8'

require 'singleton'
require 'net/http'
require 'open-uri'

def download(num)
  
  puts "开始下载#{num}"
  begin
    File.open('/Users/chengguozhi/Desktop/download/' + num + '.zip', 'wb') {|f| f.write(open('http:/') {|f1| f1.read})}
    puts "#{num}下载完成"
  rescue
    puts "#{num}无法下载"
  end
end

#arr = ['6434', '6386', '6281', '6266', '6171', '6057', '5643', '5396', '5364', '5154', '5072', '4838', '4778', '687', '308', '155', '146', '139', '136', '129', '126', '121', '118', '116']
arr = ['687', '308', '155', '146', '139', '136', '129', '126', '121', '118', '116']
arr.each { |item|  download(item)}

