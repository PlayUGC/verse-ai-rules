# Setup script for AI-assisted UEFN development
Write-Host "Setting up AI assistant for UEFN development..." -ForegroundColor Green

# Get the directory where the script is located
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$databaseFile = Join-Path -Path $scriptDir -ChildPath "verse-code-database.md"

# Create verse-code-database.md if it doesn't exist
if (-not (Test-Path $databaseFile)) {
    New-Item -ItemType File -Path $databaseFile | Out-Null
    Write-Host "Created $databaseFile" -ForegroundColor Green
}

# Copy ai-instructions.mdc if it doesn't exist
if (-not (Test-Path "ai-instructions.mdc")) {
    # Check if the file exists in the parent directory
    if (Test-Path "../ai-instructions.mdc") {
        Copy-Item "../ai-instructions.mdc" "ai-instructions.mdc"
        Write-Host "Copied ai-instructions.mdc" -ForegroundColor Green
    }
    else {
        Write-Host "Warning: ai-instructions.mdc not found. Please ensure it's in the correct location." -ForegroundColor Yellow
    }
}

# Function to create interactive menu
function Show-Menu {
    param (
        [string[]]$Options,
        [string]$Title
    )
    
    $selected = 0
    $done = $false
    
    while (-not $done) {
        Clear-Host
        Write-Host $Title -ForegroundColor Cyan
        Write-Host "`nUse Up/Down arrows to select, Enter to confirm:`n" -ForegroundColor Yellow
        
        for ($i = 0; $i -lt $Options.Count; $i++) {
            if ($i -eq $selected) {
                Write-Host "> $($Options[$i])" -ForegroundColor Green
            }
            else {
                Write-Host "  $($Options[$i])" -ForegroundColor White
            }
        }
        
        $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        
        switch ($key.VirtualKeyCode) {
            38 {
                # Up arrow
                $selected = ($selected - 1) % $Options.Count
                if ($selected -lt 0) { $selected = $Options.Count - 1 }
            }
            40 {
                # Down arrow
                $selected = ($selected + 1) % $Options.Count
            }
            13 {
                # Enter
                $done = $true
            }
        }
    }
    
    return $selected
}

# Function to find all UEFN projects
function Find-UEFNProjects {
    Write-Host "`nSearching for UEFN projects..." -ForegroundColor Green
    
    # Show search options menu
    $options = @(
        "Choose folder to search for .verse files",
        "Search entire computer (This may take a few minutes)"
    )
    $choice = Show-Menu -Options $options -Title "Select Search Method"
    
    $projects = @()
    
    if ($choice -eq 0) {
        # Let user choose folder
        Write-Host "`nPlease select the folder to search for .verse files:" -ForegroundColor Yellow
        Add-Type -AssemblyName System.Windows.Forms
        $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
        $folderBrowser.Description = "Select folder containing UEFN projects"
        $folderBrowser.RootFolder = [System.Environment+SpecialFolder]::MyComputer
        
        if ($folderBrowser.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
            $selectedPath = $folderBrowser.SelectedPath
            Write-Host "Selected path: $selectedPath" -ForegroundColor Green
            $projects += Get-ChildItem -Path $selectedPath -Directory
        }
        else {
            Write-Host "No folder selected. Exiting..." -ForegroundColor Red
            exit
        }
    }
    else {
        # Search entire computer
        Write-Host "`nSearching entire computer for UEFN projects..." -ForegroundColor Yellow
        Write-Host "This may take a few minutes. Please wait..." -ForegroundColor Yellow
        
        # Common UEFN project locations
        $searchPaths = @(
            "$env:LOCALAPPDATA\UEFN\Projects",
            "$env:USERPROFILE\Documents\UEFN\Projects",
            "$env:USERPROFILE\UEFN\Projects"
        )
        
        # Search common locations first
        foreach ($path in $searchPaths) {
            if (Test-Path $path) {
                Write-Host "Found UEFN projects directory: $path" -ForegroundColor Cyan
                $projects += Get-ChildItem -Path $path -Directory
            }
        }
        
        # Search all drives for .verse files
        Get-PSDrive -PSProvider FileSystem | ForEach-Object {
            Write-Host "Searching drive $($_.Root)..." -ForegroundColor Cyan
            $verseFiles = Get-ChildItem -Path $_.Root -Recurse -Filter "*.verse" -ErrorAction SilentlyContinue
            if ($verseFiles) {
                $projectDirs = $verseFiles | Select-Object -ExpandProperty DirectoryName -Unique
                foreach ($dir in $projectDirs) {
                    if (-not ($projects.FullName -contains $dir)) {
                        $projects += Get-Item $dir
                    }
                }
            }
        }
    }
    
    return $projects
}

# Function to find and concatenate all .verse files
function Update-VerseDatabase {
    Write-Host "`nUpdating verse-code-database.txt with all .verse files..." -ForegroundColor Green
    
    $databasePath = $script:databaseFile
    $maxRetries = 3
    $retryDelay = 1 # in seconds
    
    # Function to safely write to file with retry logic
    function Safe-AddContent {
        param([string]$Path, [string]$Value)
        
        $retryCount = 0
        $success = $false
        
        while (-not $success -and $retryCount -lt $maxRetries) {
            try {
                # Use a FileStream with FileShare.None to ensure exclusive access
                $fileStream = [System.IO.File]::Open($Path, [System.IO.FileMode]::Append, [System.IO.FileAccess]::Write, [System.IO.FileShare]::None)
                $streamWriter = New-Object System.IO.StreamWriter($fileStream)
                $streamWriter.WriteLine($Value)
                $success = $true
            }
            catch {
                $retryCount++
                if ($retryCount -ge $maxRetries) {
                    Write-Host "  Failed to write to database after $maxRetries attempts: $_" -ForegroundColor Red
                    return $false
                }
                Start-Sleep -Seconds $retryDelay
            }
            finally {
                if ($null -ne $streamWriter) { $streamWriter.Dispose() }
                if ($null -ne $fileStream) { $fileStream.Dispose() }
            }
        }
        return $success
    }
    
    # Clear the existing content with retry logic
    $retryCount = 0
    $cleared = $false
    while (-not $cleared -and $retryCount -lt $maxRetries) {
        try {
            Set-Content -Path $databasePath -Value "# Verse Code Database - Generated on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ErrorAction Stop
            Add-Content -Path $databasePath -Value "`n*This file is automatically generated. Do not edit manually.*`n"
            $cleared = $true
        }
        catch {
            $retryCount++
            if ($retryCount -ge $maxRetries) {
                Write-Host "Failed to clear database file after $maxRetries attempts. Please close any programs that might be using the file and try again." -ForegroundColor Red
                return
            }
            Start-Sleep -Seconds $retryDelay
        }
    }
    
    # Find all UEFN projects
    $projects = Find-UEFNProjects
    
    foreach ($project in $projects) {
        Write-Host "`nProcessing project: $($project.Name)" -ForegroundColor Cyan
        
        # Find all .verse files in the project, excluding the database file
        try {
            $verseFiles = @(Get-ChildItem -Path $project.FullName -Filter "*.verse" -Recurse -File -ErrorAction SilentlyContinue | 
                Where-Object { $_.Name -ne 'verse-code-database.txt' -and $_.FullName -ne (Resolve-Path -Path $databasePath -ErrorAction SilentlyContinue) })
                
            Write-Host "Found $($verseFiles.Count) .verse files" -ForegroundColor Green
            
            # Process each .verse file
            foreach ($file in $verseFiles) {
                try {
                    $content = Get-Content $file.FullName -Raw -ErrorAction Stop
                    
                    # Add file header and content with retry logic
                    $success = $true
                    $success = $success -and (Safe-AddContent -Path $databasePath -Value "`n# File: $($file.FullName)")
                    $success = $success -and (Safe-AddContent -Path $databasePath -Value $content)
                    $success = $success -and (Safe-AddContent -Path $databasePath -Value "`n# End of file: $($file.Name)`n")
                    
                    if (-not $success) {
                        Write-Host "  Warning: Some content may not have been written for $($file.Name)" -ForegroundColor Yellow
                    }
                }
                catch {
                    Write-Host "  Error processing $($file.Name): $_" -ForegroundColor Red
                }
            }
        }
        catch {
            Write-Host "  Error searching for .verse files in $($project.Name): $_" -ForegroundColor Red
        }
    }
    
    Write-Host "`nDatabase update complete!" -ForegroundColor Green
    Write-Host "Total projects processed: $($projects.Count)" -ForegroundColor Cyan
}

# Run the update function
Update-VerseDatabase

Write-Host "`nSetup complete! You can now use the AI assistant for UEFN development." -ForegroundColor Green
Write-Host "To update your verse-code-database.txt in the future, just run this script again." -ForegroundColor Cyan