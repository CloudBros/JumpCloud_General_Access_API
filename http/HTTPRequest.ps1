<#
	.DESCRIPTION
		HTTP Request entity class

	.SYNOPSIS
		Class that symbolizes a callable HTTP request

	.EXAMPLE
        [HTTPRequest]::new([string] $url, [string] $type, [Object] $header, [Object] $body, [Object] $credential);

	.PARAMETER url
		The url you want to request

	.PARAMETER type
		The request type (GET, POST, PUT, DELETE)

	.PARAMETER header
		The data you want to pass using the request header

	.PARAMETER body
		The data you want to pass using the request body

	.PARAMETER credential
		Some credentials for possible authentication process

#>
class HTTPRequest
{
    [string] $url
    [string] $type
    [Object] $header
    [Object] $body
    [Object] $credential

    HTTPRequest([string] $url, [string] $type, [Object] $header = $null, [Object] $body = $null, [Object] $credential = $null) {
        $this.url = $url;
        $this.type = $type;
        $this.header = $header;
        $this.body = $body;
        $this.credential = $credential;
    }

    <#
    	.DESCRIPTION
    		HTTP Request calling method
    	.SYNOPSIS
    		Method that triggers an http request call
    	.EXAMPLE
    		$httpRequest.call()
    #>
    [Object] call() {
        $result = Invoke-RestMethod -Method $this.type -Uri $this.url -Headers $this.header -Body $this.body -Credential $this.credential
        return $result;
    }
}
