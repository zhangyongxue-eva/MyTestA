
#下面部分接收参数，并替换 local.properties 中对应的值
echo "第一个参数: $1"
echo "第二个参数：$2"
echo "第三个参数：$3"
echo "第四个参数：$4"

PROJECT_DIR=$(cd "$(dirname "$0")"; pwd)
LOCAL_PATH=${PROJECT_DIR}/local.properties

#测试当前路径
dir=`ls $PROJECT_DIR ` #定义遍历的目录
for i in $dir
do
    echo $i
done

echo "PROJECT_DIR：$PROJECT_DIR"
echo "LOCAL_PATH：$LOCAL_PATH"
#



sed -i '' "s#^key_applicationid=.*#key_applicationid=${1}#g" $LOCAL_PATH
sed -i '' "s#^key_oemappname=.*#key_oemappname=${2}#g" $LOCAL_PATH
sed -i '' "s#^key_targeturl=.*#key_targeturl=${3}#g" $LOCAL_PATH
sed -i '' "s#^key_applovin=.*#key_applovin=${4}#g" $LOCAL_PATH


# Functions for customizing colors(Optional)
print_red(){
    printf "\e[1;31m$1\e[0m"
}
print_green(){
    printf "\e[1;32m$1\e[0m"
}
print_yellow(){
    printf "\e[1;33m$1\e[0m"
}
print_blue(){
    printf "\e[1;34m$1\e[0m"
}

#Enter project dir
cd $PROJECT_DIR

#Start Build Process
print_blue "\n\n\nStarting"
print_blue "\n\n\nCleaning...\n"
./gradlew clean

print_blue "\n\n\ncleanBuildCache...\n"
./gradlew cleanBuildCache

print_blue "\n\n\n build...\n"
./gradlew build

print_blue "\n\n\n assembleDebug...\n"
./gradlew assembleDebug

#Install APK on device / emulator
print_blue "installDebug...\n"
./gradlew installDebug

print_blue "\n\n\n Done Installing\n"

#Launch Main Activity
adb shell am start -n "${1}/com.test.pname.MainActivity" -a android.intent.action.MAIN -c android.intent.category.LAUNCHER

print_blue "\n\n\n Launched main activity\n"

