# Chinese Writing Kit for Windows
# 一键安装中文写作规范到你的项目

$ErrorActionPreference = "Stop"

$RepoUrl = "https://raw.githubusercontent.com/carolyn-sun/chinese-writing-kit/main"
$TargetDir = ".github/instructions"
$TargetFile = "chinese-writing-kit.instructions.md"

Write-Host "📝 Chinese Writing Kit" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan
Write-Host ""

# 检查是否在 git 仓库中
if (-not (Test-Path ".git")) {
    Write-Host "⚠️  警告：当前目录不是 git 仓库根目录。" -ForegroundColor Yellow
    $continue = Read-Host "是否继续安装？(y/N)"
    if ($continue -ne "y" -and $continue -ne "Y") {
        Write-Host "已取消安装。"
        exit 1
    }
}

# 创建 .github 目录
if (-not (Test-Path $TargetDir)) {
    Write-Host "📁 创建 $TargetDir 目录..." -ForegroundColor Gray
    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
}

# 检查文件是否已存在
$TargetPath = Join-Path $TargetDir $TargetFile
if (Test-Path $TargetPath) {
    Write-Host "⚠️  文件已存在：$TargetPath" -ForegroundColor Yellow
    $overwrite = Read-Host "是否覆盖？(y/N)"
    if ($overwrite -ne "y" -and $overwrite -ne "Y") {
        Write-Host "已取消安装。"
        exit 1
    }
}

# 下载文件
Write-Host "⬇️  正在下载 $TargetFile..." -ForegroundColor Gray
try {
    $downloadUrl = "$RepoUrl/$TargetFile"
    Invoke-WebRequest -Uri $downloadUrl -OutFile $TargetPath -UseBasicParsing
    
    Write-Host ""
    Write-Host "✅ 安装成功！" -ForegroundColor Green
    Write-Host ""
    Write-Host "文件已保存到：$TargetPath" -ForegroundColor Gray
    Write-Host ""
    Write-Host "下一步：" -ForegroundColor Cyan
    Write-Host "  1. 提交更改：git add $TargetPath && git commit -m 'Add Chinese Writing Kit'"
    Write-Host "  2. 推送到远程仓库：git push"
    Write-Host ""
    Write-Host "GitHub Copilot 会自动读取此文件并应用中文写作规范。" -ForegroundColor Gray
}
catch {
    Write-Host ""
    Write-Host "❌ 下载失败，请检查网络连接或手动下载文件。" -ForegroundColor Red
    Write-Host "错误信息：$($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
