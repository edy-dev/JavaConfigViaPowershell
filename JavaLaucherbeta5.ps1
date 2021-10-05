    function Get-AllEnvironmentVariables {
        $(Get-ChildItem Env:*)
     }

    Get-AllEnvironmentVariables;