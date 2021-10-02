$Set_JavaLacucher = {

    ## Set-ExecutionPolicy -ExecutionPolicy Unrestricted

    ## @id:terminal.integrated.commandsToSkipShell,terminal.integrated.sendKeybindingsToShell,terminal.integrated.allowChords
   ## powershell.exe -NoLogo -NoProfile -Command '[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Install-Module -Name PackageManagement -Force -MinimumVersion 1.4.6 -Scope CurrentUser -AllowClobber -Repository PSGallery'
   ## powershell.exe -NoLogo -NoProfile -Command '[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Install-Module -Name PackageManagement -Force -MinimumVersion 1.4.6 -Scope CurrentUser -AllowClobber -Repository PSGallery'
   $enableWriteOutputDebug=$true;
   Function WriteOutputDebug([System.Boolean]$showMsg,[System.String]$textMsg)
   {
       if ($showMsg){
           #Write-Output $showMsg
           Write-Output $textMsg;
       }else{
           ##Write-Output $showMsg
           ##Write-Output $textMsg
       };
   }

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


   function CheckPatchIsEnd {([System.String]$args)
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

   $Env:JAVA_HOME_DIR="C:\JAVA\JDK";
   if (($Env:JAVA_HOME) -eq ($null)){
       WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:JAVA_HOME: [NULL]");
       $Env:JAVA_HOME="$Env:JAVA_HOME_DIR";
       WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:JAVA_HOME: [" + ($(Get-ChildItem Env:JAVA_HOME)[0].Value.ToString())+"] NEW");
   }else{
       WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:JAVA_HOME: [" + ($(Get-ChildItem Env:JAVA_HOME)[0].Value.ToString())+"] OLD");
       if (($Env:JAVA_HOME) -cne ($Env:JAVA_HOME_DIR)){
            $Env:JAVA_HOME="$Env:JAVA_HOME_DIR";
           WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:JAVA_HOME: [" + ($(Get-ChildItem Env:JAVA_HOME)[0].Value.ToString())+"] REPLANCE ");
       }else{
           WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:JAVA_HOME: [" + ($(Get-ChildItem Env:JAVA_HOME)[0].Value.ToString())+"] NOW ");
       };
   };
   
   $Env:JDK_HOME_DIR=($(Get-ChildItem Env:JAVA_HOME)[0].Value.ToString());
   if (($Env:JDK_HOME) -eq ($null)){
       WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:JDK_HOME: [NULL]");
       $Env:JDK_HOME="$Env:JDK_HOME_DIR";
       WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:JDK_HOME: [" + ($(Get-ChildItem Env:JDK_HOME)[0].Value.ToString())+"] NEW");
   }else{
       WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:JDK_HOME: [" + ($(Get-ChildItem Env:JDK_HOME)[0].Value.ToString())+"] OLD");
       if (($Env:JDK_HOME) -cne ($Env:JDK_HOME_DIR)){
            $Env:JDK_HOME="$Env:JDK_HOME_DIR";
           WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:JDK_HOME: [" + ($(Get-ChildItem Env:JDK_HOME)[0].Value.ToString())+"] REPLANCE ");
       }else{
           WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:JDK_HOME: [" + ($(Get-ChildItem Env:JDK_HOME)[0].Value.ToString())+"] NOW ");
       };
   };
   
   $Env:JRE_HOME_DIR=($(Get-ChildItem Env:JAVA_HOME)[0].Value.ToString() + "\jre");
   if (($Env:JRE_HOME) -eq ($null)){
       WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:JRE_HOME: [NULL]");
       $Env:JRE_HOME="$Env:JRE_HOME_DIR";
       WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:JRE_HOME: [" + ($(Get-ChildItem Env:JRE_HOME)[0].Value.ToString())+"] NEW");
   }else{
       WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:JRE_HOME: [" + ($(Get-ChildItem Env:JRE_HOME)[0].Value.ToString())+"] OLD");
       if (($Env:JRE_HOME) -cne ($Env:JRE_HOME_DIR)){
            $Env:JRE_HOME="$Env:JRE_HOME_DIR";
           WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:JRE_HOME: [" + ($(Get-ChildItem Env:JRE_HOME)[0].Value.ToString())+"] REPLANCE ");
       }else{
           WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:JRE_HOME: [" + ($(Get-ChildItem Env:JRE_HOME)[0].Value.ToString())+"] NOW ");
       };
   };
   
   $Env:CLASSPATH_DIR=($(Get-ChildItem Env:JAVA_HOME)[0].Value.ToString() + "\lib");
   if (($Env:CLASSPATH) -eq ($null)){
       WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:CLASSPATH: [NULL]");
       $Env:CLASSPATH="$Env:CLASSPATH_DIR";
       WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:CLASSPATH: [" + ($(Get-ChildItem Env:CLASSPATH)[0].Value.ToString())+"] NEW");
   }else{
       WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:CLASSPATH: [" + ($(Get-ChildItem Env:CLASSPATH)[0].Value.ToString())+"] OLD");
       if (($Env:CLASSPATH) -cne ($Env:CLASSPATH_DIR)){
            $Env:CLASSPATH="$Env:CLASSPATH_DIR";
           WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:CLASSPATH: [" + ($(Get-ChildItem Env:CLASSPATH)[0].Value.ToString())+"] REPLANCE ");
       }else{
           WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:CLASSPATH: [" + ($(Get-ChildItem Env:CLASSPATH)[0].Value.ToString())+"] NOW ");
       };
   };


   $Env:PATH_DIR=($(Get-ChildItem Env:JAVA_HOME)[0].Value.ToString() + "\bin");
   if (($Env:PATH) -eq ($null)){
       WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:PATH: [NULL]");
       if (CheckIsAdm){
           $Env:PATH="$Env:PATH_DIR";
       }else{
           $Env:PATH="$Env:PATH_DIR;";
       };
       WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:PATH: [" + ($(Get-ChildItem Env:PATH)[0].Value.ToString())+"] NEW");
   }else{
       WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:PATH: [" + ($(Get-ChildItem Env:PATH)[0].Value.ToString())+"] OLD");
       if (($Env:PATH) -notlike ("*$Env:PATH_DIR*")){
           if (CheckIsAdm){
               $Env:PATH="$Env:PATH;$Env:PATH_DIR";
           }else{
               $Env:PATH="$Env:PATH$Env:PATH_DIR;";
           };
           WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:PATH: [" + ($(Get-ChildItem Env:PATH)[0].Value.ToString())+"] REPLANCE ");
       }else{
           WriteOutputDebug ([System.Boolean]$enableWriteOutputDebug)([System.String]"Env:PATH: [" + ($(Get-ChildItem Env:PATH)[0].Value.ToString())+"] NOW ");
       };
   };

}; & Invoke-Command $Set_JavaLacucher;
