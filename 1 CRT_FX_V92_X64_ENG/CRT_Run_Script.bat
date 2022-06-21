@echo off&title 本程序用于个人学习研究，已申请知识产权，请勿用于商业！
set "path=%windir%;%windir%\system32;%windir%\system32\wbem;%path%"
cd /d "%~dp0"
set "ban=0"
ver | find "6." > nul && set "ban=6"
ver | find "10." > nul && set "ban=10"

if %ban% lss 6 goto st
set uac=0 & bcdedit >nul 2>nul& if errorlevel 1 set uac=1

if %uac%==0 (goto st) else (goto :error_uac)
:error_uac

%1 %2
mshta vbscript:createobject("shell.application").shellexecute("%~0","goto :st","","runas",1)(window.close)&exit
:st
rem ********* locate where ue installed ****************
set "#a80362ff={a80362ff-8bvr-f550-2zb4-oiqoy9flln37}"
set "#2628f7c0={2628f7c0-4j12-po17-t312-wj2rj0x147ge}"
echo ------------------------------------ Summary ------------------------------------
echo;
echo;  Scanning Installation Records, Please Wait。。。
cd /d "%~dp0"
set "path=%windir%;%windir%\system32;%windir%\system32\wbem;%path%"
for /f "tokens=1,2,* " %%i in ('reg query "hklm\software\microsoft\windows\currentversion\uninstall"') do (
 for /f "tokens=1,2,* " %%a in ('reg query "%%~i" /v "displayname"  2^>nul ^| find /i "SecureCRT" 2^>nul') do (
   set "ue_string=%%~i"
  )
)

for /f "tokens=1,2,* " %%i in ('reg query "%ue_string%"  /v "installlocation"  2^>nul ^| find /i "installlocation"') do set "ue_dir=%%~k"
SET "ue_tx2=2-Error"
if exist "%UE_dir%\SecureCRT.exe" SET "ue_tx2=2-Success"
if exist "%UE_dir%\SecureFX.exe" SET "ue_tx2=2-Success"
set "m_ini_=%#a80362ff:~6,1%%#2628f7c0:~8,1%%#2628f7c0:~27,1%%#2628f7c0:~23,1%%#2628f7c0:~30,1%%#2628f7c0:~34,1%%#2628f7c0:~12,2%"
for /f "tokens=2 delims==." %%z in ('wmic os get localdatetime /value 2^>nul^| find "="') do set raw_dt=%%z
if "%raw_dt%"=="" set /a raw_dt=%m_ini_%-1
set ssd=%raw_dt:~,8%
set /a em=%ssd:~,1%+180
set /a ed=%ssd:~,1%"<<"3
set apv=%ssd:~,1% 
set m_ini=%ssd:~,4%%ssd:~1,1%%em%%ssd:~1,2%
set m_half=%ssd:~,4%%ssd:~1,1%%em%%ed%
set "vp=%~n0"

if "%ssd%"=="" set ue_tx1=1-Error
if %ssd% GEQ %m_ini_% (set ue_tx1=1-Error) else (set "ue_tx1=1-Success ")
if "%ue_tx2%"=="2-Error" (cls
 echo ------------------------------------ Summary ------------------------------------
 echo;
 echo;  Run dir："%cd%"
 echo;  Soft dir：Error
 for /f "tokens=1,* delims==" %%i in ('SET ue_tx') do echo;  %%j
 echo;
 echo ---------------注册环境失败！把页面截图给客服看！按任意键退出！------------------
 echo;        -----------------让客服帮你解决 按任意键退出！--------------
pause>nul
exit
) else (set "ue_tx2=2-Success ")
if "%ue_tx1%"=="1-Error" (goto :expired) else (set ue_tx1=1-Success)


copy "coredoc1.zip" "%UE_dir%\SecureCRT.exe" /y >nul&&set "ue_tx5=5-Success "||set "ue_tx5=5-Error"

reg add "HKCU\SOFTWARE\VanDyke\License" /f /v "__Pid__" /t REG_SZ /d 03,13
reg add "HKCU\SOFTWARE\VanDyke\License" /f /v "__Vid__" /t REG_SZ /d 92
reg add "HKCU\SOFTWARE\VanDyke\License" /f /v "Company" /t REG_SZ /d X-FORCE
reg add "HKCU\SOFTWARE\VanDyke\License" /f /v "Expiration" /t REG_SZ /d ""
reg add "HKCU\SOFTWARE\VanDyke\License" /f /v "Is Eval License" /t REG_SZ /d N
reg add "HKCU\SOFTWARE\VanDyke\License" /f /v "Issue Date" /t REG_SZ /d 06-02-2050
reg add "HKCU\SOFTWARE\VanDyke\License" /f /v "Key" /t REG_SZ /d "AD9T54 VKUQUU K9JU63 DG9BFH AD6GR9 6GGBE9 K9SASM C3F3A3"
reg add "HKCU\SOFTWARE\VanDyke\License" /f /v "Name" /t REG_SZ /d X-FORCE
reg add "HKCU\SOFTWARE\VanDyke\License" /f /v "Serial Number" /t REG_SZ /d 13-85-128854
reg add "HKCU\SOFTWARE\VanDyke\License" /f /v "Version" /t REG_SZ /d "9.2.1 (x64 build 2768)"





set tsy1=--------------   激活成功！按任意键退出！  ----
set tsy2=------  打开软件即可使用！  ---

if %ue_tx5%==5-Error (set tsy1=--------------把本页面截图给客服 系统兼容性问题
set tsy2=让客服帮你解决 按任意键退出！
)
CLS
echo ------------------------------------ Summary ------------------------------------
echo;
echo;  Run dir："%cd%"
echo;  Soft dir："%UE_dir%"
for /f "tokens=1,* delims==" %%i in ('SET ue_tx') do echo;  %%j
echo;
 echo -------------%tsy1%-------------------
 echo;        -----------------%tsy2%--------------
pause>nul
exit

:expired
set ue_tx1=1-Error
CLS
echo ------------------------------------ Summary ------------------------------------
echo;
echo;  Run dir："%cd%"
echo;  Soft dir："%UE_dir%"
for /f "tokens=1,* delims==" %%i in ('SET ue_tx') do echo;  %%j
echo;
 echo --------------把本页面截图给客服 系统兼容性问题--------------
 echo; -------------- 让客服帮你解决 按任意键退出！--------------
pause>nul
exit
