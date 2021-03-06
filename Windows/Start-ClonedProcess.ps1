<#
if you want to open mulitple processes at once, have fun using Start-ClonedProcess

example usage and output:

PS> Start-ClonedProcess -Number 2 -Name Notepad.exe

VERBOSE: Now starting 2 instances of Notepad.exe..
VERBOSE: Launching Instance Number 1.
VERBOSE: Launching Instance Number 2.
VERBOSE: 2 instances of Notepad.exe have Launched.

#>

function Start-ClonedProcesses {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateRange(0, 10)] # this is an optional cap
        [Int32]$Number,
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [String]$Name
    )
    begin {
        $ErrorActionPreference = "Stop"
        $VerbosePreference = "Continue"
        $NumType = $Number.gettype().FullName

        if ($NumType -eq "System.Int32" -And $Number -eq 1) {
            Write-Verbose -Message "Now starting $Number instance of $Name.."
        } elseIf ($NumType -eq "System.Int32" -And $Number -gt 1 -And $Number -le 10)  {
            Write-Verbose -Message "Now starting $Number instances of $Name.."
        } else {
            Write-Error -Exception "Exception: The argument to InstanceNumber must be a whole number from 1 - 10" -ErrorAction Stop 
        }
    }
    process {
        for ($i = 1; $i -le $Number; $i++) {
            Write-Verbose -Message "Launching Instance Number $i."
            Start-Process $Name -Verb RunAs
            #Write-Progress -Activity "Launch Progression" -Status "$i% Complete:" -PercentComplete $i;
        }
    }
    end {
        if ($Number -eq 1) {
            Write-Verbose -Message "$Number instance of $Name has been Launched."
        } else {
            Write-Verbose -Message "$Number instances of $Name have Launched."    
        }
        $ErrorActionPreference = "Continue"
    }
}
