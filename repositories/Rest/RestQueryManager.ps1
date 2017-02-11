<#
	.DESCRIPTION
		REST query management interface

	.SYNOPSIS
		REST query management interface

	.EXAMPLE

#>
. "$pwd\repositories\Rest\RestReader.ps1"
class RestQueryManager{

    [RestReader] $reader
	[string] $remote
    [string] $path

    RestQueryManager([RestReader] $reader, [string] $remote, [string] $path) {
        $this.reader = $reader
        $this.remote = $remote
		$this.path = $path
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
        $reader = $this.buildReader("/search/", "Get", $id);
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
    [Object[]] getAll() {
        $reader = $this.buildReader("/", "Get");
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
        $reader = $this.buildReader("/search/", "Get");
        return $reader.read();
    }

    [RestReader] buildReader([string] $separator, [string] $type, [string] $appender = $null,
                                [Object] $header = $null, [Object] $body = $null, [Object] $credential = $null) {
        $httpRequest = [HTTPRequest]::new($this.remote + $separator + $this.path + "/" + $appender, $type, $header, $body, $credential);
        $reader = [RestReader]::new($httprequest);
        return $reader;
    }
}
