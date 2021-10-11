$JavaRocketLauncher = {

    $enableWriteOutputDebug = $true;

    function WriteOutputDebug([System.Boolean]$enableDebug, [System.String]$textDebug) {

        if ($enableDebug) {

            Write-Output $textDebug;

        };
    };

    function IsValidString([System.String]$textValid) {

        if (([System.String]::IsNullOrEmpty($textValid)) -And ([System.String]::IsNullOrWhitespace($textValid))) {

            return $false;

        }
        else {

            return $true;

        };
    };

    function IsEndPath([System.String]$textPath) {

        if (IsValidString($textPath)) {
    
            $textPath = $textPath.substring($textPath.Length - 1 , 1);

            if (($textPath) -eq (";")) {
                
                return $true;
            }
            else {

                return $false;
            };
        }
        else {

            throw "[ERRO] IsEndPath";

        };  
    };

    [System.Collections.ArrayList]$EnvironmentPathList = [System.Collections.ArrayList]::new();
    [void]$EnvironmentPathList.Add(@("JAVA_HOME"    , ("C:\JAVA\JDK"                       )));
    [void]$EnvironmentPathList.Add(@("JDK_HOME"     , ($EnvironmentPathList[0][1]          )));
    [void]$EnvironmentPathList.Add(@("JRE_HOME"     , ($EnvironmentPathList[0][1] + "\jre" )));
    [void]$EnvironmentPathList.Add(@("CLASSPATH"    , ($EnvironmentPathList[0][1] + "\lib" )));
    [void]$EnvironmentPathList.Add(@("PATH"         , ($EnvironmentPathList[0][1] + "\bin" )));
 
    [System.Collections.ArrayList]$EnvironmentTargetList = [System.Collections.ArrayList]::new();
    [void]$EnvironmentTargetList.Add("User");    
    [void]$EnvironmentTargetList.Add("Machine");
    [void]$EnvironmentTargetList.Add("Process"); 

    function Set-EnvironmentJavaCreate([System.String]$textTarget) {
        
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

                [System.Collections.ArrayList]$ValuesEnvironment = [System.Collections.ArrayList]::new();

                for ($i = 0; $i -lt ($EnvironmentPathList.Count); $i++) {
                    
                    $ValuesEnvironment.Add([System.Environment]::GetEnvironmentVariable($EnvironmentPathList[$i][0], $textTarget))  > $null ;
        
                    if ($EnvironmentPathList[4][0] -eq $EnvironmentPathList[$i][0]) {       

                        if (($ValuesEnvironment[$i]) -notlike ("*" + $EnvironmentPathList[$i][1] + "*")) {

                            if (IsEndPath($ValuesEnvironment[$i])) {

                                $ValuesEnvironment[$i] = $ValuesEnvironment[$i].Insert($ValuesEnvironment[$i].length, $EnvironmentPathList[$i][1] + ";");
                            }
                            else {

                                $ValuesEnvironment[$i] = $ValuesEnvironment[$i].Insert($ValuesEnvironment[$i].length, ";" + $EnvironmentPathList[$i][1]);
                            };

                            [System.Environment]::SetEnvironmentVariable([System.String]$EnvironmentPathList[$i][0], $ValuesEnvironment[$i], $textTarget); 
                        };
                    }
                    else {
        
                        [System.Environment]::SetEnvironmentVariable([System.String]$EnvironmentPathList[$i][0], [System.String]$EnvironmentPathList[$i][1], $textTarget);
                    };
                    
                    WriteOutputDebug($enableWriteOutputDebug) ("Create [OK] " + $EnvironmentPathList[$i][0]);
                };
            };
        };
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

                [System.Collections.ArrayList]$ValuesEnvironment = [System.Collections.ArrayList]::new();

                for ($i = 0; $i -lt ($EnvironmentPathList.Count); $i++) {
                    
                    $ValuesEnvironment.Add([System.Environment]::GetEnvironmentVariable($EnvironmentPathList[$i][0], $textTarget))  > $null ;
        
                    if ($EnvironmentPathList[4][0] -eq $EnvironmentPathList[$i][0]) {           
        
                        if (IsEndPath($ValuesEnvironment[$i])) {
                  
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
    
    # Set-EnvironmentJavaRemoveUser;
    # Set-EnvironmentJavaCreateUser;

}; & Invoke-Command $JavaRocketLauncher;