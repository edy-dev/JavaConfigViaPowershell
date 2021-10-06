$JavaRocketLauncher = {

    $enableWriteOutputDebug = $true;
    function WriteOutputDebug([System.Boolean]$executeDebug, [System.String]$textDebug) {
        if ($executeDebug) {
            Write-Output $textDebug;
        };
    };

    function Get-AllEnvironmentVariables {
        $(Get-ChildItem Env:);
    };
    function IsValidString([System.String]$textmsgErr) {
        if (([System.String]::IsNullOrEmpty($textmsgError)) -And ([System.String]::IsNullOrWhitespace($textmsgErr))) {
            return $false;
        }
        else {
            return $true;
        };
    };

    function IsEndStringPatch([System.String]$textmsgErro) {
        if (IsValidString($textmsgErr)) {
            $envCharPatch = $textmsgError;
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
 
    function Set-EnvironmentCreate([System.String]$textEnvironment, [System.String]$textValue, [System.EnvironmentVariableTarget]$textTarget) {
        
        [System.String[]]$N_N_N = (
            "NULL -> NEW", 
            "OLD  != NEW", 
            "OLD  == NOW");

        $cmdSetEnvironmentVariable = { [System.Environment]::SetEnvironmentVariable([System.String]$textEnvironment, [System.String]$textValue, [System.EnvironmentVariableTarget]$textTarget); };

        <#
        WriteOutputDebug($enableWriteOutputDebug) $N_N_N[0];
        WriteOutputDebug($enableWriteOutputDebug) $N_N_N[1];
        WriteOutputDebug($enableWriteOutputDebug) $N_N_N[2];
        WriteOutputDebug($enableWriteOutputDebug) $cmdSetEnvironmentVariable;
        WriteOutputDebug($enableWriteOutputDebug) (IsValidString($textEnvironment));
        WriteOutputDebug($enableWriteOutputDebug) (IsValidString($textValue));
        WriteOutputDebug($enableWriteOutputDebug) (IsValidString($textTarget));
        WriteOutputDebug($enableWriteOutputDebug) ( (IsValidString($textEnvironment)) -and (IsValidString($textValue)) -and (IsValidString($textTarget)) );
        WriteOutputDebug($enableWriteOutputDebug)([Environment]::GetEnvironmentVariable($textEnvironment, $textTarget));
        WriteOutputDebug($enableWriteOutputDebug)($textValue);
        WriteOutputDebug($enableWriteOutputDebug)(([Environment]::GetEnvironmentVariable($textEnvironment, $textTarget)) -cne ($textValue));
#>

        if ( (IsValidString($textEnvironment)) -and (IsValidString($textValue)) -and (IsValidString($textTarget)) ) {
            if (([Environment]::GetEnvironmentVariable($textEnvironment, $textTarget)) -eq ($null)) {
                Invoke-Command $cmdSetEnvironmentVariable;
                WriteOutputDebug($enableWriteOutputDebug) $N_N_N[0];
                WriteOutputDebug($enableWriteOutputDebug) ([Environment]::GetEnvironmentVariable($textEnvironment, $textTarget));
                WriteOutputDebug($enableWriteOutputDebug) "([System.Environment]::SetEnvironmentVariable([System.String]""$textEnvironment"", [System.String]""$textValue"", [System.EnvironmentVariableTarget]""$textTarget""));";
            }
            else {   
                if (([Environment]::GetEnvironmentVariable($textEnvironment, $textTarget)) -cne ($textValue)) {
                    Invoke-Command $cmdSetEnvironmentVariable;
                    WriteOutputDebug($enableWriteOutputDebug) $N_N_N[1];
                    WriteOutputDebug($enableWriteOutputDebug) ([Environment]::GetEnvironmentVariable($textEnvironment, $textTarget));
                    WriteOutputDebug($enableWriteOutputDebug) "([System.Environment]::SetEnvironmentVariable([System.String]""$textEnvironment"", [System.String]""$textValue"", [System.EnvironmentVariableTarget]""$textTarget""));";
                }
                else {
                    WriteOutputDebug($enableWriteOutputDebug) $N_N_N[2];
                    WriteOutputDebug($enableWriteOutputDebug) ([Environment]::GetEnvironmentVariable($textEnvironment, $textTarget));
                    WriteOutputDebug($enableWriteOutputDebug) "([System.Environment]::SetEnvironmentVariable([System.String]""$textEnvironment"", [System.String]""$textValue"", [System.EnvironmentVariableTarget]""$textTarget""));";
                };
            };
        }
        else {
            $textThrow_SetEnvironmentCreate = "Please Contact System Administrator [ERRO] Set-EnvironmentCreate";
            WriteOutputDebug($enableWriteOutputDebug) $textThrow_SetEnvironmentCreate;
            throw $textThrow_SetEnvironmentCreate;
        };
    }; 

    [System.String[]]$EnvironmentList = (
        "JAVA_HOME", 
        "JDK_HOME", 
        "JRE_HOME",
        "CLASSPATH",
        "PATH"
    );
    [System.String[]]$ValuetList = (
        "C:\JAVA\JDK", 
        "C:\JAVA\JDK",
        "C:\JAVA\JDK\jre",
        "C:\JAVA\JDK\lib",
        "C:\JAVA\JDK\bin"
    );
    function Set-EnvironmentJavaUser {


        for ($i = 0; $i -lt ($EnvironmentList.Count - 1); $i++) {
            WriteOutputDebug($enableWriteOutputDebug) $i;
            if ($EnvironmentList[$i] -eq $EnvironmentList[$EnvironmentList.Length - 1]) {
            }
            else {
                Set-EnvironmentCreate($EnvironmentList[$i])($ValuetList[$i])("User");
            }
            
        }
        #Set-EnvironmentCreate($EnvironmentList[0])($ValuetList[0])("User");
        #Set-EnvironmentCreate($EnvironmentList[1])($ValuetList[1])("User");
        #Set-EnvironmentCreate($EnvironmentList[2])($ValuetList[2])("User");
        #Set-EnvironmentCreate($EnvironmentList[3])($ValuetList[3])("User");
        #Set-EnvironmentCreate($EnvironmentList[4])($ValuetList[4])("User");
 
        #Set-EnvironmentCreate($EnvironmentList[0])("C:\JAVA\JDK")("User");
        #Set-EnvironmentCreate($EnvironmentList[1])("C:\JAVA\JxxxDK")("User");
        #Set-EnvironmentCreate($EnvironmentList[2])("C:\JAVA\JxxxDK")("User");
        #Set-EnvironmentCreate($EnvironmentList[3])("C:\JAVA\JxxxDK")("User");
        #Set-EnvironmentCreate($EnvironmentList[4])("C:\JAVA\JxxxDK")("User");
    }
    
    function Set-EnvironmentJavaUserRemove {
        for ($i = 0; $i -lt ($EnvironmentList.Length); $i++) {
            if ($EnvironmentList[$i] -eq $EnvironmentList[$EnvironmentList.Length - 1]) {
                $envCharReplance = [System.Environment]::GetEnvironmentVariable($EnvironmentList[$i], [System.EnvironmentVariableTarget]::User);
                $envCharReplance = $envCharReplance.Replace(";" + $ValuetList[$i], "");
                [System.Environment]::SetEnvironmentVariable([System.String]$EnvironmentList[$i], $envCharReplance, [System.EnvironmentVariableTarget]::User);
                WriteOutputDebug($enableWriteOutputDebug) ("Delete [OK] " + $EnvironmentList[$i]);
            }
            else {
                [System.Environment]::SetEnvironmentVariable([System.String]$EnvironmentList[$i], [System.String]$null, [System.EnvironmentVariableTarget]::User);
                WriteOutputDebug($enableWriteOutputDebug) ("Delete [OK] " + $EnvironmentList[$i]);
            };
        };   
    };
    Set-EnvironmentJavaUserRemove;
    #Set-EnvironmentJavaUser;
}; & Invoke-Command $JavaRocketLauncher;