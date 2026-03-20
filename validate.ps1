# Skill Scout 质量验证脚本
# 每次推送前必须运行此脚本

$ErrorActionPreference = "Continue"
$repoDir = $PSScriptRoot
$allPassed = $true

Write-Host "=== Skill Scout 质量验证 ===" -ForegroundColor Cyan
Write-Host ""

function Test-JsonFile($path, $name) {
    Write-Host "【JSON 格式检查】$name..." -ForegroundColor Yellow -NoNewline
    try {
        $content = Get-Content $path -Raw
        $null = $content | ConvertFrom-Json
        Write-Host " ✅" -ForegroundColor Green
        return $true
    } catch {
        Write-Host " ❌ $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

function Test-FileExists($path, $name) {
    Write-Host "【文件存在】$name..." -ForegroundColor Yellow -NoNewline
    if (Test-Path $path) {
        Write-Host " ✅" -ForegroundColor Green
        return $true
    } else {
        Write-Host " ❌ 缺失" -ForegroundColor Red
        return $false
    }
}

# 必需文件
$requiredFiles = @(
    @{path="README.md"; name="README.md"},
    @{path="skill-scout.ps1"; name="skill-scout.ps1"},
    @{path="skills-index.json"; name="skills-index.json"},
    @{path="LICENSE"; name="LICENSE"},
    @{path=".gitignore"; name=".gitignore"},
    @{path="SKILL.md"; name="SKILL.md"},
    @{path="CLAUDE.md"; name="CLAUDE.md"}
)

foreach ($f in $requiredFiles) {
    $fullPath = Join-Path $repoDir $f.path
    if (-not (Test-FileExists $fullPath $f.name)) { $allPassed = $false }
}

# JSON 字段验证
Write-Host ""
Write-Host "【skills-index.json 数据完整性】" -ForegroundColor Yellow
try {
    $index = Get-Content (Join-Path $repoDir "skills-index.json") -Raw | ConvertFrom-Json
    $count = $index.skills.Count
    $total = $index.total_skills
    Write-Host "  skills 数组: $count 条" -ForegroundColor Cyan
    Write-Host "  total_skills 字段: $total" -ForegroundColor Cyan
    if ($count -ne $total) {
        Write-Host "  ⚠️  警告: 数量不匹配 ($count vs $total)" -ForegroundColor Red
        $allPassed = $false
    } else {
        Write-Host "  ✅ 数量一致" -ForegroundColor Green
    }
    
    # 检查必需字段
    $requiredFields = @('name', 'quality_score', 'install_difficulty', 'monetization', 'author_experience')
    $sample = $index.skills[0]
    foreach ($field in $requiredFields) {
        if ($null -eq $sample.$field) {
            Write-Host "  ❌ 缺少字段: $field" -ForegroundColor Red
            $allPassed = $false
        }
    }
    Write-Host "  ✅ 必需字段完整" -ForegroundColor Green
} catch {
    Write-Host "  ❌ JSON 解析失败: $_" -ForegroundColor Red
    $allPassed = $false
}

# CLI 功能测试
Write-Host ""
Write-Host "【CLI 功能测试】" -ForegroundColor Yellow
Write-Host "  运行: .\skill-scout.ps1 list" -ForegroundColor Gray -NoNewline
try {
    $output = & powershell -ExecutionPolicy Bypass -File (Join-Path $repoDir "skill-scout.ps1") -Command list 2>&1
    if ($LASTEXITCODE -eq 0 -or $output -match "Skill Scout") {
        Write-Host " ✅" -ForegroundColor Green
    } else {
        Write-Host " ⚠️  $($output[0..2] -join ' ')" -ForegroundColor Red
    }
} catch {
    Write-Host " ❌ $_" -ForegroundColor Red
    $allPassed = $false
}

# 结果
Write-Host ""
if ($allPassed) {
    Write-Host "✅ 全部检查通过 — 可以推送" -ForegroundColor Green
    exit 0
} else {
    Write-Host "❌ 存在错误 — 修复后再推送" -ForegroundColor Red
    exit 1
}
