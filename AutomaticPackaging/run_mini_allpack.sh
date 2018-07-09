#!/bin/bash

#打包方法两个参数 第一个工程文件路径 第二个说明关键字
pack() {
echo -------------------- $2开始打包--------------------
project_path=$1
project_name="CenterConsole"
exportOptionsPlistPath="/Users/admin/Desktop/AutomaticPackaging/in_house/exportOptions.plist"
#打包模式 Debug/Release
development_mode=Release
#build文件夹路径
build_path=${project_path}/build
#导出.ipa文件所在路径
exportFilePath=${project_path}/ipa/${development_mode}
echo 开始清理$2工程
echo ${project_path}/${project_name}.xcodeproj
xcodebuild clean -project ${project_path}/${project_name}.xcodeproj -configuration ${CONFIGURATION} -alltargets -quiet  || exit
echo 清理完成
echo 开始编译$2工程
xcodebuild archive -project ${project_path}/${project_name}.xcodeproj -scheme ${project_name} -configuration ${development_mode} -archivePath ${build_path}/${project_name}.xcarchive -quiet  || exit
echo 编译完成
echo 开始打$2包
xcodebuild -exportArchive -archivePath ${build_path}/${project_name}.xcarchive -configuration ${development_mode} -exportPath ${exportFilePath} -exportOptionsPlist ${exportOptionsPlistPath} -quiet || exit
if [ -e $exportFilePath/$project_name.ipa ]; then
echo $2ipa文件已导出
open $exportFilePath
else
echo 创建$2ipa文件失败
fi
echo -------------------- $2打包完成 --------------------
}





#四个参数, 第一个mini_copy路径, 第二个新文件路径, 第三个素材路径, 第四个用于说明的关键字
copyAndRep(){
echo 删除$4文件夹
rm -rf $2
echo 创建$4文件夹
mkdir -p $2
echo 正在递归替换$4工程文件
cp -fr $1/* "$2/"
echo 替换icon_log_logo.png
cp -f $3/icon_log_logo.png $2/CenterConsole/images/icon_log_logo.png
echo 替换$4plist文件
cp -f $3/CenterConsole-Info.plist $2/CenterConsole/CenterConsole-Info.plist
echo 替换$4AppIcon.appiconset文件夹下的内容
cp -f $3/LaunchImage.launchimage/* $2/CenterConsole/Images.xcassets/LaunchImage.launchimage/
echo $4工程生成成功

打包
pack $2 $4


#cp -f $3/AppIcon.appiconset/* $2/CenterConsole/Images.xcassets/AppIcon.appiconset/
#echo 替换$4LaunchImage.launchimage文件夹下的内容
#echo 替换iphone_5.png
#cp -f $3/iphone_5.png $2/CenterConsole/login/iphone_5.png
#echo 替换iphone_6.png
#cp -f $3/iphone_6.png $2/CenterConsole/login/iphone_6.png


}


#echo -------------------- 开始生成北移联创工程文件 --------------------
#copyAndRep /Users/admin/Desktop/svn/MIOT-17-APP/01_ABOX/02_Mini/01_SOURCE/iOS/Mini_New_copy /Users/admin/Desktop/svn/MIOT-17-APP/01_ABOX/02_Mini/01_SOURCE/iOS/BeiYiLianChuang /Users/admin/Desktop/AutomaticPackaging/个性化素材/北移联创 北移联创
#echo -------------------- 开始生成志康家工程文件 --------------------
#copyAndRep /Users/admin/Desktop/svn/MIOT-17-APP/01_ABOX/02_Mini/01_SOURCE/iOS/Mini_New_copy /Users/admin/Desktop/svn/MIOT-17-APP/01_ABOX/02_Mini/01_SOURCE/iOS/ZhiKangJia /Users/admin/Desktop/AutomaticPackaging/个性化素材/智康家 智康家
echo -------------------- 开始生成扬子工程文件 --------------------
copyAndRep /Users/admin/Desktop/svn/MIOT-17-APP/01_ABOX/02_Mini/01_SOURCE/iOS/Mini_New_copy /Users/admin/Desktop/svn/MIOT-17-APP/01_ABOX/02_Mini/01_SOURCE/iOS/YangZi /Users/admin/Desktop/AutomaticPackaging/个性化素材/扬子 扬子
#echo -------------------- 开始生成施乐工程文件 --------------------
#copyAndRep /Users/admin/Desktop/svn/MIOT-17-APP/01_ABOX/02_Mini/01_SOURCE/iOS/Mini_New_copy /Users/admin/Desktop/svn/MIOT-17-APP/01_ABOX/02_Mini/01_SOURCE/iOS/ShiLeZhiNeng /Users/admin/Desktop/AutomaticPackaging/个性化素材/施乐 施乐
#echo -------------------- 开始生成志高工程文件 --------------------
#copyAndRep /Users/admin/Desktop/svn/MIOT-17-APP/01_ABOX/02_Mini/01_SOURCE/iOS/Mini_New_copy /Users/admin/Desktop/svn/MIOT-17-APP/01_ABOX/02_Mini/01_SOURCE/iOS/ZhiGao /Users/admin/Desktop/AutomaticPackaging/个性化素材/志高 志高
#echo -------------------- 开始生成现代工程文件 --------------------
#copyAndRep /Users/admin/Desktop/svn/MIOT-17-APP/01_ABOX/02_Mini/01_SOURCE/iOS/Mini_New_copy /Users/admin/Desktop/svn/MIOT-17-APP/01_ABOX/02_Mini/01_SOURCE/iOS/XianDai /Users/admin/Desktop/AutomaticPackaging/个性化素材/现代 现代
#echo -------------------- 开始生成卓豪工程文件 --------------------
#copyAndRep /Users/admin/Desktop/svn/MIOT-17-APP/01_ABOX/02_Mini/01_SOURCE/iOS/Mini_New_copy /Users/admin/Desktop/svn/MIOT-17-APP/01_ABOX/02_Mini/01_SOURCE/iOS/ZhuoHao /Users/admin/Desktop/AutomaticPackaging/个性化素材/卓豪 卓豪

