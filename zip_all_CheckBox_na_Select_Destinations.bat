@echo off
color 07
:menu
echo " [1] D:\"
echo " [2] Z:\"
echo " [3] E:\"
echo " [4] F:\"
echo " [5] G:\"
echo " [6] C:\work\"
echo " [7] C:\Users\DELL\Documents\zaloha\ruzne\"

REM echo "cokoliv jineho pro ukonceni programu"
set /p volba="zadej 1 - 7 a nebo Enter = konec ?:
REM echo %volba%

if %volba%==1 (goto 1)
if %volba%==2 (goto 2)
if %volba%==3 (goto 3)
if %volba%==4 (goto 4)
if %volba%==5 (goto 5)
if %volba%==6 (goto 6)
if %volba%==7 (goto 7)

REM sem skoci kdyz neproslo zadnou z predeslich podminek
REM echo Spatne zadani, konec programu
goto konec

:1
powershell -File .\zip_all_CheckBox_na_args_path_6.ps1 D:\
REM zadavat cestu takle jak je bez uvozovek a z lomitkem na konci ( jinak to blne, pri kontrole unzip-em )
goto konec

:2
powershell -File .\zip_all_CheckBox_na_args_path_6.ps1 Z:\
REM zadavat cestu takle jak je bez uvozovek a z lomitkem na konci ( jinak to blne, pri kontrole unzip-em )
goto konec

:3
powershell -File .\zip_all_CheckBox_na_args_path_6.ps1 E:\
REM zadavat cestu takle jak je bez uvozovek a z lomitkem na konci ( jinak to blne, pri kontrole unzip-em )
goto konec

:4
powershell -File .\zip_all_CheckBox_na_args_path_6.ps1 F:\
REM zadavat cestu takle jak je bez uvozovek a z lomitkem na konci ( jinak to blne, pri kontrole unzip-em )
goto konec

:5
powershell -File .\zip_all_CheckBox_na_args_path_6.ps1 G:\
REM zadavat cestu takle jak je bez uvozovek a z lomitkem na konci ( jinak to blne, pri kontrole unzip-em )
goto konec

:6
powershell -File .\zip_all_CheckBox_na_args_path_6.ps1 C:\work\
REM zadavat cestu takle jak je bez uvozovek a z lomitkem na konci ( jinak to blne, pri kontrole unzip-em )
goto konec

:7
powershell -File .\zip_all_CheckBox_na_args_path_6.ps1 C:\Users\DELL\Documents\zaloha\ruzne\
REM zadavat cestu takle jak je bez uvozovek a z lomitkem na konci ( jinak to blne, pri kontrole unzip-em )
REM goto konec


:konec
R:\test_zip.bat
pause
