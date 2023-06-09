rmdir /S /Q static
rmdir /S /Q assets
del /f *.json
del /f *.ico
del /f *.png
del /f *.txt
del /f *.html
"C:\Program Files\7-Zip\7z" x ses-deploy.7z -y

