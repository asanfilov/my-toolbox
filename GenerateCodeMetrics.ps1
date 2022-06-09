# Generate Codebase Metrics
Set-StrictMode -Version Latest

function Count-Lines { param ($arg)
	if ($arg -is [array]) { Count-All-Lines ($arg) }
	#else { (Get-ChildItem -File -Filter $arg -Recurse | Get-Content |Measure-Object -Line).Lines }
	else{ (Get-ChildItem -Path . -Filter "$arg"  -Recurse | Where-Object { $_.FullName -notmatch 'obj|bin|AssemblyInfo.cs' } | Get-Content | Measure-Object -Line).Lines }
}

function Count-Files { param ($arg)
	if ($arg -is [array]) { Count-All-Files ($arg) }
	else { (Get-ChildItem -File -Filter "$arg" -Recurse | Where-Object { $_.FullName -notmatch 'obj|bin|AssemblyInfo.cs' } |Measure-Object -Line).Lines }
}
 
function Count-All-Files { param($a)
    $sum = 0;
    foreach($x in $a)
    {
        $sum += Count-Files($x)
    }
    return $sum
}
 
function Count-All-Lines { param($a)
    $sum = 0;
    foreach($x in $a)
    {
        $sum += Count-Lines($x)
    }
    return $sum
}
 
# function Count-Tests {
#     Set-Location-Repo
#     (gci -Filter *.Test* | gci  -Filter *.cs -Recurse | gc | sls -Pattern "\[Test[,\]]" | measure -line).Lines
# }
 
# Ideally the following should output to a table or list (csv?), but this is good enough for now
# function Generate-Code-Metrics {
#     Set-Location-Repo
#     cd src
#     Write-Host "* Counting *.cs Files in src"
#     Count-Files *.cs | Out-Host
#     Write-Host "* Counting *.cs Lines in src"
#     Count-Lines *.cs | Out-Host
#     # repeat for *.sql and other files of interest
  
#     Write-Host "* Counting Tests"
#     Count-Tests
 
# }