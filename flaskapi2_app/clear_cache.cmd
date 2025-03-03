for /r %%i in (*.pyc) do del "%%i"
for /d /r %%i in (__pycache__) do rd /s /q "%%i"

pause