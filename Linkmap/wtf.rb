#!/usr/bin/ruby
require 'singleton'
require 'cocoapods-core'
require 'json'

class FileNameCache
    include Singleton
    attr_reader :namecache
    
    def initialize
        @namecache = Hash.new
    end
    
    def addKey(key, filename)
        @namecache[key] = filename
    end
    
end


class FileSizeCache
    include Singleton
    attr_reader :sizecache
    attr_reader :keyarr
    def initialize
        @sizecache = Hash.new
        @keyarr = []
    end
    
    def addSize(key, size)
        result = @sizecache[key]
        if result
            @sizecache[key] = size + result
        else
            @sizecache[key] = size
            @keyarr << key
        end
    end
    
    def logMessage
        @keyarr.each do |tkey|
            puts "key:#{tkey} fileName:#{FileNameCache.instance.namecache[tkey]} size:#{@sizecache[tkey]}"
        end
    end
    
end


def run
    path = '/Users/chengguozhi/Desktop/pod-size/imeituan-LinkMap-normal-arm64.txt'
#    path = gets
    file_content = File.read(path)
    return unless file_content
    #文件列表
    objectfiles = false
    #段表 (暂时用不上, 用来标记这一段)
    sections = false
    #文件对应的大小和位置
    symbols = false
    
    filenamecache = FileNameCache.instance
    filesizecache = FileSizeCache.instance
    
    file_content.lines.each do |line|
        
        if line[0] == '#'
            #注释行
            if line.include?'# Object files:'
                #App的完整的目标文件列表（#Object files）
                objectfiles = true
            elsif line.include?'# Sections:'
                #App的段表
                sections = true
            elsif line.include?'# Symbols:'
                #App中具体目标文件在对应的section中的位置和大小
                symbols = true
            elsif line.include?'# Path'
                #app编译路径
                puts "app编译路径 #{line}"

            elsif line.include?'# Arch'
                #编译 结构 Arch: arm64
                puts "编译 #{line}"
            elsif line.include?'# Address'

            else
                puts "不在判断里的注释 #{line}"

            end
        else

            #非注释行
            if objectfiles == true and sections == false and symbols == false

                file_path = line.split(']').last
                file_name = file_path.split('/').last
                name_key = line.split(']').first + ']'
                filenamecache.addKey(name_key, file_name)

            elsif objectfiles == true and sections == true and symbols == false

            elsif objectfiles == true and sections == true and symbols == true
                begin
                    str1 = line.split('] ').first
                    str2 = str1.split('[').last
                    addressandsize = str1.split('[').first
                    tsize = addressandsize.split(' ').last
                rescue
                    next
                else

                    size_key = '[' + str2 + ']'
                    begin
                        file_size = tsize.to_i(16)
                    rescue
                        next
                    else
                        filesizecache.addSize(size_key, file_size)
                    end
                ensure

                end
            else

            end

        end

    end
    
    filesizecache.logMessage
    
end

run

