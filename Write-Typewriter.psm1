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
        Start-Sleep -Milliseconds 100;
        Write-Host -NoNewLine "`r";

        $i = 0;

        for(; $i -lt $line.Length - 1; $i++) {
            Start-Sleep -Milliseconds 100;
            $output = ($line[0..$i] -join "");
            Write-Host -NoNewLine "`r$output";
            $greatestLength = $output.Length;
        }

        Start-Sleep -Milliseconds 100;
        Write-Host "`r$line";

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
        Start-Sleep -Milliseconds 100;
        Write-Host -NoNewLine "`r";

        $i = 0;
        $greatestLength = 0;

        for(; $i -lt $line.Length; $i++) {
            Start-Sleep -Milliseconds 100;
            $output = ($line[0..$i] -join "");
            Write-Host -NoNewLine "`r$output";
            $greatestLength = $output.Length;
        }

        for(; $i -ge 0; $i--) {
            Start-Sleep -Milliseconds 50;
            $output = ($line[0..$i] -join "").PadRight($greatestLength);
            Write-Host -NoNewLine "`r$output";
            $greatestLength = $output.Length;
        }

        Start-Sleep -Milliseconds 50;
        Write-Host -NoNewLine "`r";

    }
}
Set-Alias Typewriter Out-Typewriter;

Export-ModuleMember -Function Write-Typewriter -Alias Typewriter;