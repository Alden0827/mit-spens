@echo off
:menu
cls
echo ================================
echo      Flask Migration Menu       
echo ================================
echo 1. Initialize Migration
echo 2. Create Migration
echo 3. Apply Migration
echo 4. Show Migration History
echo 5. Rollback Last Migration
echo 6. Rollback to Specific Migration
echo 7. Exit
echo ================================
set /p choice="Select an option: "

if "%choice%"=="1" (
    flask db init
    pause
    goto menu
)
if "%choice%"=="2" (
    set /p message="Enter migration message: "
    flask db migrate -m "%message%"
    pause
    goto menu
)
if "%choice%"=="3" (
    flask db upgrade
    pause
    goto menu
)
if "%choice%"=="4" (
    flask db history
    pause
    goto menu
)
if "%choice%"=="5" (
    flask db downgrade
    pause
    goto menu
)
if "%choice%"=="6" (
    set /p migration_id="Enter migration ID: "
    flask db downgrade %migration_id%
    pause
    goto menu
)
if "%choice%"=="7" (
    exit
)

echo Invalid choice, try again.
pause
goto menu
