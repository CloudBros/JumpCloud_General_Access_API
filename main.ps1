using module ".\repositories\Repository.ps1"
using module ".\repositories\Rest\RestAppender.ps1"
using module ".\repositories\Rest\RestQueryManager.ps1"

param (
    [parameter(Mandatory=$true, Position=0)] [string] $target,
    [parameter(Mandatory=$true, Position=1)] [string] $action,
    [parameter(Mandatory=$false, Position=2)] [string] $keyFile = ".\api.key",
    [parameter(Mandatory=$false, Position=3)] [string] $id = $null,
    [parameter(Mandatory=$false, Position=4)] [Object] $argument = $null
)

$actions = ("Add", "GetById", "GetAll", "Search", "Update", "Delete")
$apiKey = cat $keyFile

$remote = "https://console.jumpcloud.com/api/"

$queryManager = [RestQueryManager]::new($remote, $target, $apiKey)
$appender = [RestAppender]::new($remote, $target, $apiKey)
$repository =  [Repository]::new($appender, $queryManager)

$actionIndex = $actions.indexOf($action)
$output = "Nothing to output"

if($actionIndex -ne -1) {
    $output = "Success"
    switch ($actionIndex) {
        0 { $output = $repository.appender.append($argument) }
        1 { $output = $repository.queryManager.getById($id) }
        2 { $output = $repository.queryManager.getAll() }
        3 { $output = $repository.queryManager.get($argument) }
        4 { $output = $repository.appender.update($id, $argument) }
        5 { $output = $repository.appender.delete($id) }
    }
}

else {
    $output = "Wrong action has been given"
}

echo $output
