<# 
if (!(Test-Path -Path $PROFILE)) {
  New-Item -ItemType File -Path $PROFILE -Force
} 
#>

Set-StrictMode -Version Latest
Write-Output "Loaded PS user profile."

function Run-IntegrationTest ([string]$testName){
	Cd-Repo-Main
	VSTest.Console.exe Path-to-Integration-Tests.dll  /tests:$testName # --logger:junit

	if ( (Test-Path .\TestResults\$testName) -eq $False ){
		New-Item TestResults\$testName -ItemType Directory
	}
	Move-Item "TestResults\TestResults.xml" "TestResults\$testName\$($testName)_$(Get-Timestamp)_TestResults.xml"
	Remove-Item "TestResults\Deploy_*" -Recurse -Force
}

function Run-UItest ([string]$testName, [int]$times=1){
	Cd-Repo-UItests
	if ( (Test-Path .\TestResults\$testName) -eq $False ){
		New-Item TestResults\$testName -ItemType Directory
	}
	for ($i=1; $i -le $times; $i++)
	{
		Write-Output "`n -------- $(Get-Timestamp) TEST RUN $i OF $times "
		dotnet test relative-path-to-UiTests.dll  /tests:$testName --logger:junit --nologo
		Move-Item "TestResults\TestResults.xml" "TestResults\$testName\$($testName)_$(Get-Timestamp)_TestResults.xml"
		Move-Item "TestResults\$($testName.substring(0,7))*.png" "TestResults\$testName\"
	}
	Remove-Item "TestResults\Deploy_*" -Recurse -Force
}
function Stop-UItests (){
# Stops Visual Studio running random UI tests on its own after "Debug Test" finishes
	Get-Process | Where-Object {$_.Path -like "*dotnet.exe"} | Stop-Process
	Get-Process | Where-Object {$_.Path -like "*IEDriverServer.exe"} | Stop-Process
	Get-Process | Where-Object {$_.Path -like "*chrome*.exe*"} | Stop-Process
}

function Print-Timestamp { Write-Output $(Get-Timestamp) }
function Get-Timestamp { return  $([DateTime]::Now.ToString("yyyyMMddTHHmmss")) }
function Git-FileHistory ([string]$path){
    if ($path -and (Test-Path $path)) {
        # gitex is C:\Program Files (x86)\GitExtensions\GitEx.cmd
        gitex filehistory $path
    }
    else{
        Write-Output "Supplied path to file is invalid."
    }
}
function Cd-Repo-Main { Set-Location $main_sln_dir }
function Cd-Repo-UItests { Set-Location $uitests_sln_dir }

function Db-ListAll {
    # Helps me quickly check which databases I have on my PC 
    # without having to launch SSMS and wait for it to start.
    # See https://www.sqlshack.com/working-sql-server-command-line-sqlcmd/
    sqlcmd -Q "Sp_databases"
}
function Db-Backup ([string]$dbname){
    # Alternative to SSMS - Right click the database - Tasks - Back Up...
    $filename=$dbname+'_'+[DateTime]::Now.ToString("yyyy-MM-dd_HHmmss") 
    $command = "BACKUP DATABASE [$dbname] TO DISK='C:\DB-backups\$filename.bak'"
    sqlcmd -Q $command
}
