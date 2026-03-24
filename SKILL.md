---
name: skill-scout
description: OpenClaw Skill 发现引擎 — 场景化推荐 + 第一手实测评分数据
tags: [discovery, openclaw, skill, agent-tooling]
license: MIT

clawdis:
  emoji: 🔍
  homepage: https://github.com/WlvoPvl/skill-scout
  skillKey: skill-scout
  primaryEnv: GITHUB_TOKEN
  os: [windows, macos, linux]
  requires:
    bins: [git, node]
    anyBins: [powershell, bash, zsh]
    env: [GITHUB_TOKEN]
  install:
    - path: SKILL.md
      type: skill-manifest
    - path: skills-index.json
      type: data
    - path: skill-scout.ps1
      type: script
    - path: CLAUDE.md
      type: agent-rules
    - path: validate.ps1
      type: quality-script

metadata:
  openclaw:
    platform: cross-platform
    verified: true
    author: WlvoPvl
    install_cmd: git clone https://github.com/WlvoPvl/skill-scout
    repo: https://github.com/WlvoPvl/skill-scout
    commit: ac05f9f2b5

readme: README.md
readmeVersion: 1
---

# Skill Scout

OpenClaw Skill 发现引擎 — 场景化推荐 + 第一手实测数据。

## 核心数据

- **28+** OpenClaw Skill 实测评分
- **5** 维度评估：功能完整度、安装难度、平台支持、变现潜力、实测体验
- **CLI** 推荐引擎（PowerShell）
- **场景化搜索** / 竞品对比 / 交互推荐

## 快速使用

```powershell
# 克隆仓库
git clone https://github.com/WlvoPvl/skill-scout

# 查看推荐
.\skill-scout.ps1 recommend "邮件管理"

# 搜索
.\skill-scout.ps1 search "github"
```

## 数据文件

| 文件 | 说明 |
|------|------|
| `skills-index.json` | 28个skill的第一手实测数据 |
| `skill-scout.ps1` | CLI 推荐引擎 |
| `CLAUDE.md` | Agent 工作规则 |
| `validate.ps1` | 质量验证脚本 |

## 评分维度

| 维度 | 说明 |
|------|------|
| quality_score | 功能完整度 + 稳定性（1-5）|
| install_difficulty | 安装难度（1=很难，5=开箱即用）|
| platform | 支持平台 |
| monetization | 变现潜力 |
| author_experience | 第一手实测体验 |

## 发布历史

- **2026-03-21**: 初始化，28个skill评测数据
- **2026-03-24**: 对齐 ClawHub SKILL.md v2 格式

## 变现路径

- 短期: Skill 配置咨询（$20-50/次）
- 中期: Pro 推荐算法 + 使用报告
- 长期: Skill Marketplace 分成
