<#
	.DESCRIPTION
		Global appender interface

	.SYNOPSIS
		Global appender interface

	.EXAMPLE

#>
. "$pwd\repositories\Writer.ps1"
class Appender
{
    [Writer] $writer
    <#
    	.DESCRIPTION
    		Appends data to a destination

    	.SYNOPSIS
    		Appends data to a destination

        .PARAMETER object
            The object to add

    	.EXAMPLE
            $appender.update([Object] object)
    #>
	append([Object] $object) {
        echo "Not Yet Implemented"
    }

    <#
    	.DESCRIPTION
    		Deletes data by id

    	.SYNOPSIS
    		Deletes data by id

        .PARAMETER id
            The id to target

    	.EXAMPLE
            $appender.delete([string] id)
    #>
	delete([string] $id) {
        echo "Not Yet Implemented"
	}

    <#
    	.DESCRIPTION
    		Updates data by id

    	.SYNOPSIS
    		Updates data by id

        .PARAMETER id
            The id to target

        .PARAMETER object
            The new object informations

    	.EXAMPLE
            $appender.update([string] id, [Object] object)
    #>
    update([string] $id, [Object] $object) {
        echo "Not Yet Implemented"
	}
}
