using module "$pwd\repositories\Appender.ps1"
using module "$pwd\repositories\QueryManager.ps1"
<#
	.DESCRIPTION
		Repository design pattern interface

	.SYNOPSIS
		Repository design pattern interface

	.EXAMPLE

#>
class Repository
{
    [Object] $appender
    [Object] $queryManager
    Repository([Object] $appender, [Object] $queryManager) {
        $this.appender = $appender
        $this.queryManager = $queryManager
    }
}
