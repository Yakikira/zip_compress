@ECHO OFF

rem 遅延環境変数を設定
setlocal enabledelayedexpansion
rem パスワード文字数
SET length=10
rem 生成パターン 1:数字のみ、2:英数
SET pattern=2
SET prefix="パスワードのご案内_"

SET x=%*

FOR %%f IN (!x!) DO (
for /f "usebackq" %%i in (`powershell -NoProfile -ExecutionPolicy Unrestricted -Command "& { switch ("%pattern%") {"1" {$characters='123456789'}"2" {$characters='abcdefghkmnprstuvwxyzABCDEFGHKLMNPRSTUVWXYZ123456789'}}; -join ${characters}[(1..%length% | ForEach-Object { Get-Random -Maximum ${characters}.length })] }"`) do set value=%%i
"C:\Program Files\7-Zip\7z.exe" a -p!value! %%f.zip %%f
echo 添付ファイル%%~nfの解凍パスワードは以下となります> %%~dpf%prefix%%%~nf.txt
echo. >> %%~dpf%prefix%%%~nf.txt
echo !value!>> %%~dpf%prefix%%%~nf.txt
)