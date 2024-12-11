#! /usr/bin/env pwsh
<#
.SYNOPSIS
    Build Script.
.DESCRIPTION
    Automates the build and package steps for projects in this repository.

.EXAMPLE
    PS C:\> build.ps1

#>
[CmdletBinding()]
param (
    # The project or solution file to build
    [Parameter(Mandatory = $false)]
    [ValidateScript({
            if ( -Not ($_ | Test-Path) ) {
                throw "Project or solution file does not exist"
            }
            return $true
        })]
    [System.IO.FileInfo]
    $Project = "$PSScriptRoot\build.proj",

    # Specifies the target to build
    [Parameter(Mandatory = $false)]
    [ValidateSet("Build", "Test", "Publish")]
    [string]
    $Target = "Build",

    # The build configuration to use with the build. Eg Debug/Release
    [Parameter(Mandatory = $false)]
    [ValidateSet("Debug", "Release")]
    [string]
    $Configuration = "Release",

    # If specified a binlog (build.binlog) file is generated with the build.
    [Parameter()]
    [switch]
    $OutputLog,

    # If specified the script will output the build command rather than executing the build.
    [Parameter()]
    [switch]
    $ShowBuildCommand,

    # Additional build parameters to pass to MSBuild.exe
    [Parameter(Mandatory = $false, ValueFromRemainingArguments = $true)]
    [string[]]
    $AdditionalBuildArguements
)

Set-StrictMode -Version 3.0
$ErrorActionPreference = 'Stop'

Write-Output "PowerShell $($PSVersionTable.PSEdition) version $($PSVersionTable.PSVersion)"


$MSBuildArgs = @("msbuild", "-noLogo")
$MSBuildArgs += $Project
$MSBuildArgs += "-target:$Target"
$MSBuildArgs += "-p:Configuration=$Configuration"
$MSBuildArgs += "-clp:summary;v=m"

if ($OutputLog) {
    $MSBuildArgs += "-bl:build.binlog"
}

$MSBuildArgs += $AdditionalBuildArguements

if ($ShowBuildCommand) {
    "dotnet $MSBuildArgs"
} else {
    dotnet $MSBuildArgs
}
