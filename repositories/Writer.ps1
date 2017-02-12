<#
	.DESCRIPTION
		Global writer interface

	.SYNOPSIS
		Global writer interface

	.EXAMPLE

#>
class Writer
{
    <#
    	.DESCRIPTION
    		Writes data to a destination

    	.SYNOPSIS
    		Writes data to a destination

    	.EXAMPLE
            $writer.write([Object] object)
    #>
    [Object] write([Object] $object) {
        echo "Not Yet Implemented"
        return $null
    }
}
