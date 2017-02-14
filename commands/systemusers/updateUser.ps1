param(
    [parameter(Mandatory=$true, Position=0)] [string] $id
    [parameter(Mandatory=$true, Position=1)] [string] $email,
    [parameter(Mandatory=$true, Position=2)] [string] $username,
    [parameter(Mandatory=$false, Position=3)] [string] $password,
    [parameter(Mandatory=$false, Position=4)] [Bool] $allow_public_key = $False,
    [parameter(Mandatory=$false, Position=5)] [Bool] $passwordless_sudo = $False,
    [parameter(Mandatory=$false, Position=6)] [Bool] $sudo = $False,
    [parameter(Mandatory=$false, Position=7)] [string] $public_key = "",
    [parameter(Mandatory=$false, Position=8)] [int] $unix_uid = 0,
    [parameter(Mandatory=$false, Position=9)] [int] $unix_guid = 0,
    [parameter(Mandatory=$false, Position=10)] [Object[]] $tags = $null,
    [parameter(Mandatory=$false, Position=11)] [Object[]] $attributes = $null
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
            email = "$email";
            username = "$username";
            password = "$password";
            allow_public_key = "$allow_public_key";
            passwordless_sudo = "$passwordless_sudo";
            sudo = "$sudo";
            public_key = "$public_key";
            unix_uid = "$unix_uid";
            unix_guid = "$unix_guid";
            tags = "$tags";
            attributes = "$attributes"
        }

$result = Invoke-RestMethod -Method "Put" -Uri "https://console.jumpcloud.com/api/systemusers/$id" -Headers $header -Body $body

return $result
