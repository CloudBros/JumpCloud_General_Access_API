<#
	.DESCRIPTION
		Rest API writer interface

	.SYNOPSIS
		Rest API writer interface

	.EXAMPLE

#>
. "$pwd\repositories\Writer.ps1"
class RestWriter
{
	[HTTPRequest] $request

    RestWriter([HTTPRequest] $request) {
        $this.request = $request
    }
    <#
    	.DESCRIPTION
    		Writes data to a destination

    	.SYNOPSIS
    		Writes data to a destination

    	.EXAMPLE
            $writer.write([Object] object)
    #>
    write([Object] object) {
        echo "Not Yet Implemented"
    }
}
