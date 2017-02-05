. ".\http\HTTPRequest.ps1"
$url = "https://blogs.msdn.microsoft.com/powershell/feed";
$http = [HTTPRequest]::new($url, "Get");
$result = $http.call();

$result;
