Get-AppxPackage *3DBuilder* | Remove-AppxPackage
Get-AppxPackage *Appconnector* | Remove-AppxPackage
Get-AppxPackage *BingFinance* | Remove-AppxPackage
Get-AppxPackage *BingNews* | Remove-AppxPackage
Get-AppxPackage *BingSports* | Remove-AppxPackage
Get-AppxPackage *BingTranslator* | Remove-AppxPackage
Get-AppxPackage *BingWeather* | Remove-AppxPackage
Get-AppxPackage *BingTravel* | Remove-AppxPackage
Get-AppxPackage *BingHealthAndFitness* | Remove-AppxPackage
Get-AppxPackage *BingFoodAndDrink* | Remove-AppxPackage
Get-AppxPackage *GamingServices* | Remove-AppxPackage
Get-AppxPackage *Microsoft3DViewer* | Remove-AppxPackage
Get-AppxPackage *MicrosoftOfficeHub* | Remove-AppxPackage
Get-AppxPackage *MicrosoftPowerBIForWindows* | Remove-AppxPackage
Get-AppxPackage *MicrosoftSolitaireCollection* | Remove-AppxPackage
Get-AppxPackage *MinecraftUWP* | Remove-AppxPackage
Get-AppxPackage *NetworkSpeedTest* | Remove-AppxPackage
Get-AppxPackage *Office.OneNote* | Remove-AppxPackage
Get-AppxPackage *OneConnect* | Remove-AppxPackage
Get-AppxPackage *Print3D* | Remove-AppxPackage
Get-AppxPackage *SkypeApp* | Remove-AppxPackage
Get-AppxPackage *Wallet* | Remove-AppxPackage
Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage
Get-AppxPackage *WindowsMaps* | Remove-AppxPackage
Get-AppxPackage *WindowsPhone* | Remove-AppxPackage
Get-AppxPackage *Xbox.TCUI* | Remove-AppxPackage
Get-AppxPackage *XboxApp* | Remove-AppxPackage
Get-AppxPackage *XboxGameOverlay* | Remove-AppxPackage
Get-AppxPackage *XboxGamingOverlay* | Remove-AppxPackage
Get-AppxPackage *XboxSpeechToTextOverlay* | Remove-AppxPackage
Get-AppxPackage *YourPhone* | Remove-AppxPackage
Get-AppxPackage *ZuneMusic* | Remove-AppxPackage
Get-AppxPackage *ZuneVideo* | Remove-AppxPackage
Get-AppxPackage *XboxIdentityProvider* | Remove-AppxPackage
Get-AppxPackage *Messaging* | Remove-AppxPackage
Get-AppxPackage *WindowsFeedbackHub* | Remove-AppxPackage
Get-AppxPackage *GetHelp* | Remove-AppxPackage
Get-AppxPackage *Getstarted* | Remove-AppxPackage
Get-AppxPackage *WindowsStore* | Remove-AppxPackage
Get-AppxPackage *StorePurchaseApp* | Remove-AppxPackage
Get-AppxPackage *MixedReality.Portal* | Remove-AppxPackage
Get-AppxPackage *Music.Preview* | Remove-AppxPackage
Get-AppxPackage *CommsPhone* | Remove-AppxPackage
Get-AppxPackage *ConnectivityStore* | Remove-AppxPackage
Get-AppxPackage *Office.Sway* | Remove-AppxPackage
Get-AppxPackage *WindowsReadingList* | Remove-AppxPackage
Get-AppxPackage *king.com.BubbleWitch3Saga* | Remove-AppxPackage
Get-AppxPackage *king.com.CandyCrushFriends* | Remove-AppxPackage
Get-AppxPackage *SpotifyAB.SpotifyMusic* | Remove-AppxPackage

Start-Job -scriptblock {
    powercfg /S 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    powercfg /hibernate off
    powercfg /duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
    powercfg /SETACTIVE 16f789bb-e4ac-49a7-9d54-aacdeb453d0b
    
    reg add "HKLM\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d "0" /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d "0" /f
    reg add "HKCR\AllFileSystemObjects\shellex\ContextMenuHandlers\{470C0EBD-5D73-4d58-9CED-E91E22E23282}" /v "(Default)" /t REG_SZ /d "Pin to Start" /f
    reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d "0" /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "HistoricalCaptureEnabled" /t REG_DWORD /d "0" /f
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "0" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "6" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "8" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "0" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisableLastAccessUpdate" /t REG_DWORD /d "80000003" /f
    fsutil behavior set disablelastaccess 3

    reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Active Setup Temp Folders" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\BranchCache" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Content Indexer Cleaner" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\D3D Shader Cache" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Delivery Optimization Files" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Device Driver Packages" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Diagnostic Data Viewer database files" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Downloaded Program Files" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Internet Cache Files" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Language Pack" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Offline Pages Files" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Old ChkDsk Files" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Previous Installations" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Recycle Bin" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\RetailDemo Offline Content" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Service Pack Cleanup" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Setup Log Files" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error memory dump files" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error minidump files" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Files" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Setup Files" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Sync Files" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Thumbnail Cache" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Update Cleanup" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Upgrade Discarded Files" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\User file versions" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Defender" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting Files" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows ESD installation files" /v "StateFlags0048" /t REG_DWORD /d "2" /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Upgrade Log Files" /v "StateFlags0048" /t REG_DWORD /d "2" /f

    cleanmgr /sagerun:48
    
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    try {
        Get-Process -Name "SearchIndexer" -ErrorAction Stop | stop-process -force;
        "Processos SearchIndexer Finalizados.";
        #net.exe  stop "Windows Search
    } catch {}

    try {
        Get-Process -Name "superfetch" -ErrorAction Stop | stop-process -force;
        "Processos superfetch Finalizados.";
    } catch {}

    try {
        Get-service -Name "wsearch" -ErrorAction Stop | stop-service -force;
        "Processos wsearch Finalizados.";
    } catch {}

    try {
        Get-service -Name "*vm*" -ErrorAction Stop | stop-service -force;
        "Processos VM Finalizados.";
    } catch {}

    try {
        Get-Process -Name "*pen_t*" -ErrorAction Stop | stop-process -force;
        "Processos Pen_T Finalizados.";
    } catch {}

    try {
        Get-Process -Name "*tablet*" -ErrorAction Stop | stop-process -force;
        "Processos WTable Finalizados.";
    } catch {}

    try {
        Get-Process -Name "*search*" -ErrorAction Stop | stop-process -force;
        "Processos Search Finalizados.";
    } catch {}

    try {
        Get-Process -Name "*DbxSvc*" -ErrorAction Stop | stop-process -force;
        "Processos DropBox Finalizados.";
    } catch {}

    try {
        Get-Service -Name "DoSvc" -ErrorAction Stop | stop-Service -force;
        "Processos DeliveryOptimization Finalizados.";
    } catch {}

    try {
        Get-Service -Name "TabletInputService" -ErrorAction Stop | stop-Service -force;
        "Processos TabletImputService Finalizados.";
    } catch {}

    # - - -

    try {
        Get-Process -Name "*Chrome*" -ErrorAction Stop | stop-process -force;
        "Processos Chrome Finalizados.";
    } catch {}

    try {
        Get-Process -Name "*msedge*" -ErrorAction Stop | stop-process -force;
        "Processos MSEdge Finalizados.";
    } catch {}

    try {
        Get-Process -Name "*Dropbox*" -ErrorAction Stop | stop-process -force;
        "Processos Dropbox Finalizados.";
    } catch {}

    try {
        Get-Process -Name "*OneDrive*" -ErrorAction Stop | stop-process -force;
        "Processos OneDrive Finalizados.";
    } catch {}

} -credential "nacl\rkroot" -Name "CSGO";


& "E:\Program Files\Steam\steam.exe" steam://rungameid/730 -tcp


# "Idle, BelowNormal, Normal, AboveNormal, High, RealTime"

$contador = 0;
do{
    [bool]$saida = $false;
    try {
        $CSGO = Get-Process -Name "csgo" -ErrorAction Stop;
        $CSGO.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::High;
    } catch {
        $saida = $true;
    }
    Start-Sleep -s 1;
    $contador += 1;
} while($saida -and $contador -le 30)

#wmic process where 'name="csgo.exe"' call setpriority "256"