@echo off
setlocal
cd /d "%~dp0"
set "SWEETPLANET_PAGE=/"
if "%~1"=="/scene-editor.html" set "SWEETPLANET_PAGE=/scene-editor.html"
set "PORT=5189"
where node >nul 2>nul
if errorlevel 1 (
  echo Node.js was not found. Please install Node.js and try again.
  pause
  exit /b 1
)
node -e "fetch('http://127.0.0.1:5189/').then(r=>r.text()).then(t=>process.exit(t.includes('SweetPlanet')?0:1)).catch(()=>process.exit(1))"
if not errorlevel 1 (
  start "" "http://127.0.0.1:5189%SWEETPLANET_PAGE%"
  exit /b 0
)
start "" /b node scripts/open-local-page.cjs "%SWEETPLANET_PAGE%"
node server.mjs
pause
