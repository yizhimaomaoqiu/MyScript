#! /bin/bash
# created by Ficow Shen

echo ‘-------------------- 开始运行打包脚本 --------------------‘
echo ‘请将工程文件夹拖入下方并删除空格:‘
read project_path

#工程名
echo ‘请输入工程名,一般就是上边的最后一个单词,直接复制就行:‘
read project_name

echo ‘选择打包方式,请将对应文件夹下的plist文件拖入下方:‘
read exportOptionsPlistPath

#打包模式 Debug/Release
development_mode=Release

#build文件夹路径
build_path=${project_path}/build

#导出.ipa文件所在路径
exportFilePath=${project_path}/ipa/${development_mode}


echo ‘-------------------- 正在 清理工程 --------------------‘
echo ${project_path}/${project_name}.xcodeproj
xcodebuild clean -project ${project_path}/${project_name}.xcodeproj -configuration ${CONFIGURATION} -alltargets -quiet  || exit
echo ‘-------------------- 清理完成 --------------------‘



echo ‘-------------------- 正在 编译工程 --------------------‘
xcodebuild archive -project ${project_path}/${project_name}.xcodeproj -scheme ${project_name} -configuration ${development_mode} -archivePath ${build_path}/${project_name}.xcarchive -quiet  || exit
echo ‘-------------------- 编译完成 --------------------‘



echo ‘-------------------- 正在 打包 --------------------‘
xcodebuild -exportArchive -archivePath ${build_path}/${project_name}.xcarchive -configuration ${development_mode} -exportPath ${exportFilePath} -exportOptionsPlist ${exportOptionsPlistPath} -quiet || exit

if [ -e $exportFilePath/$project_name.ipa ]; then
echo "-------------------- .ipa文件已导出 --------------------"
open $exportFilePath
else
echo "-------------------- 创建.ipa文件失败 --------------------"
fi
echo ‘-------------------- 打包完成 --------------------‘
echo ‘-------------------- 打包脚本结束运行 --------------------‘

