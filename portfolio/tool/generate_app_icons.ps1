param(
  [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
Add-Type -AssemblyName System.Drawing

$bioPath = Join-Path $ProjectRoot 'lib\portofolio\core\bio_config.dart'
$bioSource = Get-Content -LiteralPath $bioPath -Raw
$nameMatch = [regex]::Match($bioSource, "static const name = '([^']+)'\s*;")

if (-not $nameMatch.Success) {
  throw "Could not read BioConfig.name from $bioPath"
}

$publicName = $nameMatch.Groups[1].Value.Trim()
$nameParts = @($publicName -split '\s+' | Where-Object { $_.Length -gt 0 })

if ($nameParts.Count -eq 0) {
  throw 'BioConfig.name cannot be empty when generating app icons.'
}

if ($nameParts.Count -eq 1) {
  $take = [Math]::Min(2, $nameParts[0].Length)
  $initials = $nameParts[0].Substring(0, $take).ToUpperInvariant()
} else {
  $initials = ($nameParts[0].Substring(0, 1) + $nameParts[-1].Substring(0, 1)).ToUpperInvariant()
}

$navy = [System.Drawing.ColorTranslator]::FromHtml('#002561')
$white = [System.Drawing.ColorTranslator]::FromHtml('#F4F6F8')

function New-PortfolioIconBitmap {
  param([Parameter(Mandatory)][int]$Size)

  $bitmap = [System.Drawing.Bitmap]::new(
    $Size,
    $Size,
    [System.Drawing.Imaging.PixelFormat]::Format32bppArgb
  )
  $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
  $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
  $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
  $graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
  $graphics.Clear($navy)

  $textBrush = [System.Drawing.SolidBrush]::new($white)
  $font = [System.Drawing.Font]::new(
    'Segoe UI',
    [single]($Size * 0.43),
    [System.Drawing.FontStyle]::Bold,
    [System.Drawing.GraphicsUnit]::Pixel
  )

  try {
    $textSize = $graphics.MeasureString($initials, $font)
    $textX = ($Size - $textSize.Width) / 2
    $textY = (($Size - $textSize.Height) / 2) - ($Size * 0.015)
    $graphics.DrawString($initials, $font, $textBrush, [single]$textX, [single]$textY)
  } finally {
    $font.Dispose()
    $textBrush.Dispose()
    $graphics.Dispose()
  }

  return $bitmap
}

function Save-PortfolioIconPng {
  param(
    [Parameter(Mandatory)][string]$RelativePath,
    [Parameter(Mandatory)][int]$Size
  )

  $targetPath = Join-Path $ProjectRoot $RelativePath
  $targetDirectory = Split-Path -Parent $targetPath
  [System.IO.Directory]::CreateDirectory($targetDirectory) | Out-Null
  $bitmap = New-PortfolioIconBitmap -Size $Size

  try {
    $bitmap.Save($targetPath, [System.Drawing.Imaging.ImageFormat]::Png)
  } finally {
    $bitmap.Dispose()
  }
}

function Save-PortfolioWindowsIcon {
  param([Parameter(Mandatory)][string]$RelativePath)

  $targetPath = Join-Path $ProjectRoot $RelativePath
  $bitmap = New-PortfolioIconBitmap -Size 256
  $pngStream = [System.IO.MemoryStream]::new()

  try {
    $bitmap.Save($pngStream, [System.Drawing.Imaging.ImageFormat]::Png)
    $pngBytes = $pngStream.ToArray()
  } finally {
    $pngStream.Dispose()
    $bitmap.Dispose()
  }

  $fileStream = [System.IO.File]::Create($targetPath)
  $writer = [System.IO.BinaryWriter]::new($fileStream)

  try {
    $writer.Write([uint16]0)
    $writer.Write([uint16]1)
    $writer.Write([uint16]1)
    $writer.Write([byte]0)
    $writer.Write([byte]0)
    $writer.Write([byte]0)
    $writer.Write([byte]0)
    $writer.Write([uint16]1)
    $writer.Write([uint16]32)
    $writer.Write([uint32]$pngBytes.Length)
    $writer.Write([uint32]22)
    $writer.Write($pngBytes)
  } finally {
    $writer.Dispose()
    $fileStream.Dispose()
  }
}

$pngTargets = @(
  @{ Path = 'assets\icon\app_icon.png'; Size = 1024 },
  @{ Path = 'web\favicon.png'; Size = 32 },
  @{ Path = 'web\icons\Icon-192.png'; Size = 192 },
  @{ Path = 'web\icons\Icon-512.png'; Size = 512 },
  @{ Path = 'web\icons\Icon-maskable-192.png'; Size = 192 },
  @{ Path = 'web\icons\Icon-maskable-512.png'; Size = 512 },
  @{ Path = 'android\app\src\main\res\mipmap-mdpi\ic_launcher.png'; Size = 48 },
  @{ Path = 'android\app\src\main\res\mipmap-hdpi\ic_launcher.png'; Size = 72 },
  @{ Path = 'android\app\src\main\res\mipmap-xhdpi\ic_launcher.png'; Size = 96 },
  @{ Path = 'android\app\src\main\res\mipmap-xxhdpi\ic_launcher.png'; Size = 144 },
  @{ Path = 'android\app\src\main\res\mipmap-xxxhdpi\ic_launcher.png'; Size = 192 },
  @{ Path = 'linux\runner\resources\app_icon.png'; Size = 512 },
  @{ Path = 'ios\Runner\Assets.xcassets\AppIcon.appiconset\Icon-App-20x20@1x.png'; Size = 20 },
  @{ Path = 'ios\Runner\Assets.xcassets\AppIcon.appiconset\Icon-App-20x20@2x.png'; Size = 40 },
  @{ Path = 'ios\Runner\Assets.xcassets\AppIcon.appiconset\Icon-App-20x20@3x.png'; Size = 60 },
  @{ Path = 'ios\Runner\Assets.xcassets\AppIcon.appiconset\Icon-App-29x29@1x.png'; Size = 29 },
  @{ Path = 'ios\Runner\Assets.xcassets\AppIcon.appiconset\Icon-App-29x29@2x.png'; Size = 58 },
  @{ Path = 'ios\Runner\Assets.xcassets\AppIcon.appiconset\Icon-App-29x29@3x.png'; Size = 87 },
  @{ Path = 'ios\Runner\Assets.xcassets\AppIcon.appiconset\Icon-App-40x40@1x.png'; Size = 40 },
  @{ Path = 'ios\Runner\Assets.xcassets\AppIcon.appiconset\Icon-App-40x40@2x.png'; Size = 80 },
  @{ Path = 'ios\Runner\Assets.xcassets\AppIcon.appiconset\Icon-App-40x40@3x.png'; Size = 120 },
  @{ Path = 'ios\Runner\Assets.xcassets\AppIcon.appiconset\Icon-App-60x60@2x.png'; Size = 120 },
  @{ Path = 'ios\Runner\Assets.xcassets\AppIcon.appiconset\Icon-App-60x60@3x.png'; Size = 180 },
  @{ Path = 'ios\Runner\Assets.xcassets\AppIcon.appiconset\Icon-App-76x76@1x.png'; Size = 76 },
  @{ Path = 'ios\Runner\Assets.xcassets\AppIcon.appiconset\Icon-App-76x76@2x.png'; Size = 152 },
  @{ Path = 'ios\Runner\Assets.xcassets\AppIcon.appiconset\Icon-App-83.5x83.5@2x.png'; Size = 167 },
  @{ Path = 'ios\Runner\Assets.xcassets\AppIcon.appiconset\Icon-App-1024x1024@1x.png'; Size = 1024 },
  @{ Path = 'macos\Runner\Assets.xcassets\AppIcon.appiconset\app_icon_16.png'; Size = 16 },
  @{ Path = 'macos\Runner\Assets.xcassets\AppIcon.appiconset\app_icon_32.png'; Size = 32 },
  @{ Path = 'macos\Runner\Assets.xcassets\AppIcon.appiconset\app_icon_64.png'; Size = 64 },
  @{ Path = 'macos\Runner\Assets.xcassets\AppIcon.appiconset\app_icon_128.png'; Size = 128 },
  @{ Path = 'macos\Runner\Assets.xcassets\AppIcon.appiconset\app_icon_256.png'; Size = 256 },
  @{ Path = 'macos\Runner\Assets.xcassets\AppIcon.appiconset\app_icon_512.png'; Size = 512 },
  @{ Path = 'macos\Runner\Assets.xcassets\AppIcon.appiconset\app_icon_1024.png'; Size = 1024 }
)

foreach ($target in $pngTargets) {
  Save-PortfolioIconPng -RelativePath $target.Path -Size $target.Size
}

Save-PortfolioWindowsIcon -RelativePath 'windows\runner\resources\app_icon.ico'
Write-Host "Generated '$initials' icons for web, Android, iOS, Linux, macOS, and Windows."
