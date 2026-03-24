# Skill Scout 🔍

> OpenClaw Skills 真实使用数据库 — 每个分数来自实操，不是充值选手

[![Stars](https://img.shields.io/github/stars/WlvoPvl/skill-scout?style=social)](https://github.com/WlvoPvl/skill-scout)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## 为什么存在

OpenClaw 有 **121+ 个 Skills**，但：
- ❌ ClawHub 只告诉你「有什么」，不告诉你「哪个好用」
- ❌ 试错成本高（装一堆，最后发现不适合自己）
- ❌ 没有真实用户在真实场景下的评测数据

**Skill Scout 在做的事：收集 Agent 的真实使用经验，贡献给所有 OpenClaw 用户。**

---

## 数据样本（28个已收录）

| Skill | 评分 | 平台 | 一句话点评 |
|-------|------|------|-----------|
| `things-mac` | ⭐5 | macOS | 最稳的 Things 3 CLI，每日使用 |
| `apple-reminders` | ⭐4 | macOS/iOS | 零成本，系统自带够用 |
| `bear-notes` | ⭐4 | macOS | Bear 用户首选，比 Apple Notes 强 |
| `himalaya` | ⭐5 | 跨平台 | 全平台邮件最优解，多账户+MML撰写 |
| `email-manager` | ⭐3 | 跨平台 | Gmail API，配置略繁但功能完整 |
| `apple-notes` | ⭐3 | macOS | 基础够用，深度不如 Bear |
| `github` | ⭐5 | 跨平台 | Issue/PR/Action 全覆盖，CLI 最强 |
| `cron-helper` | ⭐4 | 跨平台 | cron 语法转自然语言，小白友好 |
| `gog` | ⭐4 | 跨平台 | Google Workspace 全家桶，邮件/日历/ Drive |
| `render` | ⭐4 | 跨平台 | Render 部署自动化，BluePrint 最佳实践 |
| `healthcheck` | ⭐4 | 跨平台 | 安全审计+系统监控，实用性强 |
| `coding-agent` | ⭐4 | 跨平台 | Codex CLI 控制，编程效率提升明显 |
| `feishu-doc` | ⭐5 | 跨平台 | 飞书文档读写，官方 skill 最完整 |
| `feishu-wiki` | ⭐4 | 跨平台 | 知识库导航，配合 doc 使用 |
| `douyin-messager` | ⭐4 | 跨平台 | 抖音私信自动化，浏览器方案稳定 |
| `bilibili-video-analyzer` | ⭐4 | 跨平台 | B站学习视频→结构化笔记，实用 |
| `foreseekai` | ⭐4 | 跨平台 | Kalshi 预测市场，parse/trade 全套 |
| `audiopod` | ⭐4 | 跨平台 | AI音乐生成+音频处理，功能丰富 |
| `image-tools` | ⭐4 | 跨平台 | SeeDream 4.5/Midjourney/Nano Banana 多合一 |
| `oracle` | ⭐3 | 跨平台 | 代码review，参考价值一般 |

> 完整数据见 [skills-index.json](./skills-index.json)

---

## 评分标准

| 维度 | 说明 |
|------|------|
| 质量 | 功能完整度 + 稳定性 + 实际效果（1-5） |
| 易安装 | 配置复杂度（1=难配置，5=开箱即用） |
| 平台 | macOS/Windows/跨平台 |
| 真实感 | 来自作者日常使用，没有充值 |

---

## 快速使用

```powershell
# 按场景搜索
.\skill-scout.ps1 find "邮件"

# 查看详情
.\skill-scout.ps1 info himalaya

# 竞品对比
.\skill-scout.ps1 compare "himalaya" "email-manager"

# 交互式推荐
.\skill-scout.ps1 recommend
```

---

## 🤝 共创：如何贡献你的评测

> 这个数据库的价值取决于参与者的真实使用经验。

### 贡献方式

**方式1：提交 Issue（最简单）**

在 GitHub 提交一个 Issue，格式：
```
### 你评测的 Skill 名称
`skill-name`

### 你给几分？（1-5）
⭐⭐⭐⭐⭐

### 你的使用场景
（什么情况下你会用这个skill？）

### 你的真实感受
（好用在哪里，不好用在哪里？）

### 平台
macOS / Windows / Linux
```

**方式2：提交 PR（直接改数据）**

编辑 `skills-index.json`，按现有格式添加或修改条目，发 Pull Request。

**方式3：扩展 CLI**

`skill-scout.ps1` 欢迎功能增强建议，开 Issue 讨论。

---

## 项目结构

```
skill-scout/
├── skill-scout.ps1      # CLI 推荐引擎
├── skills-index.json    # Skill 评测数据库（JSON 格式，易于机器读取）
├── SKILL.md             # Skill 元数据格式标准
├── LICENSE              # MIT
└── .gitignore
```

---

## 背景

作者是 OpenClaw 重度用户，日常用 OpenClaw 管理日程、邮件、代码开发、飞书文档等。这个数据库最初是给自己整理的，后来发现社区里经常有人问「哪个 skill 好用」，于是决定公开。

**收录标准：有真实使用经验才会收录。** 没有试过的不写，没资格打分的不写。

---

## License

MIT © Skill Scout | 欢迎贡献你的使用经验

