@echo off
setlocal enabledelayedexpansion

rem 输入文件夹路径
set "input_folder=D:\新建文件夹\工作\icaspp\demo\SVC-with-accompany\audios\noisy\source"
rem 输出文件夹路径
set "output_folder=D:\新建文件夹\工作\icaspp\demo\SVC-with-accompany\audios\noisy\source2"

rem 创建输出文件夹（如果不存在）
if not exist "%output_folder%" (
    mkdir "%output_folder%"
)

rem 遍历输入文件夹中的所有音频文件
for /r "%input_folder%" %%f in (*.wav *.mp3 *.flac) do (
    rem 获取文件的相对路径
    set "relative_path=%%~pf"
    set "relative_path=!relative_path:%input_folder%=!"

    rem 创建相应的输出子文件夹，保持原有文件夹结构
    mkdir "%output_folder%!relative_path!" 2>nul

    rem 降采样到 24000 Hz 并保存到输出文件夹
    ffmpeg -i "%%f" -ar 16000 "%output_folder%!relative_path!%%~nf_16000%%~xf"

    echo Processed: %%f -> %output_folder%!relative_path!%%~nf_16000%%~xf
)

echo All files have been processed.
pause
