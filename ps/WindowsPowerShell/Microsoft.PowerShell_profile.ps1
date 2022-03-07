import-module z

function .. { cd .. }
function ... { cd .. ; cd .. }
function .... { cd .. ; cd .. ; cd .. }
function ..... { cd .. ; cd .. ; cd .. ; cd .. }
function c. {code .}
function o. {explorer.exe .}
function home { cd $env:USERPROFILE }
function cdc { cd $env:USERPROFILE/Code }
function gaa { git add -A }
function gcm { git commit -m }
function gcl { git clone }
function gf { git fetch --all -p }
function gps { git push }
function gs { git status -sb }
function gsw { git switch }
function l { Get-ChildItem }
function cdpp { code $env:USERPROFILE/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1 }
function rmd ($dir){ Remove-Item -Recurse -Force $dir }

Function Invoke-Exa {
	Param (
		[string]$Path = "./",
		[switch]$Recurse
	)
	if ($Recurse) {
		$r = "--recurse"
	}
	$fullPath = (Get-Item $Path).FullName
	$linuxPath = "/mnt/" + $fullPath[0].ToString().ToLower() + ($fullPath.Substring(2) -replace "\\","/")
	& bash.exe -c "/home/th3g3ntl3man/.cargo/bin/exa --icons --group-directories-first -l $r $linuxPath"
}

Set-Alias la Invoke-Exa

#search on google
function gg ($query){ Start-Process "www.google.com/search?q=$query"}



Import-Module posh-git

Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Chord Ctrl+a -Function BeginningOfLine
Set-PSReadLineKeyHandler -Chord Ctrl+e -Function EndOfLine
Set-PSReadLineKeyHandler -Chord Alt+LeftArrow -Function BackwardWord
Set-PSReadLineKeyHandler -Chord Alt+RightArrow -Function NextWord
Set-PSReadlineOption -BellStyle None

function Test-Administrator
{
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

# Set up a simple prompt, adding the git prompt parts inside git repos
function global:prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    Write-Host($pwd.ProviderPath) -nonewline -ForegroundColor Gray

    Write-VcsStatus
    Write-Host
    $global:LASTEXITCODE = $realLASTEXITCODE
    if (Test-Administrator) {
        Write-Host -NoNewline -ForegroundColor Red "Administrator $env:USERNAME "
    }
    return "$ "
}

function t {
    wsl.exe -d Ubuntu-20.04 ~/bin/t
}


