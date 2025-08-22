param (
    [Parameter(Mandatory=$true)]
    [string]$SourceFolder,

    [Parameter(Mandatory=$true)]
    [string]$ZipFileName
)

# Get all .java files recursively within the source folder
$javaFiles = Get-ChildItem -Path $SourceFolder -Filter "*.java" -Recurse

# Check if any .java files were found
if ($javaFiles) {
    # Construct the full path for the destination zip file
    $destinationPath = Join-Path -Path (Get-Item $SourceFolder).FullName -ChildPath "$ZipFileName.zip"

    # Compress the .java files into a zip archive
    Compress-Archive -Path $javaFiles.FullName -DestinationPath $destinationPath -Force

    Write-Host "Successfully created '$ZipFileName.zip' containing all .java files from '$SourceFolder'."
} else {
    Write-Warning "No .java files found in '$SourceFolder'."
}

#Note on usage:
#     .\ZipJavaFiles.ps1 -SourceFolder "C:\Path\To\Your\Java\Project" -ZipFileName "MyJavaArchive" 