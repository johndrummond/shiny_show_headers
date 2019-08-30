set var=%~dp0R
set "var=%var:\=/%"
echo %var%
"C:\Program Files\R\R-3.6.1\bin\RScript.exe" -e "shiny::runApp('%var%', host='0.0.0.0', port=8099)"



