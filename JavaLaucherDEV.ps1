$string = "Lorem ipsum dolor sit amet, consectetur adipiscing elit.";
$measureObject = $string | Measure-Object -Character;
$count = $measureObject.Character;
Write-Host $count;



#########################################################
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

#########################################################

function CheckIsAdm{([System.String]$args)

    if ([System.String]::IsNullOrWhitespace($args)){
        $Env:AdminSystemName="Administrator";
        if (((GET-WinSystemLocale)[0].Name.ToUpper()) -eq ("PT-BR")){
            $Env:AdminSystemName="Administrador";
        }
        $id = [System.Security.Principal.WindowsIdentity]::GetCurrent();
        $p = New-Object System.Security.Principal.WindowsPrincipal($id);
        if ($p.IsInRole([System.Security.Principal.WindowsBuiltInRole]::$ENV:AdminSystemName)){
            return $true;
        }else{
            return $false;
        };
      ##throw "Please run this script as an administrator";
    }else {
        $Env:AdminSystemName=$args;
        $id = [System.Security.Principal.WindowsIdentity]::GetCurrent();
        $p = New-Object System.Security.Principal.WindowsPrincipal($id);
        if ($p.IsInRole([System.Security.Principal.WindowsBuiltInRole]::$ENV:AdminSystemName)){
            return $true;
        }else{
            return $false;
        };
    };
};
CheckIsAdm("Administrator");

function CheckIsAdm{
    $Env:AdminSystemName="Administrator";
    if (((GET-WinSystemLocale)[0].Name.ToUpper()) -eq ("PT-BR")){
        $Env:AdminSystemName="Administrador";
    }
    $id = [System.Security.Principal.WindowsIdentity]::GetCurrent();
    $p = New-Object System.Security.Principal.WindowsPrincipal($id);
    if ($p.IsInRole([System.Security.Principal.WindowsBuiltInRole]::$ENV:AdminSystemName)){
        return $true;
    }else{
        return $false;
    };
};



$envCharPatch = $args;
$envCharPatch = $envCharPatch.substring($envCharPatch.Length-1 ,1);
if (($envCharPatch.ToUpper()) -eq (";")){
    return $true;
} else {
    return $false;
};