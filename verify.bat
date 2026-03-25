@echo off
chcp 65001 >nul
set PYTHON=C:\Users\User\AppData\Local\Programs\Python\Python312\python.exe
set PYTHONIOENCODING=utf-8
"%PYTHON%" scripts\verify_bis.py
