@echo off
setlocal

REM Task 3: clone the Netology repository, merge earlyorder into main,
REM resolve README.md by keeping the incoming earlyorder version,
REM then push main to a new empty public repository on GitHub.

cd /d "%USERPROFILE%\Desktop" || goto :error

if exist "git-2-homeworks-merge" (
  echo The folder Desktop\git-2-homeworks-merge already exists.
  echo Rename or remove it, then run this script again.
  goto :done
)

git clone https://github.com/netology-code/git-2-homeworks-merge.git
if errorlevel 1 goto :error

cd /d "%USERPROFILE%\Desktop\git-2-homeworks-merge" || goto :error

git switch main
if errorlevel 1 goto :error

git fetch origin
if errorlevel 1 goto :error

git merge origin/earlyorder

REM Resolve the expected README.md conflict by keeping the earlyorder version.
git checkout --theirs -- README.md
if errorlevel 1 goto :error

git add README.md
git commit -m "Merge earlyorder into main"
if errorlevel 1 goto :error

echo.
echo Local merge is complete.
echo Create a NEW EMPTY PUBLIC repository on GitHub first (do not add a README).
echo.
set /p REPO_NAME=Enter the exact name of your new GitHub repository: 
if "%REPO_NAME%"=="" goto :error

git remote add target git@github.com:skymoll/%REPO_NAME%.git
if errorlevel 1 goto :error

git push -u target main
if errorlevel 1 goto :error

echo.
echo Task 3 has been pushed to https://github.com/skymoll/%REPO_NAME%
echo.
pause
exit /b 0

:error
echo.
echo Something went wrong. Read the Git error above and check that Git and SSH are configured.
echo The project folder, if cloned, is on your Desktop: git-2-homeworks-merge
pause
exit /b 1

:done
pause
exit /b 1
