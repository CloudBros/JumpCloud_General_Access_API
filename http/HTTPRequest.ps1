#####################################################
#													#
# Class designed to do HTTP request over REST API   #
#													#
#####################################################
class HTTPRequest
{
    [string] $url
    [string] $type
    [Object] $header
    [Object] $body
    [Object] $credential

    HTTPRequest([string] $url, [string] $type) {
        $this.url = $url;
        $this.type = $type;
    }

    HTTPRequest([string] $url, [string] $type, [Object] $header) {
        $this.url = $url;
        $this.type = $type;
        $this.header = $header;
    }

    HTTPRequest([string] $url, [string] $type, [Object] $header, [Object] $body) {
        $this.url = $url;
        $this.type = $type;
        $this.header = $header;
        $this.body = $body;
    }

    HTTPRequest([string] $url, [string] $type, [Object] $header, [Object] $body, [Object] $credential) {
        $this.url = $url;
        $this.type = $type;
        $this.header = $header;
        $this.body = $body;
        $this.credential = $credential;
    }

    [Object] call() {
        $result = Invoke-RestMethod -Method $this.type -Uri $this.url -Headers $this.header -Body $this.body -Credential $this.credential
        return $result;
    }
}
