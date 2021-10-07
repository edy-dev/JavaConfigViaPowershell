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
    function Set-EnvironmentJavaCreate([System.String]$textEnvironment, [System.String]$textValue, [System.EnvironmentVariableTarget]$textTarget) {
        
        [System.String[]]$N_N_N = (
            "NULL -> NEW", 
            "OLD  != NEW", 
            "OLD  == NOW");

        $cmdSetEnvironmentVariable = { [System.Environment]::SetEnvironmentVariable([System.String]$textEnvironment, [System.String]$textValue, [System.EnvironmentVariableTarget]$textTarget); };

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


    function Set-EnvironmentJavaCreateUser {

        for ($i = 0; $i -lt ($EnvironmentList.Count); $i++) {
            WriteOutputDebug($enableWriteOutputDebug) $i;
            if ($EnvironmentList[$i] -eq $EnvironmentList[$EnvironmentList.Length - 1]) {
                $ValuesEnvironment = New-Object System.Collections.ArrayList;
                $ValuesEnvironment.Add([System.Environment]::GetEnvironmentVariable($EnvironmentList[$i], "User"))  > $null ;
                $ValuesEnvironment[0] += (";"+$ValuetList[$i] );
                Write-Output ($ValuesEnvironment[0].ToString() + " Gerado");
                Set-EnvironmentJavaCreate($EnvironmentList[$i])($ValuesEnvironment[0])("User");
            }
            else {
                Set-EnvironmentJavaCreate($EnvironmentList[$i])($ValuetList[$i])("User");
            };
        };
    };
    
    function Set-EnvironmentJavaRemove([System.EnvironmentVariableTarget]$textTarget){
        $ValuesEnvironment = New-Object System.Collections.ArrayList;
        for ($i = 0; $i -lt ($EnvironmentList.Length); $i++) {
            $ValuesEnvironment.Add([System.Environment]::GetEnvironmentVariable($EnvironmentList[$i], $textTarget))  > $null ;
            if ($EnvironmentList[$i] -eq $EnvironmentList[$EnvironmentList.Length - 1]) {
                $envCharReplance = $ValuesEnvironment[$i]
                $envCharReplance = $envCharReplance.Replace(";" + $ValuetList[$i], "");
                [System.Environment]::SetEnvironmentVariable([System.String]$EnvironmentList[$i], $envCharReplance, $textTarget);
            }
            else {
                [System.Environment]::SetEnvironmentVariable([System.String]$EnvironmentList[$i], [System.String]$null, $textTarget);
            };
            WriteOutputDebug($enableWriteOutputDebug) ("Delete [OK] " + $EnvironmentList[$i]);
        };
    };
    function Set-EnvironmentJavaRemoveUser{
        Set-EnvironmentJavaRemove("User");
    };
    function Set-EnvironmentJavaRemoveMachine{
        Set-EnvironmentJavaRemove("Machine");
    };
    function Set-EnvironmentJavaRemoveProcess{
        Set-EnvironmentJavaRemove("Process");
    };
    
    #Set-EnvironmentJavaRemoveUser;
    Set-EnvironmentJavaCreateUser;
}; & Invoke-Command $JavaRocketLauncher;