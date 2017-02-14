param(
    [parameter(Mandatory=$true, Position=0)] [string] $name,
    [parameter(Mandatory=$false, Position=1)] [Object[]] $systems,
    [parameter(Mandatory=$false, Position=2)] [Object[]] $systemUsers,
    [parameter(Mandatory=$false, Position=3)] [DateTime] $expirationDate
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
        name = $name;
        systems = $systems;
        systemUsers = $systemUsers;
        expirationDate = $expirationDate;
    }

$result = Invoke-RestMethod -Method "Put" -Uri "https://console.jumpcloud.com/api/tags/$id" -Headers $header -Body $body

return $result
