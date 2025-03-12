function New-TemporaryDirectory {
    <#
    .SYNOPSIS
        Create a new Temporary Directory
    .DESCRIPTION
        Creates a temporary directory in the user's temp folder, and returns the path.
    .EXAMPLE
        New-TemporaryDirectory | Write-verbose
        Create a new temporary directory and send the output to verbose. 
    #>
    [cmdletbinding()]
    param()
    
    $tempfile = [System.IO.Path]::GetTempFileName()
    remove-item $tempfile
    new-item -type directory -path $tempfile
}