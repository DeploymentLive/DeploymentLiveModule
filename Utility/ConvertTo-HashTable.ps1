Function ConvertTo-Hashtable {
    <#
    .SYNOPSIS
        Converts a PSCustomObject into a hashtable for Windows PowerShell
    .NOTES
        WHen converting back to PSCustomObject, simply cast the object to [PSCustomObject]

    .LINK
        https://github.com/aaronparker/evergreen/blob/main/Evergreen/Private/ConvertTo-Hashtable.ps1
        https://stackoverflow.com/questions/3740128/pscustomobject-to-hashtable
    #>
    [OutputType([System.Collections.Hashtable])]
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, ValueFromPipeline)]
        $InputObject
    )

    process {
        ## Return null if the input is null. This can happen when calling the function
        ## recursively and a property is null
        if ($null -eq $InputObject) {
            return $null
        }

        ## Check if the input is an array or collection. If so, we also need to convert
        ## those types into hash tables as well. This function will convert all child
        ## objects into hash tables (if applicable)
        if ($InputObject -is [System.Collections.IEnumerable] -and $InputObject -isnot [System.String]) {
            $collection = @(
                foreach ($object in $InputObject) {
                    ConvertTo-Hashtable -InputObject $object
                }
            )

            ## Return the array but don't enumerate it because the object may be pretty complex
            Write-Output -NoEnumerate -InputObject $collection
        }
        elseif ($InputObject -is [PSObject]) {
            ## If the object has properties that need enumeration
            ## Convert it to its own hash table and return it
            $hash = @{ }
            foreach ($property in $InputObject.PSObject.Properties) {
                $hash[$property.Name] = ConvertTo-Hashtable -InputObject $property.Value
            }
            Write-Output -InputObject $hash
        }
        else {
            ## If the object isn't an array, collection, or other object, it's already a hash table
            Write-Output -InputObject $InputObject
        }
    }
}