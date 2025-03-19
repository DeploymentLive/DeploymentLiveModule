
function Find-LocalFile {
    <#
    .SYNOPSIS
        Find a local File, with application and user overrides.
    .DESCRIPTION
        How do we find the file. In order:
        * First we use the Full Name to search in the local Users's preferences
        * Then we use the Full Name to search in the local Machine's preferences
        * Then we use the Override ScriptBlock to find the file
        * Finally we search for the command in the current %PATH% using Get-Command
        * If all else fails, then Throw an error If ErrorAction is set to 'STOP'
    .EXAMPLE
        $dism = Find-LocalFile 'OffLineManifest\dism.exe' -CommonLocation { 'c:\windows\syswow64\dism.exe' } -erroraction Continue
        Search for DISM, make a preference for the 32 bit version, and silently continue if there is an error.
    #>

    [cmdletbinding()]
    param(
        [parameter(position=0)]
        [string] $Name,
        [ScriptBlock] $CommonLocation
    )

    #region look in Local settings

    $Data = Find-LocalData $Name
    if ( $Data -and ( test-path $Data ) ) { 
        write-verbose "Found Setting [$Name] = $Data"
        return $Data
    }

    #endregion

    #region Try the override ScriptBlock
    if ( $CommonLocation -ne $null ) {
        $Path = Invoke-command -ScriptBlock $CommonLocation
        if ( test-path $Path ) { 
            write-verbose "Found ScriptBlock [$Name] = $Path"
            return $Path
        }
    }

    #endregion 

    #region Serach the path

    $Path = get-command -Name ( split-path -leaf $Name )
    if ( $Found ) { 
        write-verbose "Found Command in Path [$Name] = $Path"
        return $Path
    }

    #endregion 

    #region Did not find binary

    if ( $ErrorActionPreference -notin 'SilentlyContinue','Continue' ) { 
        throw "Did not find [$Name]"
    }
    else {
        write-warning "Did not find [$Name]"
    }

    #endregion 

}
