param(
    [parameter(Mandatory=$false, Position=0)] [string] $displayName = "DEFAULT_NAME",
    [parameter(Mandatory=$false, Position=1)] [Bool] $allowSshPasswordAuthentication = $False,
    [parameter(Mandatory=$false, Position=2)] [Bool] $allowSshRootLogin = $False,
    [parameter(Mandatory=$false, Position=3)] [Bool] $allowMultiFactorAuthentication = $False,
    [parameter(Mandatory=$false, Position=4)] [Bool] $allowPublicKeyAuthentication = $False,
    [parameter(Mandatory=$false, Position=5)] [Object[]] $tags = $null,
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
            displayName = $displayName;
            allowSshPasswordAuthentication = $allowSshPasswordAuthentication;
            allowSshRootLogin = $allowSshRootLogin;
            allowMultiFactorAuthentication = $allowMultiFactorAuthentication;
            allowPublicKeyAuthentication = $allowPublicKeyAuthentication;
            tags = $tags
        }

$result = Invoke-RestMethod -Method "Put" -Uri "https://console.jumpcloud.com/api/systems/$id" -Headers $header -Body $body

return $result
