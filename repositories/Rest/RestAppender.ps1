<#
	.DESCRIPTION
		Rest API appender interface

	.SYNOPSIS
		Rest API appender interface

	.EXAMPLE

#>
. "$pwd\repositories\Appender.ps1"
. "$pwd\repositories\Rest\RestWriter.ps1"
class RestAppender : Appender
{
    [RestWriter] $writer
    [string] $remote
    [string] $path

    RestAppender([RestWriter] $writer, [string] $remote, [string] $path) {
        $this.reader = $reader
        $this.remote = $remote
		$this.path = $path
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
	append([Object] $object) {
        $writer = $this.buildWriter("/", "Post", $null, $null, $object);
        $writer.write();
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
        $writer = $this.buildWriter("/", "Delete");
        $writer.write();
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
        $writer = $this.buildWriter("/", "Put", $id, $null, $object);
        $writer.write();
	}

    [RestWriter] buildWriter([string] $separator, [string] $type, [string] $appender = $null,
                                [Object] $header = $null, [Object] $body = $null, [Object] $credential = $null) {
        $httpRequest = [HTTPRequest]::new($this.remote + $separator + $this.path + "/" + $appender, $type, $header, $body, $credential);
        $writer = [RestWriter]::new($httprequest);
        return $writer;
    }
}
