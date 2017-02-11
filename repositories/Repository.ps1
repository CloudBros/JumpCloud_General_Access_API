<#
	.DESCRIPTION
		Repository design pattern interface

	.SYNOPSIS
		Repository design pattern interface

	.EXAMPLE

#>
. "$pwd\repositories\Appender.ps1"
. "$pwd\repositories\QueryManager.ps1"
class Repository
{
    [Appender] $appender
    [QueryManager] $queryManager
    Repository([Appender] $appender, [QueryManager] $queryManager) {
        $this.appender = $appender
        $this.queryManager = $queryManager
    }
}
