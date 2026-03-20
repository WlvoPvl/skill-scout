# Skill Scout CLI - PowerShell
# OpenClaw Skill 发现、评测、推荐引擎
# Version: 1.0.0

param(
    [Parameter(Position=0)]
    [ValidateSet("find", "info", "compare", "list", "search", "recommend")]
    [string]$Command = "list",

    [Parameter(Position=1, ValueFromRemainingArguments=$true)]
    [string[]]$Args
)

$ErrorActionPreference = "Stop"
$INDEX_FILE = Join-Path $PSScriptRoot "skills-index.json"

# ─── 加载索引 ────────────────────────────────────────────────────────────
if (-not (Test-Path $INDEX_FILE)) {
    Write-Host "❌ 索引文件不存在: $INDEX_FILE" -ForegroundColor Red
    Write-Host "请先运行完整安装。"
    exit 1
}

try {
    $index = Get-Content $INDEX_FILE -Raw | ConvertFrom-Json
} catch {
    Write-Host "❌ 索引文件格式错误: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
$skills = $index.skills

# ─── 工具函数 ────────────────────────────────────────────────────────────
function Show-SkillCard($skill) {
    $stars = "⭐" * $skill.quality_score
    $alt = if ($skill.alternatives.Count -gt 0) { "替代: " + ($skill.alternatives -join ", ") } else { "无替代" }

    Write-Host ""
    Write-Host "  $($skill.emoji)  $($skill.display_name)" -ForegroundColor Cyan -NoNewline
    Write-Host "  [$($skill.name)]"
    Write-Host "  ──────────────────────────────────────────"
    Write-Host "  📝 $($skill.description)"
    Write-Host "  🏷️  场景: $($skill.use_cases -join ' | ')"
    Write-Host "  ⭐ 质量: $stars ($($skill.quality_score)/5)"
    Write-Host "  💰 变现: $($skill.monetization)"
    Write-Host "  🔧 平台: $($skill.platform)"
    Write-Host "  💲 价格: $($skill.pricing)"
    Write-Host "  🔗 $alt"
    Write-Host "  📖 评测: $($skill.review)" -ForegroundColor Gray
}

function Find-SkillsByKeyword($skills, $keyword) {
    $k = $keyword.ToLower()
    $skills | Where-Object {
        $_.name.ToLower().Contains($k) -or
        $_.display_name.ToLower().Contains($k) -or
        $_.description.ToLower().Contains($k) -or
        $_.category.ToLower().Contains($k) -or
        ($_.use_cases -join " ").ToLower().Contains($k)
    }
}

function Get-CategoryEmoji($cat) {
    switch ($cat) {
        "task-management" { "📋" }
        "note-taking"     { "📝" }
        "knowledge-management" { "💎" }
        "email"           { "📧" }
        "development"     { "⚡" }
        "information"     { "🔍" }
        "productivity"    { "📊" }
        "automation"      { "🤖" }
        "smart-home"      { "🏠" }
        "social"          { "💬" }
        "communication"   { "📱" }
        "enterprise"      { "🏢" }
        "travel"          { "🚄" }
        "security"        { "🛡️" }
        "content-creation" { "🎨" }
        "deployment"      { "🚀" }
        default           { "📦" }
    }
}

# ─── 命令实现 ────────────────────────────────────────────────────────────

switch ($Command) {
    "list" {
        Write-Host ""
        Write-Host "🔍 Skill Scout v1.0.0 - OpenClaw Skill 数据库" -ForegroundColor Green
        Write-Host "─────────────────────────────────────────────────"
        Write-Host "共 $($skills.Count) 个 Skill | 最后更新: $($index.last_updated)"
        Write-Host ""

        $byCategory = $skills | Group-Object category | Sort-Object Name
        foreach ($group in $byCategory) {
            $catEmoji = Get-CategoryEmoji $group.Name
            Write-Host "$catEmoji  $($group.Name.ToUpper()) ($($group.Count)个)" -ForegroundColor Yellow
            foreach ($s in $group.Group | Sort-Object quality_score -Descending) {
                $stars = "⭐" * $s.quality_score
                Write-Host "  $($s.emoji) $($s.name) $stars"
            }
            Write-Host ""
        }
    }

    "find" {
        if ($Args.Count -eq 0) {
            Write-Host "用法: .\skill-scout.ps1 find <关键词>" -ForegroundColor Yellow
            Write-Host "示例: .\skill-scout.ps1 find ""日程管理"""
            exit 1
        }

        $query = $Args -join " "
        $results = Find-SkillsByKeyword $skills $query

        if ($results.Count -eq 0) {
            Write-Host "❌ 没有找到匹配『$query』的 Skill" -ForegroundColor Red
            Write-Host "💡 尝试: list 查看所有 Skill"
            exit 0
        }

        Write-Host ""
        Write-Host "🔍 搜索『$query』- 找到 $($results.Count) 个结果" -ForegroundColor Green
        Write-Host ""

        foreach ($s in $results | Sort-Object quality_score -Descending) {
            Show-SkillCard $s
        }
    }

    "info" {
        if ($Args.Count -eq 0) {
            Write-Host "用法: .\skill-scout.ps1 info <skill名称>" -ForegroundColor Yellow
            Write-Host "示例: .\skill-scout.ps1 info things-mac"
            exit 1
        }

        $name = $Args[0]
        $skill = $skills | Where-Object { $_.name -eq $name -or $_.name.ToLower() -eq $name.ToLower() }

        if (-not $skill) {
            Write-Host "❌ 未找到 Skill: $name" -ForegroundColor Red
            Write-Host "💡 运行 'list' 查看所有可用 Skill"
            exit 1
        }

        Show-SkillCard $skill
        Write-Host ""
        Write-Host "💡 安装命令（参考各 skill 文档）" -ForegroundColor Gray
    }

    "compare" {
        if ($Args.Count -lt 2) {
            Write-Host "用法: .\skill-scout.ps1 compare <skill1> <skill2> [skill3...]" -ForegroundColor Yellow
            Write-Host "示例: .\skill-scout.ps1 compare things-mac apple-reminders"
            exit 1
        }

        $names = $Args
        $compareSkills = foreach ($name in $names) {
            $skills | Where-Object { $_.name -eq $name -or $_.name.ToLower() -eq $name.ToLower() }
        }

        Write-Host ""
        Write-Host "⚖️  Skill 对比" -ForegroundColor Green
        Write-Host ""

        $compareSkills | ForEach-Object {
            $s = $_
            Write-Host "┌─ $($s.emoji) $($s.display_name)" -ForegroundColor Cyan
            Write-Host "│  质量: $( '⭐' * $s.quality_score ) ($($s.quality_score)/5)"
            Write-Host "│  平台: $($s.platform)"
            Write-Host "│  价格: $($s.pricing)"
            Write-Host "│  场景: $($s.use_cases -join ', ')"
            Write-Host "│  变现: $($s.monetization)"
            Write-Host "│  评测: $($s.review)" -ForegroundColor Gray
            Write-Host ""
        }

        # 推荐结论
        $best = ($compareSkills | Sort-Object quality_score -Descending)[0]
        Write-Host "✅ 推荐: $($best.display_name)" -ForegroundColor Green
        Write-Host "   理由: 质量评分最高 ($($best.quality_score)/5) - $($best.monetization)"
    }

    "search" {
        if ($Args.Count -eq 0) {
            Write-Host "用法: .\skill-scout.ps1 search <场景>" -ForegroundColor Yellow
            Write-Host "示例: .\skill-scout.ps1 search ""笔记整理"""
            exit 1
        }
        # search 是 find 的别名
        $query = $Args -join " "
        $results = Find-SkillsByKeyword $skills $query

        if ($results.Count -eq 0) {
            Write-Host "❌ 没有找到匹配『$query』的 Skill" -ForegroundColor Red
            exit 0
        }

        Write-Host ""
        Write-Host "🔍 搜索『$query』- 找到 $($results.Count) 个结果" -ForegroundColor Green
        foreach ($s in $results | Sort-Object quality_score -Descending) {
            Show-SkillCard $s
        }
    }

    "recommend" {
        Write-Host ""
        Write-Host "🎯 Skill Scout 场景推荐" -ForegroundColor Green
        Write-Host "─────────────────────────────────────────────────"
        Write-Host ""

        $scenarios = [ordered]@{
            "我每天要管理很多任务"        = @("things-mac", "apple-reminders")
            "我要整理笔记和知识库"         = @("obsidian", "bear-notes")
            "我要处理邮件"                = @("himalaya", "email-manager")
            "我要做代码开发"              = @("coding-agent", "github")
            "我要自动化文件管理"           = @("file-manager")
            "我要控制智能家居"             = @("sonoscli", "blucli")
            "我要做内容创作"              = @("audiopod", "IMA Studio Image Generation")
            "我要学习 B站视频"            = @("bilibili-video-analyzer")
            "我要监控定时任务"            = @("cron-helper")
            "我要做飞书文档管理"          = @("feishu-doc", "feishu-wiki", "feishu-drive")
        }

        $i = 1
        foreach ($scenario in $scenarios.Keys) {
            Write-Host "$i. $scenario" -ForegroundColor Yellow
            $i++
        }

        Write-Host ""
        $choice = Read-Host "选择你的场景 (1-$($scenarios.Count)) 或输入自定义需求"
        if ($choice -match "^\d+$" -and [int]$choice -ge 1 -and [int]$choice -le $scenarios.Count) {
            $selectedScenario = $scenarios.Keys[[int]$choice - 1]
            $skillNames = $scenarios[$selectedScenario]
            $recommended = $skills | Where-Object { $skillNames -contains $_.name }
            Write-Host ""
            Write-Host "✅ 推荐场景: $selectedScenario" -ForegroundColor Green
            foreach ($s in $recommended) {
                Show-SkillCard $s
            }
        } else {
            $results = Find-SkillsByKeyword $skills $choice
            if ($results) {
                Write-Host ""
                Write-Host "🔍 搜索『$choice』- 找到 $($results.Count) 个结果" -ForegroundColor Green
                foreach ($s in $results | Sort-Object quality_score -Descending) {
                    Show-SkillCard $s
                }
            }
        }
    }
}
