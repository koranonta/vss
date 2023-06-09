@ECHO OFF
@CLS
SET zip="C:/Program Files/7-Zip/7z"
@ECHO Zipping the deployment..
%zip% a ses-deploy.7z ./build/*
