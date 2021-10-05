function Show-Menu {
    param (
        [string]$Title = 'My Menu'
    )
    Clear-Host;
    Write-Host "================ $Title ================";
    
    Write-Host "1: Press '1' for this option.";
    Write-Host "2: Press '2' for this option.";
    Write-Host "3: Press '3' for this option.";
    Write-Host "Q: Press 'Q' to quitxxx.";
};