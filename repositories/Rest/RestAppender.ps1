<#
	.DESCRIPTION
		Rest API appender interface

	.SYNOPSIS
		Rest API appender interface

	.EXAMPLE

#>
. ".\repositories\Appender.ps1"
. ".\http\HTTPRequest.ps1"
class RestAppender : Appender
{
    [string] $remote
    [string] $path
    [string] $apiKey

    RestAppender([string] $remote, [string] $path, [string] $apiKey) {
        $this.remote = $remote
		$this.path = $path
        $this.apiKey = $apiKey
    }
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
	[Object] append([Object] $object) {
        $writer = $this.buildWriter("/", "Post", $null, $this.apiKey, $object);
        return $writer.write();
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
	[Object] delete([string] $id) {
        $writer = $this.buildWriter("/", "Delete", $null, $this.apiKey);
        return $writer.write();
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
    [Object] update([string] $id, [Object] $object) {
        $writer = $this.buildWriter("/", "Put", $id, $this.apiKey, $object);
        return $writer.write();
	}

    [Object] buildWriter([string] $separator, [string] $type, [string] $appender = $null,
                                [Object] $header = $null, [Object] $body = $null, [Object] $credential = $null) {
        $httpRequest = [HTTPRequest]::new($this.remote + $separator + $this.path + "/" + $appender, $type, $header, $body, $credential);
        $writer = [Object]::new($httprequest);
        return $writer.write();
    }
}
