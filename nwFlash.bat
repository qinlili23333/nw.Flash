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
title nw.Flash����1.0.0.0000
echo ���ڼ�鱾�ػ���
set Framework=%appdata%\Qinlili\CryoWyvern
if not exist %Framework% goto installcw
mkdir %Framework%\Tools
cd /d %Framework%\Tools
if "%1"=="--fix" rd /S /Q nwFlash
if exist nwFlash\PepperFlash goto launch
goto dlnwjs
:getver
echo ���ڻ�ȡnwjs�汾��Ϣ
curl https://nwjs.io/versions.json -o nwver.json
for /f "delims=" %%a in ('%Framework%\jq-win64.exe .latest nwver.json -r') do set latestver=%%a
if not defined latestver goto error
del /F /S /Q nwver.json
:dlnwjs
echo ��װ��Ҫ���Ĵ�Լ150M����,�����ȶ��������¼���
echo ��������0.50.3�汾nwjs(ʹ���Ա�Դ����)
curl https://npm.taobao.org/mirrors/nwjs/v0.50.3/nwjs-sdk-v0.50.3-win-x64.zip -o nwjs.zip -L
echo ���ڽ�ѹnwjs
%Framework%\7za x nwjs.zip
del /F /S /Q nwjs.zip
for /f "delims=" %%a in ('dir nwjs* /B') do set nwjspath=%%a
rename %nwjspath% nwFlash
echo ��������Flash��Ϲ�
curl https://cdn.jsdelivr.net/gh/qinlili23333/CryoWyvernStorage0@main/ToolBlock/nwFlash/PepperFlash.cbin -o PepperFlash.7z
echo ��ѹFlash��Ϲ�
%Framework%\7za x PepperFlash.7z -onwFlash
echo �Ѿ���װ��nwFlash,����԰ѱ���װ���ϵ�����ط�������������
goto launch

:installcw
echo nwFlash��װ������Ҫ����CryoWyvern���
echo û�а�װCryoWyvern!����׼����װ
echo ���ڰ�װCryoWyvern���������б���װ��
echo %time%�����������°汾��װ����
set Framework=%appdata%\Qinlili\CryoWyvern
cd /d %Temp%
curl https://cdn.jsdelivr.net/gh/qinlili23333/CryoWyvern@master/Framework/InstallerFiles/Installer.batch -o Installer.bat
echo %time%����������װ����
Installer.bat
exit /b

:error
echo ��ȡ�汾��Ϣʧ��
:trynet
echo ���ڼ��������ͨ��
ping -n 5 nwjs.io>%temp%\1.ping
findstr "Lost = 0" %temp%\1.ping>nul
if %errorlevel%==0 (echo [INFO]����������) else (echo [ERROR]������ϻ��ȶ�,����������� & pause >nul & goto trynet)
echo ���ڷ�������
goto getver

:launchintent
start nw.exe --url=%command%
exit /b


:launch
cd /d nwFlash
set command=%1
if not x%command:http=%==x%command% goto launchintent
if not x%command:file=%==x%command% goto launchintent
echo ��������޷�����,��ɾ����װ�ļ������°�װ������--fix��������
set /p url=������ַ�򰴻س�ֱ�Ӵ�Ĭ��ҳ��(Google)
if not defined url set url=https://www.google.com
start nw.exe --url=%url%
exit /b