param(
    [string]$MapsKey = 'AIzaSyAaRZ1njo_S0KWYUorYGfxuEpSlRx54on8'
)

$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot

function Write-Utf8([string]$Path, [string]$Text) {
    [System.IO.File]::WriteAllText((Join-Path $PSScriptRoot $Path), $Text, (New-Object System.Text.UTF8Encoding($false)))
}

function Read-Text([string]$Path) {
    [System.IO.File]::ReadAllText((Join-Path $PSScriptRoot $Path))
}

if (-not (Test-Path 'android')) {
    $backup = Join-Path $env:TEMP 'streetbite_backup'
    if (Test-Path $backup) { Remove-Item $backup -Recurse -Force }
    New-Item $backup -ItemType Directory | Out-Null
    Copy-Item 'pubspec.yaml', 'analysis_options.yaml' $backup
    Copy-Item 'lib' (Join-Path $backup 'lib') -Recurse

    flutter create --org com.streetbite --project-name streetbite --platforms android .

    Copy-Item (Join-Path $backup 'pubspec.yaml'), (Join-Path $backup 'analysis_options.yaml') . -Force
    Remove-Item 'lib' -Recurse -Force
    Copy-Item (Join-Path $backup 'lib') 'lib' -Recurse
    if (Test-Path 'test') { Remove-Item 'test' -Recurse -Force }
}

$settings = 'android\settings.gradle.kts'
$text = Read-Text $settings
$text = $text -replace '(id\("org\.jetbrains\.kotlin\.android"\) version )"[^"]+"', '${1}"2.3.10"'
Write-Utf8 $settings $text

$appGradle = 'android\app\build.gradle.kts'
$text = Read-Text $appGradle
if ($text -cnotmatch 'import org\.jetbrains\.kotlin\.gradle\.dsl\.JvmTarget')  {
    $text = $text -replace '(?s)\s*kotlinOptions\s*\{.*?\}', ''
    $text = $text -replace 'minSdk\s*=\s*flutter\.minSdkVersion', 'minSdk = 23'
    $text = "import org.jetbrains.kotlin.gradle.dsl.JvmTarget`n`n" + $text.TrimEnd() + "`n`nkotlin {`n    compilerOptions {`n        jvmTarget.set(JvmTarget.JVM_11)`n    }`n}`n"
    Write-Utf8 $appGradle $text
}

$manifest = 'android\app\src\main\AndroidManifest.xml'
$text = Read-Text $manifest
if ($text -notmatch 'USE_BIOMETRIC') {
    $perms = "`n    <uses-permission android:name=`"android.permission.INTERNET`"/>`n    <uses-permission android:name=`"android.permission.USE_BIOMETRIC`"/>"
    $meta = "`n        <meta-data android:name=`"com.google.android.geo.API_KEY`" android:value=`"$MapsKey`"/>"
    $text = $text -replace '(<manifest[^>]*>)', ('${1}' + $perms)
    $text = $text -replace '(<application[^>]*>)', ('${1}' + $meta)
    Write-Utf8 $manifest $text
}

$activityDir = 'android\app\src\main\kotlin\com\streetbite\streetbite'
New-Item $activityDir -ItemType Directory -Force | Out-Null
Write-Utf8 (Join-Path $activityDir 'MainActivity.kt') "package com.streetbite.streetbite`n`nimport io.flutter.embedding.android.FlutterFragmentActivity`n`nclass MainActivity : FlutterFragmentActivity()`n"

flutter pub get
flutter gen-l10n
dart format .

Write-Host ''
Write-Host 'Setup done. Next: flutterfire configure, then flutter analyze, then flutter run.'

