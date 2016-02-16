:: To edit this file:
:: Add an "IF NOT" statement to the folder loop
:: Add the filetype settings in the file loop
@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
SET D=%~dp0

:: Folders that do not get moved go into an "IF NOT" statement
:: Otherwise they get moved into a directory called "Folders"
FOR /D %%I IN (%D%*) DO (

	IF NOT "%%~NI"=="Adobe" 	(
	IF NOT "%%~NI"=="Archives" 	(
	IF NOT "%%~NI"=="Databases" 	(
	IF NOT "%%~NI"=="Documents" 	(
	IF NOT "%%~NI"=="Drawings" 	(
	IF NOT "%%~NI"=="Excel" 	(
	IF NOT "%%~NI"=="Folders"	(
	IF NOT "%%~NI"=="Images" 	(
	IF NOT "%%~NI"=="Other"		(
	IF NOT "%%~NI"=="PowerPoint" 	(
	IF NOT "%%~NI"=="Scripts" 	(
	IF NOT "%%~NI"=="Software" 	(	

	IF NOT EXIST 	"%D%Folders" 		( MKDIR "%D%Folders" 		) ELSE ( 
	IF EXIST 	"%D%Folders\%%~NI" 	( CALL:RENAMEFOLDER "%%I" 0 	) ELSE ( 
	MOVE 		"%%~I" "%D%Folders\%%~NI" )))))))))))))))

:: Files that match the "IF /I" statement are moved to their respective folders
:: Links and Partial files are deleted
:: Otherwise, any other file type gets moved to "Other"
FOR %%I IN (%D%*) DO (

	IF NOT "%%~NXI"=="^^!hazel.bat" (

		IF /I "%%~XI"==".pdf"		( CALL:MOVEFILE "%%I" "Adobe"		) ELSE (
		IF /I "%%~XI"==".tif"		( CALL:MOVEFILE "%%I" "Adobe"		) ELSE (

		IF /I "%%~XI"==".zip"		( CALL:MOVEFILE "%%I" "Archives"	) ELSE (
		IF /I "%%~XI"==".rar"		( CALL:MOVEFILE "%%I" "Archives"	) ELSE (
		IF /I "%%~XI"==".7z"		( CALL:MOVEFILE "%%I" "Archives"	) ELSE (

		IF /I "%%~XI"==".json"		( CALL:MOVEFILE "%%I" "Databases"	) ELSE (
		IF /I "%%~XI"==".accdb"		( CALL:MOVEFILE "%%I" "Databases"	) ELSE (
		IF /I "%%~XI"==".qvw"		( CALL:MOVEFILE "%%I" "Databases"	) ELSE (

		IF /I "%%~XI"==".doc"		( CALL:MOVEFILE "%%I" "Documents"	) ELSE (
		IF /I "%%~XI"==".docx"		( CALL:MOVEFILE "%%I" "Documents"	) ELSE (
		IF /I "%%~XI"==".txt"		( CALL:MOVEFILE "%%I" "Documents"	) ELSE (

		IF /I "%%~XI"==".dwg"		( CALL:MOVEFILE "%%I" "Drawings"	) ELSE (
		IF /I "%%~XI"==".dxf"		( CALL:MOVEFILE "%%I" "Drawings"	) ELSE (

		IF /I "%%~XI"==".xls"		( CALL:MOVEFILE "%%I" "Excel"		) ELSE (
		IF /I "%%~XI"==".xlsx"		( CALL:MOVEFILE "%%I" "Excel"		) ELSE (
		IF /I "%%~XI"==".xlsb"		( CALL:MOVEFILE "%%I" "Excel"		) ELSE (
		IF /I "%%~XI"==".xlsm"		( CALL:MOVEFILE "%%I" "Excel"		) ELSE (
		IF /I "%%~XI"==".csv"		( CALL:MOVEFILE "%%I" "Excel"		) ELSE (

		IF /I "%%~XI"==".png"		( CALL:MOVEFILE "%%I" "Images"		) ELSE (
		IF /I "%%~XI"==".jpg"		( CALL:MOVEFILE "%%I" "Images"		) ELSE (
		IF /I "%%~XI"==".bmp"		( CALL:MOVEFILE "%%I" "Images"		) ELSE (
		IF /I "%%~XI"==".ico"		( CALL:MOVEFILE "%%I" "Images"		) ELSE (
		IF /I "%%~XI"==".psd"		( CALL:MOVEFILE "%%I" "Images"		) ELSE (

		IF /I "%%~XI"==".ppt"		( CALL:MOVEFILE "%%I" "PowerPoint"	) ELSE (
		IF /I "%%~XI"==".pptx"		( CALL:MOVEFILE "%%I" "PowerPoint"	) ELSE (

		IF /I "%%~XI"==".ahk"		( CALL:MOVEFILE "%%I" "Scripts"		) ELSE (
		IF /I "%%~XI"==".nim"		( CALL:MOVEFILE "%%I" "Scripts"		) ELSE (
		IF /I "%%~XI"==".bat"		( CALL:MOVEFILE "%%I" "Scripts"		) ELSE (
		IF /I "%%~XI"==".py"		( CALL:MOVEFILE "%%I" "Scripts"		) ELSE (
		IF /I "%%~XI"==".qry"		( CALL:MOVEFILE "%%I" "Scripts"		) ELSE (

		IF /I "%%~XI"==".exe"		( CALL:MOVEFILE "%%I" "Software"	) ELSE (
		IF /I "%%~XI"==".msi"		( CALL:MOVEFILE "%%I" "Software"	) ELSE (

		IF /I "%%~XI"==".lnk"		( DEL "%%I"				) ELSE (
		IF /I "%%~XI"==".partial"	( DEL "%%I"				) ELSE (

		CALL:MOVEFILE "%%I" "Other" ))))))))))))))))))))))))))))))))))))

GOTO:EOF

:: When a folder gets moved, this renames the folder when it already exists in the destination
:RENAMEFOLDER
SET /A copies=1+%2
IF EXIST 	"%D%Folders\%~N1 (!copies!)" 		( CALL:RENAMEFOLDER "%~1" !copies! 		) ELSE ( 
MOVE 		"%~1" "%D%Folders\%~N1 (!copies!)" 	)
GOTO:EOF

:: This function creates the destination folder if needed and attempts to move the file
:MOVEFILE
IF NOT EXIST 	"%D%\%~2" 				( MKDIR 		"%D%\%~2" 		) ELSE ( 
IF EXIST 	"%D%\%~2\%~NX1" 			( CALL:RENAMEFILE 	"%~1" "%~2" 0 		) ELSE ( 
MOVE 		"%~1" "%D%\%~2\%~NX1" 			))
GOTO:EOF

:: If the file already exists in the destination, this renames the file
:RENAMEFILE
SET /A copies=1+%3
IF EXIST 	"%D%\%~2\%~N1 (!copies!)%~X1" 		( CALL:RENAMEFILE 	"%~1" "%~2" !copies!	) ELSE ( 
MOVE 		"%~1" "%D%\%~2\%~N1 (!copies!)" 	)
GOTO:EOF
