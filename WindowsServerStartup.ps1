Set-TimeZone -id "Romance Standard Time"

# Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
# choco install wget curl 7zip -y
$url="https://octopus.com/downloads/latest/WindowsX64/OctopusTentacle"
(New-Object System.Net.WebClient).DownloadFile($url, "$pwd\octo.exe")

Start-Process msiexec.exe -Wait -ArgumentList "/I $pwd\octo.exe /quiet"

$metadata=Invoke-RestMethod -Headers @{'Metadata-Flavor'='Google'} -Uri 'http://metadata.google.internal/computeMetadata/v1/?recursive=true'
$octothumb=$metadata.instance.attributes.octopus

$tentacledir="C:\Program Files\Octopus Deploy\Tentacle"

$tentacledir/Tentacle.exe create-instance --instance "Tentacle" --config "C:\Octopus\Tentacle.config" --console
$tentacledir/Tentacle.exe new-certificate --instance "Tentacle" --if-blank --console
$tentacledir/Tentacle.exe configure --instance "Tentacle" --reset-trust --console
$tentacledir/Tentacle.exe configure --instance "Tentacle" --home "C:\Octopus" --app "C:\Octopus\Applications" --port "10933" --console
$tentacledir/Tentacle.exe configure --instance "Tentacle" --trust $octothumb --console
netsh advfirewall firewall add rule "name=Octopus Deploy Tentacle" dir=in action=allow protocol=TCP localport=10933
# $tentacledir/Tentacle.exe register-with --instance "Tentacle" --server "http://YOUR_OCTOPUS" --apiKey="API-YOUR_API_KEY" --role "web-server" --environment "Staging" --comms-style TentaclePassive --console
$tentacledir/Tentacle.exe service --instance "Tentacle" --install --start --console
