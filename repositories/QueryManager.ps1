<#
	.DESCRIPTION
		Query management interface

	.SYNOPSIS
		Query management interface

	.EXAMPLE

#>
. ".\repositories\Reader.ps1"
class QueryManager {
	[Object] $reader

    <#
    	.DESCRIPTION
    		Gets an element by id

    	.SYNOPSIS
    		Retrieves an element by its id

    	.EXAMPLE
            [Object] object = $queryManager.getById([int] id)
    #>

    [Object] getById([string] $id) {
        echo "Not Yet Implemented"
        return $null
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
        echo "Not Yet Implemented"
        return $null
    }

    <#
    	.DESCRIPTION
    		Gets all elements from a list depending criteria

    	.SYNOPSIS
    		Retrieves all elements from a given list that respects given criteria

    	.EXAMPLE
            [Object] object = $queryManager.getAll([Object] request)
    #>
    [Object[]] get([Object] $request) {
        echo "Not Yet Implemented"
        return $null
    }
}
