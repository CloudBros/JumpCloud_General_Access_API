<#
	.DESCRIPTION
		REST query management interface

	.SYNOPSIS
		REST query management interface

	.EXAMPLE

#>
using module "$pwd\repositories\QueryManager.ps1"
using module "$pwd\http\HTTPRequest.ps1"
class RestQueryManager : QueryManager {

	[string] $remote
    [string] $path
    [string] $apiKey

    RestQueryManager([string] $remote, [string] $path, [string] $apiKey) {
        $this.remote = $remote
		$this.path = $path
        $this.apiKey = $apiKey
    }

    <#
    	.DESCRIPTION
    		Gets an element by id

    	.SYNOPSIS
    		Retrieves an element by its id

    	.EXAMPLE
            [Object] object = $queryManager.getById([int] id)
    #>
    [Object] getById([string] $id) {
        $reader = $this.buildReader("/search/", "Get", $id, $this.apiKey);
        return $reader.read();
    }

    <#
    	.DESCRIPTION
    		Gets all elements from a list

    	.SYNOPSIS
    		Retrieves all elements from a given list

    	.EXAMPLE
            [Object] object = $queryManager.getAll()
    #>
    [Object] getAll() {
        $reader = $this.buildReader("/", "Get", $null, $this.apiKey);
        return $reader.read();
    }

    <#
    	.DESCRIPTION
    		Gets all elements from a list depending criteria

    	.SYNOPSIS
    		Retrieves all elements from a given list that respects given criteria

    	.EXAMPLE
            [Object] object = $queryManager.getAll([Object] request)
    #>
    [Object] get([Object] $request) {
        $reader = $this.buildReader("/search/", "Get", $null, $this.apiKey);
        return $reader.read();
    }

    [Object] buildReader([string] $separator, [string] $type, [string] $appender = $null,
                                [Object] $header = $null, [Object] $body = $null, [Object] $credential = $null) {
        $httpRequest = [HTTPRequest]::new($this.remote + $separator + $this.path + "/" + $appender, $type, $header, $body, $credential);
        $reader = [Object]::new($httprequest);
        return $reader;
    }
}
