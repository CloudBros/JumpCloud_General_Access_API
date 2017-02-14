param(
    [parameter(Mandatory=$true, Position=0)] [string] $id
    [parameter(Mandatory=$true, Position=1)] [string[]] $add,
	[parameter(Mandatory=$true, Position=2)] [string[]] $remove
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
            add = $add;
            remove = $remove
        }

$result = Invoke-RestMethod -Method "Put" -Uri "https://console.jumpcloud.com/api/systemusers/${id}/systems" -Headers $header -Body $body

return $result
