
function mods {
    param (
        $discordBranch = "stable",
        $vencordLocation = "C:\Path\To\Discord"  
    )

    
    function Install-Vencord {
        # Check if VencordInstallerCli exists, if not download it
        if (-Not (Test-Path "VencordInstallerCli.exe")) {
            Write-Host "Downloading VencordInstallerCli..."
            Invoke-WebRequest -Uri "https://github.com/Vencord/Installer/releases/latest/download/VencordInstallerCli.exe" -OutFile "VencordInstallerCli.exe"
        }
        Write-Host "Updating VencordInstallerCli..."
        Start-Process -FilePath "./VencordInstallerCli.exe" -ArgumentList "-update-self" -Wait

        # Install or Update Vencord
        Write-Host "Installing/Updating Vencord..."
        Start-Process -FilePath "./VencordInstallerCli.exe" -ArgumentList "-install"

        Write-Host "Vencord Installation/Update Completed."
    }

    # Sub-function to Install/Update Spotify Mods
    function Install-SpotifyMods {
        Write-Host "Select the Spotify mod to install/update:"
        Write-Host "1. SpotX"
        Write-Host "2. BlockTheSpot"
        Write-Host "3. Spicetify & Marketplace"
        $spotifyChoice = Read-Host "Enter your choice (1, 2, or 3)"

        switch ($spotifyChoice) {
            1 {
                # Install SpotX
                Write-Host "Installing SpotX..."
                iex "& { $(iwr -useb 'https://raw.githubusercontent.com/SpotX-Official/spotx-official.github.io/main/run.ps1') } -new_theme"
                Write-Host "SpotX Installation Completed."
            }
            2 {
                # Install BlockTheSpot
                Write-Host "Installing BlockTheSpot..."
                powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/mrpond/BlockTheSpot/master/install.ps1' | Invoke-Expression}"
                Write-Host "BlockTheSpot Installation Completed."
            }
            3 {
                # Install/Update Spicetify & Marketplace
                Write-Host "Installing/Updating Spicetify..."
                iwr -useb https://raw.githubusercontent.com/spicetify/cli/main/install.ps1 | iex

                Write-Host "Installing Spicetify Marketplace..."
                iwr -useb https://raw.githubusercontent.com/spicetify/marketplace/main/resources/install.ps1 | iex

                Write-Host "Spicetify & Marketplace Installation/Update Completed."
            }
            default {
                Write-Host "Invalid choice. Please select 1, 2, or 3."
                Install-SpotifyMods  # Recursive call for invalid choices
            }
        }
    }

    # Menu to select Spotify or Discord
    Write-Host "Select the application you want to modify:"
    Write-Host "1. Discord (Vencord)"
    Write-Host "2. Spotify Mods (SpotX, BlockTheSpot, Spicetify)"
    $choice = Read-Host "Enter your choice (1 or 2)"

    switch ($choice) {
        1 {
            Install-Vencord
        }
        2 {
            Install-SpotifyMods
        }
        default {
            Write-Host "Invalid choice. Please select 1 or 2."
            mods  # Recursive call to display the menu again for invalid choices
        }
    }
}
