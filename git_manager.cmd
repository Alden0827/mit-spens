@echo off
:menu
cls
echo ================================
echo        Git Manager Menu         
echo ================================
echo 1. Show Status
echo 2. Add Files
echo 3. Commit Changes
echo 4. Push to Remote
echo 5. Pull from Remote
echo 6. Create a New Branch
echo 7. Switch Branch
echo 8. Merge Branch
echo 9. Show Log
echo 10. Exit
echo ================================
set /p choice="Select an option: "

if "%choice%"=="1" (
    git status
    pause
    goto menu
)

if "%choice%"=="2" (
    set /p files="Enter file(s) to add (leave blank for all): "
    if "%files%"=="" (
        git add .
    ) else (
        git add %files%
    )
    echo Files added successfully.
    pause
    goto menu
)

if "%choice%"=="3" (
    set /p commit_msg="Enter commit message: "
    git commit -m "%commit_msg%"
    echo Changes committed successfully.
    pause
    goto menu
)

if "%choice%"=="4" (
    set /p branch="Enter branch name to push to (leave blank for current branch): "
    if "%branch%"=="" (
        git push
    ) else (
        git push origin %branch%
    )
    echo Changes pushed successfully.
    pause
    goto menu
)

if "%choice%"=="5" (
    git pull
    echo Latest changes pulled successfully.
    pause
    goto menu
)

if "%choice%"=="6" (
    set /p new_branch="Enter new branch name: "
    git branch %new_branch%
    echo Branch "%new_branch%" created successfully.
    pause
    goto menu
)

if "%choice%"=="7" (
    set /p switch_branch="Enter branch name to switch to: "
    git checkout %switch_branch%
    echo Switched to branch "%switch_branch%".
    pause
    goto menu
)

if "%choice%"=="8" (
    set /p merge_branch="Enter branch name to merge into current: "
    git merge %merge_branch%
    echo Merged branch "%merge_branch%" successfully.
    pause
    goto menu
)

if "%choice%"=="9" (
    git log --oneline --graph --decorate --all
    pause
    goto menu
)

if "%choice%"=="10" (
    exit
)

echo Invalid choice, try again.
pause
goto menu
