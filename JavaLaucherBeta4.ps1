$JavaRocketLauncher  = {

    ## Set-ExecutionPolicy -ExecutionPolicy Unrestricted
    ## @id:terminal.integrated.commandsToSkipShell,terminal.integrated.sendKeybindingsToShell,terminal.integrated.allowChords
    ## powershell.exe -NoLogo -NoProfile -Command '[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Install-Module -Name PackageManagement -Force -MinimumVersion 1.4.6 -Scope CurrentUser -AllowClobber -Repository PSGallery'
    ## powershell.exe -NoLogo -NoProfile -Command '[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Install-Module -Name PackageManagement -Force -MinimumVersion 1.4.6 -Scope CurrentUser -AllowClobber -Repository PSGallery'
    $enableWriteOutputDebug = $true;
    function WriteOutputDebug([System.Boolean]$showMsg, [System.String]$textMsg) {
        if ($showMsg) {
            Write-Output $textMsg;
        };
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
                WriteOutputDebug ($enableWriteOutputDebug)("Env:JAVA_HOME: [NULL]");
                $Env:JAVA_HOME = $Env:JAVA_HOME_PATH;
                WriteOutputDebug ($enableWriteOutputDebug)("Env:JAVA_HOME: [" + ($(Get-ChildItem Env:JAVA_HOME)[0].Value.ToString()) + "] NEW");
            }
            else {
                WriteOutputDebug ($enableWriteOutputDebug)("Env:JAVA_HOME: [" + ($(Get-ChildItem Env:JAVA_HOME)[0].Value.ToString()) + "] OLD");
                if (($Env:JAVA_HOME) -cne ($Env:JAVA_HOME_PATH)) {
                    $Env:JAVA_HOME = $Env:JAVA_HOME_PATH;
                    WriteOutputDebug ($enableWriteOutputDebug)("Env:JAVA_HOME: [" + ($(Get-ChildItem Env:JAVA_HOME)[0].Value.ToString()) + "] REPLANCE ");
                }
                else {
                    WriteOutputDebug ($enableWriteOutputDebug)("Env:JAVA_HOME: [" + ($(Get-ChildItem Env:JAVA_HOME)[0].Value.ToString()) + "] NOW ");
                };
            };
        }
        else {
            throw "Please Contact System Administrator [ERRO] Set-Java_HOME";
        };
    }; 

    function Set-Java_JDK([System.String]$textMsg) {
        if (IsValidString($textMsg)) {
            $Env:JDK_HOME_DIR = $textMsg;
            if (($Env:JDK_HOME) -eq ($null)) {
                WriteOutputDebug ($enableWriteOutputDebug)("Env:JDK_HOME: [NULL]");
                $Env:JDK_HOME = $Env:JDK_HOME_DIR;
                WriteOutputDebug ($enableWriteOutputDebug)("Env:JDK_HOME: [" + ($(Get-ChildItem Env:JDK_HOME)[0].Value.ToString()) + "] NEW");
            }
            else {
                WriteOutputDebug ($enableWriteOutputDebug)("Env:JDK_HOME: [" + ($(Get-ChildItem Env:JDK_HOME)[0].Value.ToString()) + "] OLD");
                if (($Env:JDK_HOME) -cne ($Env:JDK_HOME_DIR)) {
                    $Env:JDK_HOME = $Env:JDK_HOME_DIR;
                    WriteOutputDebug ($enableWriteOutputDebug)("Env:JDK_HOME: [" + ($(Get-ChildItem Env:JDK_HOME)[0].Value.ToString()) + "] REPLANCE ");
                }
                else {
                    WriteOutputDebug ($enableWriteOutputDebug)("Env:JDK_HOME: [" + ($(Get-ChildItem Env:JDK_HOME)[0].Value.ToString()) + "] NOW ");
                };
            };
        }
        else {
            throw "Please Contact System Administrator [ERRO] Set-Java_JDK";
        };
    };

    function Set-Java_JRE([System.String]$textMsg) {
        if (IsValidString($textMsg)) {
            $Env:JRE_HOME_DIR = $textMsg;
            if (($Env:JRE_HOME) -eq ($null)) {
                WriteOutputDebug ($enableWriteOutputDebug)("Env:JRE_HOME: [NULL]");
                $Env:JRE_HOME = $Env:JRE_HOME_DIR;
                WriteOutputDebug ($enableWriteOutputDebug)("Env:JRE_HOME: [" + ($(Get-ChildItem Env:JRE_HOME)[0].Value.ToString()) + "] NEW");
            }
            else {
                WriteOutputDebug ($enableWriteOutputDebug)("Env:JRE_HOME: [" + ($(Get-ChildItem Env:JRE_HOME)[0].Value.ToString()) + "] OLD");
                if (($Env:JRE_HOME) -cne ($Env:JRE_HOME_DIR)) {
                    $Env:JRE_HOME = $Env:JRE_HOME_DIR;
                    WriteOutputDebug ($enableWriteOutputDebug)("Env:JRE_HOME: [" + ($(Get-ChildItem Env:JRE_HOME)[0].Value.ToString()) + "] REPLANCE ");
                }
                else {
                    WriteOutputDebug ($enableWriteOutputDebug)("Env:JRE_HOME: [" + ($(Get-ChildItem Env:JRE_HOME)[0].Value.ToString()) + "] NOW ");
                };
            };
        }
        else {
            throw "Please Contact System Administrator [ERRO] Set-Java_JRE";
        };
    };

    function Set-Java_CLASSPATH([System.String]$textMsg) {
        if (IsValidString($textMsg)) {
            $Env:CLASSPATH_DIR = $textMsg;
            if (($Env:CLASSPATH) -eq ($null)) {
                WriteOutputDebug ($enableWriteOutputDebug)("Env:CLASSPATH: [NULL]");
                $Env:CLASSPATH = $Env:CLASSPATH_DIR;
                WriteOutputDebug ($enableWriteOutputDebug)("Env:CLASSPATH: [" + ($(Get-ChildItem Env:CLASSPATH)[0].Value.ToString()) + "] NEW");
            }
            else {
                WriteOutputDebug ($enableWriteOutputDebug)("Env:CLASSPATH: [" + ($(Get-ChildItem Env:CLASSPATH)[0].Value.ToString()) + "] OLD");
                if (($Env:CLASSPATH) -cne ($Env:CLASSPATH_DIR)) {
                    $Env:CLASSPATH = $Env:CLASSPATH_DIR;
                    WriteOutputDebug ($enableWriteOutputDebug)("Env:CLASSPATH: [" + ($(Get-ChildItem Env:CLASSPATH)[0].Value.ToString()) + "] REPLANCE ");
                }
                else {
                    WriteOutputDebug ($enableWriteOutputDebug)("Env:CLASSPATH: [" + ($(Get-ChildItem Env:CLASSPATH)[0].Value.ToString()) + "] NOW ");
                };
            };
        }
        else {
            throw "Please Contact System Administrator [ERRO] Set-Java_CLASSPATH";
        };
    };

    function Set-Java_PATH([System.String]$textMsg) {
        if (IsValidString($textMsg)) {
            $Env:PATH_DIR = $textMsg;
            if (($Env:PATH) -eq ($null)) {
                WriteOutputDebug ($enableWriteOutputDebug)("Env:PATH: [NULL]");
                if (CheckIsAdm) {
                    $Env:PATH = $Env:PATH_DIR;
                }
                else {
                    $Env:PATH = $Env:PATH_DIR + ";";
                };
                WriteOutputDebug ($enableWriteOutputDebug)("Env:PATH: [" + ($(Get-ChildItem Env:PATH)[0].Value.ToString()) + "] NEW");
            }
            else {
                WriteOutputDebug ($enableWriteOutputDebug)("Env:PATH: [" + ($(Get-ChildItem Env:PATH)[0].Value.ToString()) + "] OLD");
                if (($Env:PATH) -notlike ("*$Env:PATH_DIR*")) {
                    if (IsEndStringPatch($Env:PATH)) {
                        $Env:PATH = $Env:PATH + ";" + $Env:PATH_DIR + ";";
                    }
                    else {
                        $Env:PATH = $Env:PATH + ";" + $Env:PATH_DIR;
                        
                    };
                    WriteOutputDebug ($enableWriteOutputDebug)("Env:PATH: [" + ($(Get-ChildItem Env:PATH)[0].Value.ToString()) + "] REPLANCE ");
                }
                else {
                    WriteOutputDebug ($enableWriteOutputDebug)("Env:PATH: [" + ($(Get-ChildItem Env:PATH)[0].Value.ToString()) + "] NOW ");
                };
            };
        }
        else {
            throw "Please Contact System Administrator [ERRO] Set-Java_PATH";
        };
    };
    #Set-Java_PATH($(Get-ChildItem Env:JAVA_HOME)[0].Value.ToString() + "\bin");
 
    Set-Java_HOME("C:\JAVA\JDK");
    Set-Java_JDK($(Get-ChildItem Env:JAVA_HOME)[0].Value.ToString());
    Set-Java_JRE($(Get-ChildItem Env:JAVA_HOME)[0].Value.ToString() + "\jre");
    Set-Java_CLASSPATH($(Get-ChildItem Env:JAVA_HOME)[0].Value.ToString() + "\lib");
    Set-Java_PATH($(Get-ChildItem Env:JAVA_HOME)[0].Value.ToString() + "\bin");
}; & Invoke-Command $JavaRocketLauncher;