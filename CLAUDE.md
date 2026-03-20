# Skill Scout — Project Rules

> 本文件定义 Claude Code 等 Agent 工具如何理解和处理 Skill Scout 项目

## 项目概述

Skill Scout 是 OpenClaw Skill 的发现、评测、推荐引擎。
核心价值：解决"121+ skills 不知道用哪个"的痛点。

## 文件结构

```
skill-scout/
├── CLAUDE.md          # 本文件 - Agent 工作规则
├── SKILL.md           # Skill 元数据格式标准
├── skill-scout.ps1    # CLI 主程序 (PowerShell)
├── skills-index.json  # Skill 评测数据库
├── github-*.ps1       # GitHub API 上传脚本
├── README.md          # 项目说明
└── LICENSE            # MIT
```

## 开发规则

### 1. 修改 skill-scout.ps1 后
- 必须运行 `.\skill-scout.ps1 list` 验证不报错
- 确认 JSON 输出格式正确

### 2. 修改 skills-index.json 后
- 验证 JSON 格式：`Get-Content skills-index.json | ConvertFrom-Json | Out-Null`
- 确认 `total_skills` 数量与实际 `$skills.Count` 一致

### 3. Commit 规范
- 格式: `fix: / feat: / chore: / docs:`
- 示例: `fix: 修复 compare 命令变量冲突`
- 禁止: "update files", "changes"

### 4. GitHub 推送
- 使用 `github-contents-update.ps1`（Contents API）
- 不使用 `git push`（网络拦截）

## 评分标准

| 维度 | 5分 | 3分 | 1分 |
|------|-----|-----|-----|
| quality_score | 完美/无缺陷 | 基本可用 | 勉强能用 |
| install_difficulty | 一条命令 | 需要配置 | 需编译/多步 |

## 数据来源优先级

1. **第一手实测** — 作者日常使用评测（最高权重）
2. **ClawHub 数据** — clawhub.ai 公开数据（参考）
3. **社区反馈** — InStreet 等 Agent 社区真实评价

## 变现路径

| 阶段 | 方式 |
|------|------|
| 现在 | Skill 配置咨询 ($20-50/次) |
| 中期 | Pro 推荐报告 + 使用指导 |
| 长期 | Skill Marketplace 分成 |

## 参考

- ClawHub 格式: https://clawhub.ai
- OpenClaw: https://openclaw.ai
- SKILL.md 规范: 本目录 SKILL.md
