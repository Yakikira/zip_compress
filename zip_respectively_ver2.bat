@ECHO OFF

rem �x�����ϐ���ݒ�
setlocal enabledelayedexpansion
rem �p�X���[�h������
SET length=10
rem �����p�^�[�� 1:�����̂݁A2:�p��
SET pattern=2
SET prefix="�p�X���[�h�̂��ē�_"

SET x=%*

FOR %%f IN (!x!) DO (
for /f "usebackq" %%i in (`powershell -NoProfile -ExecutionPolicy Unrestricted -Command "& { switch ("%pattern%") {"1" {$characters='123456789'}"2" {$characters='abcdefghkmnprstuvwxyzABCDEFGHKLMNPRSTUVWXYZ123456789'}}; -join ${characters}[(1..%length% | ForEach-Object { Get-Random -Maximum ${characters}.length })] }"`) do set value=%%i
"C:\Program Files\7-Zip\7z.exe" a -p!value! %%f.zip %%f
echo �Y�t�t�@�C��%%~nf�̉𓀃p�X���[�h�͈ȉ��ƂȂ�܂�> %%~dpf%prefix%%%~nf.txt
echo. >> %%~dpf%prefix%%%~nf.txt
echo !value!>> %%~dpf%prefix%%%~nf.txt
)