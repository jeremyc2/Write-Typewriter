<#
.SYNOPSIS

Fancy display text from file

.DESCRIPTION

Display text to console from a file.
Letter-by-letter.

.PARAMETER Filename
Specifies the file name.

.PARAMETER Erase
Switch. Erase each line after writing it?

#>
function Write-Typewriter {
    Param (
        [Parameter(Mandatory=$true,
                    Position=0)]
        [String]
        $Filename,
        [Parameter(Mandatory=$false,
                   Position=1)]
        [Switch]
        $Erase
    )

    if($Erase) {
        & ReadAndErase $Filename
    } else {
        & ReadNormal $Filename
    }

}

function ReadNormal {

    Param (
        [Parameter(Mandatory=$true,
                    Position=0)]
        [String]
        $Filename
    )

    foreach($line in (Get-Content $Filename)){

        foreach($char in $line.toCharArray()) {
            Start-Sleep -Milliseconds 100;
            Write-Host -NoNewLine $char;
        }

        Write-Host;

    }
}

function ReadAndErase {

    Param (
        [Parameter(Mandatory=$true,
                    Position=0)]
        [String]
        $Filename
    )

    foreach($line in (Get-Content $Filename)){

        foreach($char in $line.toCharArray()) {
            Start-Sleep -Milliseconds 100;
            Write-Host -NoNewLine $char;
        }

        $i = $line.Length;

        while($i -ge 0) {
            Start-Sleep -Milliseconds 50;
            $output = ($line[0..$i] -join "") + " ";
            Write-Host -NoNewLine "`r$output";
            $i--;
        }

        Write-Host -NoNewLine "`r ";
        Write-Host -NoNewLine "`r";
        Start-Sleep -Milliseconds 1000;

    }
}
Set-Alias Typewriter Write-Typewriter;

Export-ModuleMember -Function Write-Typewriter -Alias Typewriter;
