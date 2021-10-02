$string = "Lorem ipsum dolor sit amet, consectetur adipiscing elit.";
$measureObject = $string | Measure-Object -Character;
$count = $measureObject.Character;
Write-Host $count;

function validarPatchString {([System.String]$args)
    ## [bool]([string]::IsNullOrWhitespace($args));
    if ([string]::IsNullOrWhitespace($args)){
        throw "Please run this script as an administrator";
    }else {
        $envCharPatch = $args;
        $envCharPatch = $envCharPatch.substring($envCharPatch.Length-1 ,1);
        if (($envCharPatch.ToUpper()) -eq (";")){
            return $true;
        } else {
            return $false;
        };
    };  
};
#validarPatchString;
##validarPatchString($null);
validarPatchString ($(Get-ChildItem Env:JACX)[0].Value.ToString());








$envCharPatch = $args;
$envCharPatch = $envCharPatch.substring($envCharPatch.Length-1 ,1);
if (($envCharPatch.ToUpper()) -eq (";")){
    return $true;
} else {
    return $false;
};