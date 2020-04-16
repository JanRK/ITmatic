Set-TimeZone -id "Romance Standard Time"

# Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
# choco install wget curl 7zip -y
$url="https://octopus.com/downloads/latest/WindowsX64/OctopusTentacle"
$temppath=[system.io.path]::GetTempPath()
echo "$temppath"
(New-Object System.Net.WebClient).DownloadFile($url, "$temppath\octo.exe")

Start-Process msiexec.exe -Wait -ArgumentList "/I $temppath\octo.exe /quiet"

$metadata=Invoke-RestMethod -Headers @{'Metadata-Flavor'='Google'} -Uri 'http://metadata.google.internal/computeMetadata/v1/?recursive=true'
$octothumb=$metadata.instance.attributes.octopus

$tentaclefile=((Get-Childitem -Path "$Env:ProgramFiles(x86)","$Env:ProgramFiles" -Include "Tentacle.exe" -File -Recurse -ErrorAction SilentlyContinue) | where { $_.Directory -Like "*Octopus*" } | select -first 1).FullName

& $tentaclefile create-instance --instance "Tentacle" --config "C:\Octopus\Tentacle.config" --console
& $tentaclefile new-certificate --instance "Tentacle" --if-blank --console
& $tentaclefile show-thumbprint --instance "Tentacle" --nologo
& $tentaclefile configure --instance "Tentacle" --reset-trust --console
& $tentaclefile configure --instance "Tentacle" --home "C:\Octopus" --app "C:\Octopus\Applications" --port "10933" --console
& $tentaclefile configure --instance "Tentacle" --trust $octothumb --console
netsh advfirewall firewall add rule "name=Octopus Deploy Tentacle" dir=in action=allow protocol=TCP localport=10933
# & $tentaclefile register-with --instance "Tentacle" --server "http://YOUR_OCTOPUS" --apiKey="API-YOUR_API_KEY" --role "web-server" --environment "Staging" --comms-style TentaclePassive --console
& $tentaclefile service --instance "Tentacle" --install --start --console
