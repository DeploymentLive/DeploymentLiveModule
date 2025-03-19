function Find-LocalData {
<#
.SYNOPSIS
    Search for a configuration Setting stored locally outside of the Module.
.DESCRIPTION
    Search for a configuration Setting. In Order:
    * First we use the Full Name to search in the local Users's preferences
    * Then we use the Full Name to search in the local Machine's preferences
.NOTES
    Information or caveats about the function e.g. 'This function is not supported in Linux'
.LINK
    Specify a URI to a help page, this will show when Get-Help -Online is used.
.EXAMPLE
    Test-MyTestFunction -Verbose
    Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
#>

[cmdletbinding()]
param(
    [parameter(mandatory)] [string] $name,
    [string] $MachineProfilePath = (split-path $PROFILE.AllUsersAllHosts),
    [string] $UserProfilePath = (split-path $PROFILE.CurrentUserAllHosts)
)

    # Search for settings in-memory cache?!?!

    foreach ( $Path in $UserProfilePath, $MachineProfilePath ) {
        $profileXML = join-path $Path "DeploymentLive.clixml"
        if ( test-path $ProfileXML ) {
            # CLIXML file with a HashTable at the root.
            $ProfileData = import-clixml -Path $profileXML
            if ( $ProfileData.ContainsKey($Name) ) {
                write-verbose "Found Data $ProfileXML : $Name"
                return $ProfileData.item($Name)
            }
        }

        # Other kinds of data types!?!? JSON? INI? CSV?
    }

    #region Did not find binary

    if ( $ErrorActionPreference -notin 'SilentlyContinue','Continue' ) { 
        throw "Did not find [$Name] in data profiles"
    }
    else {
        write-warning "Did not find [$Name] in data profiles"
    }

    #endregion 

}