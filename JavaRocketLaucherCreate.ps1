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

    function IsValidString([System.String]$textmsgErro) {

        if (([System.String]::IsNullOrEmpty($textmsgErro)) -And ([System.String]::IsNullOrWhitespace($textmsgErro))) {

            return $false;

        }
        else {

            return $true;

        };
    };

    function IsEndPatch([System.String]$textmsgErro) {

        if (IsValidString($textmsgErro)) {
    
            $textmsgErro = $textmsgErro.substring($textmsgErro.Length - 1 , 1);

            if (($textmsgErro) -eq (";")) {
                
                return $true;
            }
            else {

                return $false;
            };
        }
        else {

            throw "[ERRO] IsEndPatch";

        };  
    };

    [System.String[][]]$EnvironmentPathList;
    $EnvironmentPathList += , @("JAVA_HOME" , "C:\JAVA\JDK");
    $EnvironmentPathList += , @("JDK_HOME"  , ($EnvironmentPathList[0][1]));
    $EnvironmentPathList += , @("JRE_HOME"  , ($EnvironmentPathList[0][1] + "\jre"));
    $EnvironmentPathList += , @("CLASSPATH" , ($EnvironmentPathList[0][1] + "\lib"));
    $EnvironmentPathList += , @("PATH"      , ($EnvironmentPathList[0][1] + "\bin"));

    $EnvironmentTargetList = New-Object System.Collections.ArrayList;
    $EnvironmentTargetList.Add("User")    > $null ;
    $EnvironmentTargetList.Add("Machine") > $null ;
    $EnvironmentTargetList.Add("Process") > $null ;

    function Set-EnvironmentJavaCreate([System.EnvironmentVariableTarget]$textTarget) {
   
    }; 

    function Set-EnvironmentJavaRemove([System.String]$textTarget) {
   
        for ($ContadorTarget = 0; $ContadorTarget -lt $EnvironmentTargetList.Count; $ContadorTarget++) {

            [System.Boolean]$EncontradoTarget = $false;

            if (($EnvironmentTargetList[$ContadorTarget].ToString()) -eq ($textTarget.ToString())) {
       
                $EncontradoTarget = $true;
                WriteOutputDebug($enableWriteOutputDebug) ("[" + $EnvironmentTargetList[$ContadorTarget] + "]");

            }
            else {

                $EncontradoTarget = $false;
            };

            if ($EncontradoTarget) {

                $ValuesEnvironment = New-Object System.Collections.ArrayList;

                for ($i = 0; $i -lt ($EnvironmentPathList.Count); $i++) {
                    
                    $ValuesEnvironment.Add([System.Environment]::GetEnvironmentVariable($EnvironmentPathList[$i][0], $textTarget))  > $null ;
        
                    if ($EnvironmentPathList[4][0] -eq $EnvironmentPathList[$i][0]) {           
        
                        if (IsEndPatch($ValuesEnvironment[$i])) {
                  
                            $ValuesEnvironment[$i] = $ValuesEnvironment[$i].Replace($EnvironmentPathList[$i][1] + ";" , "");
                        }
                        else {
        
                            $ValuesEnvironment[$i] = $ValuesEnvironment[$i].Replace(";" + $EnvironmentPathList[$i][1], "");
                        }
        
                        [System.Environment]::SetEnvironmentVariable([System.String]$EnvironmentPathList[$i][0], $ValuesEnvironment[$i], $textTarget);
                    }
                    else {
        
                        [System.Environment]::SetEnvironmentVariable([System.String]$EnvironmentPathList[$i][0], [System.String]$null, $textTarget);
                    };
                    
                    WriteOutputDebug($enableWriteOutputDebug) ("Delete [OK] " + $EnvironmentPathList[$i][0]);
                };
            };
        };
    }; 

    function Set-EnvironmentJavaCreateUser {
        Set-EnvironmentJavaCreate("User");
    };
    function Set-EnvironmentJavaCreateMachine {
        Set-EnvironmentJavaCreate("Machine");
    };
    function Set-EnvironmentJavaCreateProcess {
        Set-EnvironmentJavaCreate("Process");
    };

    function Set-EnvironmentJavaRemoveUser {
        Set-EnvironmentJavaRemove("User");
    };
    function Set-EnvironmentJavaRemoveMachine {
        Set-EnvironmentJavaRemove("Machine");
    };
    function Set-EnvironmentJavaRemoveProcess {
        Set-EnvironmentJavaRemove("Process");
    };
    
    Set-EnvironmentJavaRemoveUser;
    #Set-EnvironmentJavaCreateUser;
}; & Invoke-Command $JavaRocketLauncher;