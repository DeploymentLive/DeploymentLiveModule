#Requires -RunAsAdministrator

# Install a link to this module into the global Module path.

$ModulesPath = "$env:ProgramFiles\WindowsPowerShell\Modules"
if ( -not ( test-path $ModulesPath ) ) { 
    new-item -ItemType Directory -path $ModulesPath -force | write-verbose
}
$TargetPath = join-path $ModulesPath ( split-path -leaf $PSScriptRoot ) 
if ( -not ( test-path "$TargetPath\*.psm1" ) ) { 
     new-item -ItemType Junction -Path  $TargetPath -Value $PSscriptRoot -Force | write-verbose
}
