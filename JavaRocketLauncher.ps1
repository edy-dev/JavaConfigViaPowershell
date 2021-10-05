$JavaRocketLauncher = {

    ## Set-ExecutionPolicy -ExecutionPolicy Unrestricted
    ## @id:terminal.integrated.commandsToSkipShell,terminal.integrated.sendKeybindingsToShell,terminal.integrated.allowChords
    ## powershell.exe -NoLogo -NoProfile -Command '[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Install-Module -Name PackageManagement -Force -MinimumVersion 1.4.6 -Scope CurrentUser -AllowClobber -Repository PSGallery'
    ## powershell.exe -NoLogo -NoProfile -Command '[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Install-Module -Name PackageManagement -Force -MinimumVersion 1.4.6 -Scope CurrentUser -AllowClobber -Repository PSGallery'

    function Get-AllEnvironmentVariables {
        $(Get-ChildItem Env:)
    };
    function IsValidString([System.String]$textMsg) {
        if (([System.String]::IsNullOrEmpty($textMsg)) -And ([System.String]::IsNullOrWhitespace($textMsg))) {
            return $false;
        }
        else {
            return $true;
        };
    };

    function IsEndStringPatch([System.String]$textMsg) {
        if (IsValidString($textMsg)) {
            $envCharPatch = $textMsg;
            $envCharPatch = $envCharPatch.substring($envCharPatch.Length - 1 , 1);
            if (($envCharPatch.ToUpper()) -eq (";")) {
                return $true;
            }
            else {
                return $false;
            };
        }
        else {
            throw "Please Contact System Administrator [ERRO] IsEndStringPatch";
        };  
    };

    function CheckIsAdm {
        $AdminSystemName = "Administrator";
        if (((GET-WinSystemLocale)[0].Name.ToUpper()) -eq ("PT-BR")) {
            $AdminSystemName = "Administrador";
        }
        $id = [System.Security.Principal.WindowsIdentity]::GetCurrent();
        $p = New-Object System.Security.Principal.WindowsPrincipal($id);
        if ($p.IsInRole([System.Security.Principal.WindowsBuiltInRole]::$AdminSystemName)) {
            return $true;
        }
        else {
            return $false;
        };
    };

    function Set-Java_HOME([System.String]$textMsg) {
        if (IsValidString($textMsg)) {
            $Env:JAVA_HOME_PATH = $textMsg;
            if (($Env:JAVA_HOME) -eq ($null)) {
                $Env:JAVA_HOME = $Env:JAVA_HOME_PATH;
            }
            else {
                if (($Env:JAVA_HOME) -cne ($Env:JAVA_HOME_PATH)) {
                    $Env:JAVA_HOME = $Env:JAVA_HOME_PATH;
                };
            };
        }
        else {
            throw "Please Contact System Administrator [ERRO] Set-Java_HOME";
        };
        Remove-Item -Path Env:JAVA_HOME_PATH;
    }; 

    function Set-Java_JDK([System.String]$textMsg) {
        if (IsValidString($textMsg)) {
            $Env:JDK_HOME_DIR = $textMsg;
            if (($Env:JDK_HOME) -eq ($null)) {
                $Env:JDK_HOME = $Env:JDK_HOME_DIR;
            }
            else {
                if (($Env:JDK_HOME) -cne ($Env:JDK_HOME_DIR)) {
                    $Env:JDK_HOME = $Env:JDK_HOME_DIR;
                };
            };
        }
        else {
            throw "Please Contact System Administrator [ERRO] Set-Java_JDK";
        };
        Remove-Item -Path Env:JDK_HOME_DIR;
    };

    function Set-Java_JRE([System.String]$textMsg) {
        if (IsValidString($textMsg)) {
            $Env:JRE_HOME_DIR = $textMsg;
            if (($Env:JRE_HOME) -eq ($null)) {
                $Env:JRE_HOME = $Env:JRE_HOME_DIR;
            }
            else {
                if (($Env:JRE_HOME) -cne ($Env:JRE_HOME_DIR)) {
                    $Env:JRE_HOME = $Env:JRE_HOME_DIR;
                };
            };
        }
        else {
            throw "Please Contact System Administrator [ERRO] Set-Java_JRE";
        };
        Remove-Item -Path Env:JRE_HOME_DIR;
    };

    function Set-Java_CLASSPATH([System.String]$textMsg) {
        if (IsValidString($textMsg)) {
            $Env:CLASSPATH_DIR = $textMsg;
            if (($Env:CLASSPATH) -eq ($null)) {
                $Env:CLASSPATH = $Env:CLASSPATH_DIR;
            }
            else {
                if (($Env:CLASSPATH) -cne ($Env:CLASSPATH_DIR)) {
                    $Env:CLASSPATH = $Env:CLASSPATH_DIR;
                };
            };
        }
        else {
            throw "Please Contact System Administrator [ERRO] Set-Java_CLASSPATH";
        };
        Remove-Item -Path Env:CLASSPATH_DIR;
    };

    function Set-Java_PATH([System.String]$textMsg) {
        if (IsValidString($textMsg)) {
            $Env:PATH_DIR = $textMsg;
            if (($Env:PATH) -eq ($null)) {
                if (CheckIsAdm) {
                    $Env:PATH = $Env:PATH_DIR;
                }
                else {
                    $Env:PATH = $Env:PATH_DIR + ";";
                };
            }
            else {
                if (($Env:PATH) -notlike ("*$Env:PATH_DIR*")) {
                    if (IsEndStringPatch($Env:PATH)) {
                        $Env:PATH = $Env:PATH + ";" + $Env:PATH_DIR + ";";
                    }
                    else {
                        $Env:PATH = $Env:PATH + ";" + $Env:PATH_DIR;
                    };
                };
            };
        }
        else {
            throw "Please Contact System Administrator [ERRO] Set-Java_PATH";
        };
        Remove-Item -Path Env:PATH_DIR;
    };
 
    Set-Java_HOME("C:\JAVA\JDK");
    Set-Java_JDK($(Get-ChildItem Env:JAVA_HOME)[0].Value.ToString());
    Set-Java_JRE($(Get-ChildItem Env:JAVA_HOME)[0].Value.ToString() + "\jre");
    Set-Java_CLASSPATH($(Get-ChildItem Env:JAVA_HOME)[0].Value.ToString() + "\lib");
    Set-Java_PATH($(Get-ChildItem Env:JAVA_HOME)[0].Value.ToString() + "\bin");
    Get-AllEnvironmentVariables;
}; & Invoke-Command $JavaRocketLauncher;