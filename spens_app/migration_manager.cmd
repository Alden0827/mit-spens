@echo off
:menu
cls
echo ================================
echo      Django Migration Menu       
echo ================================
echo 1. Initialize Migrations
echo 2. Create Migration
echo 3. Apply Migrations
echo 4. Show Migration History
echo 5. Rollback Last Migration
echo 6. Rollback to Specific Migration
echo 7. Show Current Migration
echo 8. Exit
echo ================================
set /p choice="Select an option: "

if "%choice%"=="1" (
    python manage.py makemigrations
    pause
    goto menu
)
if "%choice%"=="2" (
    set /p message="Enter app name (leave blank for all apps): "
    if "%message%"=="" (
        python manage.py makemigrations
    ) else (
        python manage.py makemigrations %message%
    )
    pause
    goto menu
)
if "%choice%"=="3" (
    python manage.py migrate
    pause
    goto menu
)
if "%choice%"=="4" (
    python manage.py showmigrations
    pause
    goto menu
)
if "%choice%"=="5" (
    python manage.py migrate --rollback
    pause
    goto menu
)
if "%choice%"=="6" (
    set /p migration_id="Enter app name and migration (e.g., myapp 0001_initial): "
    python manage.py migrate %migration_id%
    pause
    goto menu
)
if "%choice%"=="7" (
    python manage.py showmigrations --list | findstr "[X]"
    pause
    goto menu
)
if "%choice%"=="8" (
    exit
)

echo Invalid choice, try again.
pause
goto menu
