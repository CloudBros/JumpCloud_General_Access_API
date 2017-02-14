<#
	.DESCRIPTION
		Rest API writer interface

	.SYNOPSIS
		Rest API writer interface

	.EXAMPLE

#>
. ".\repositories\Writer.ps1"
. ".\http\HTTPRequest.ps1"
class RestWriter : Writer
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
    [Object] write([Object] $object) {
        return $this.request.call();
    }
}
