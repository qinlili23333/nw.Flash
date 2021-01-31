::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCuDJHKrwG0CASdkRQeWKXm/FYmZEzZ9Lw0CWZOblAUDU6Dv9YanbukQ5SU=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSjk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSTk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQJhZksaHErSbDvqZg==
::ZQ05rAF9IBncCkqN+0xwdVsFAlTMbCXqVuVMiA==
::ZQ05rAF9IAHYFVzEqQI+Pz1YTReKFG62FrAOiA==
::eg0/rx1wNQPfEVWB+kM9LVsJDAqVGme7Fb1S7fD+jw==
::fBEirQZwNQPfEVWB+kM9LVsJDAqVGme7Fb007eTr6vjn
::cRolqwZ3JBvQF1fEqQI+Pz1YTReKFG62FrAOiA==
::dhA7uBVwLU+EWN50IMTy4J2WhGQ=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATE900gMQldSwyWfOxK0jPeIG45J6rV8hxIGbBvKt67
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCuDJH6F+UcfOA9dfBaNNm65Eok/+vH02PORp18TaOwoXoPaybzAJfgWig==
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
color f0
title nw.Flash助手1.0.0.0000
echo 正在检查本地环境
set Framework=%appdata%\Qinlili\CryoWyvern
if not exist %Framework% goto installcw
mkdir %Framework%\Tools
cd /d %Framework%\Tools
if "%1"=="--fix" rd /S /Q nwFlash
if exist nwFlash\PepperFlash goto launch
goto dlnwjs
:getver
echo 正在获取nwjs版本信息
curl https://nwjs.io/versions.json -o nwver.json
for /f "delims=" %%a in ('%Framework%\jq-win64.exe .latest nwver.json -r') do set latestver=%%a
if not defined latestver goto error
del /F /S /Q nwver.json
:dlnwjs
echo 安装需要消耗大约150M流量,请在稳定的网络下继续
echo 正在下载0.50.3版本nwjs(使用淘宝源加速)
curl https://npm.taobao.org/mirrors/nwjs/v0.50.3/nwjs-sdk-v0.50.3-win-x64.zip -o nwjs.zip -L
echo 正在解压nwjs
%Framework%\7za x nwjs.zip
del /F /S /Q nwjs.zip
for /f "delims=" %%a in ('dir nwjs* /B') do set nwjspath=%%a
rename %nwjspath% nwFlash
echo 正在下载Flash缝合怪
curl https://cdn.jsdelivr.net/gh/qinlili23333/CryoWyvernStorage0@main/ToolBlock/nwFlash/PepperFlash.cbin -o PepperFlash.7z
echo 解压Flash缝合怪
%Framework%\7za x PepperFlash.7z -onwFlash
echo 已经安装了nwFlash,你可以把本安装器拖到任意地方以用作启动器
goto launch

:installcw
echo nwFlash安装过程需要依赖CryoWyvern组件
echo 没有安装CryoWyvern!正在准备安装
echo 请在安装CryoWyvern后重新运行本安装器
echo %time%正在下载最新版本安装程序
set Framework=%appdata%\Qinlili\CryoWyvern
cd /d %Temp%
curl https://cdn.jsdelivr.net/gh/qinlili23333/CryoWyvern@master/Framework/InstallerFiles/Installer.batch -o Installer.bat
echo %time%正在启动安装程序
Installer.bat
exit /b

:error
echo 获取版本信息失败
:trynet
echo 正在检测网络连通性
ping -n 5 nwjs.io>%temp%\1.ping
findstr "Lost = 0" %temp%\1.ping>nul
if %errorlevel%==0 (echo [INFO]网络已连接) else (echo [ERROR]网络故障或不稳定,按任意键重试 & pause >nul & goto trynet)
echo 正在发起重试
goto getver

:launchintent
start nw.exe --url=%command%
exit /b


:launch
cd /d nwFlash
set command=%1
if not x%command:http=%==x%command% goto launchintent
if not x%command:file=%==x%command% goto launchintent
echo 如果程序无法启动,可删除安装文件夹重新安装或连带--fix命令运行
set /p url=输入网址或按回车直接打开默认页面(Google)
if not defined url set url=https://www.google.com
start nw.exe --url=%url%
exit /b