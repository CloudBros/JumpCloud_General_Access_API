param(
    [parameter(Mandatory=$true, Position=0)] [string] $command,
    [parameter(Mandatory=$true, Position=1)] [string] $user,
    [parameter(Mandatory=$false, Position=2)] [string] $name,
    [parameter(Mandatory=$false, Position=3)] [Object[]] $systems,
    [parameter(Mandatory=$false, Position=4)] [string] $schedule,
    [parameter(Mandatory=$false, Position=5)] [Object[]] $files,
    [parameter(Mandatory=$false, Position=6)] [Object[]] $tags,
    [parameter(Mandatory=$false, Position=3)] [string] $timeout
)
function Ignore-SelfSignedCerts
{
    try
    {

        Write-Host "Adding TrustAllCertsPolicy type." -ForegroundColor White
        Add-Type -TypeDefinition  @"
        using System.Net;
        using System.Security.Cryptography.X509Certificates;
        public class TrustAllCertsPolicy : ICertificatePolicy
        {
             public bool CheckValidationResult(
             ServicePoint srvPoint, X509Certificate certificate,
             WebRequest request, int certificateProblem)
             {
                 return true;
            }
        }
"@

        Write-Host "TrustAllCertsPolicy type added." -ForegroundColor White
      }
    catch
    {
        Write-Host $_ -ForegroundColor "Yellow"
    }

    [System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
}

Ignore-SelfSignedCerts

$apiKey = cat "..\..\api.key"
$header = @{
                "x-api-key" = $apiKey
            }
$body = @{
        command = $command;
        user = $user;
        name = $name;
        systems = $systems;
        schedule = $schedule;
        files = $files;
        tags = $tags;
        timeout = $timeout
    }

$result = Invoke-RestMethod -Method "Put" -Uri "https://console.jumpcloud.com/api/commands/$id" -Headers $header -Body $body

return $result
