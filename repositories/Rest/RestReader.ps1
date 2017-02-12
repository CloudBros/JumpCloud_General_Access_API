<#
	.DESCRIPTION
		Rest API reader interface

	.SYNOPSIS
		Rest API reader interface

	.EXAMPLE

#>
using module "$pwd\repositories\Reader.ps1"
using module "$pwd\http\HTTPRequest.ps1"

class RestReader : Reader
{
    [HTTPRequest] $request

    RestReader([HTTPRequest] $request) {
        $this.request = $request
    }

    <#
    	.DESCRIPTION
    		Reads data from a source

    	.SYNOPSIS
    		Reads data from a source

    	.EXAMPLE
            [Object] object = $reader.read()
    #>
    [Object] read() {
        return $this.request.call();
    }
}
