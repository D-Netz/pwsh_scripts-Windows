#safer way to download an ISO

$url = "enter_url_here"
$output = "$PSScriptRoot\enter_filename_here"
$start_time = Get-Date

Import-Module BitsTransfer
Start-BitsTransfer -Source $url -Destination $output

#OR to download in the background
Start-BitsTransfer -Source $url -Destination $output -Asynchronous

# get hash from site
$hash = "Enter_hash_here"

#get hash from downloade file
$file = Get-FileHash -Algorithm SHA512 -Path .\iso_name.iso

#compare hashes, SHA is case insensitive
$hash -eq $file.Hash

#if true
.\iso_name.iso
