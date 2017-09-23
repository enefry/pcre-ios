
pushd .

mkdir build-iOS
cd build-iOS
mkdir iphone_simulator
mkdir iphone_os

cd iphone_simulator
cmake \
-DCMAKE_TOOLCHAIN_FILE=../../iossimxc.toolchain.cmake  \
-DCMAKE_IOS_DEVELOPER_ROOT=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/ 	\
-DCMAKE_IOS_SDK_ROOT=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneOS.sdk/  \
-GXcode ../../

xcodebuild -project PCRE.xcodeproj -configuration RelWithDebInfo  -target pcre  		-sdk iphonesimulator10.3
xcodebuild -project PCRE.xcodeproj -configuration RelWithDebInfo  -target pcrecpp  	-sdk iphonesimulator10.3
xcodebuild -project PCRE.xcodeproj -configuration RelWithDebInfo  -target pcreposix  -sdk iphonesimulator10.3
cd ../


cd iphone_os
cmake \
-DCMAKE_TOOLCHAIN_FILE=../../ios.toolchain.cmake  \
-DCMAKE_IOS_DEVELOPER_ROOT=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/ 	\
-DCMAKE_IOS_SDK_ROOT=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/  \
-GXcode ../../
xcodebuild -project PCRE.xcodeproj -configuration RelWithDebInfo -target pcre  			-sdk iphoneos10.3
xcodebuild -project PCRE.xcodeproj -configuration RelWithDebInfo -target pcrecpp  		-sdk iphoneos10.3
xcodebuild -project PCRE.xcodeproj -configuration RelWithDebInfo -target pcreposix  	-sdk iphoneos10.3
cd ../

mkdir distribute
cd distribute
lipo  ../iphone_os/RelWithDebInfo-iphoneos/libpcre.a  ../iphone_simulator/RelWithDebInfo-iphonesimulator/libpcre.a   -create -o libpcre.a && lipo -info libpcre.a
mkdir include
cp ../iphone_os/config.h include/
cp ../iphone_os/pcre.h include/


popd .
