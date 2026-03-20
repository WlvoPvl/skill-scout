# Skill Scout 🔍

> OpenClaw Skills 发现、评测、推荐的智能引擎 — 28个第一手实测数据

[![Stars](https://img.shields.io/github/stars/WlvoPvl/skill-scout?style=social)](https://github.com/WlvoPvl/skill-scout)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 痛点

OpenClaw 有 **121+ 个 Skills**，但：
- ❌ 没有场景化搜索（Clawhub 是仓库，不是推荐引擎）
- ❌ 不知道哪个 skill 适合自己的需求
- ❌ 装了不好用，不知道替代方案
- ❌ 优质 skill 淹没在噪音里，评测数据分散

## 解决方案

**Skill Scout = 结构化评测数据库 + 场景化推荐引擎**

| 功能 | 免费版 | Pro 版 |
|------|--------|--------|
| Skill 索引浏览（28个已评测） | ✅ | ✅ |
| 场景化推荐 | ✅ | ✅ |
| 安装命令生成 | ✅ | ✅ |
| AI 深度对比 + 决策报告 | ❌ | ✅ |
| 一对一配置咨询 | ❌ | ✅ |

## 快速开始

```powershell
# 按场景搜索
.\skill-scout.ps1 find "日程管理"

# 查看详情
.\skill-scout.ps1 info things-mac

# 竞品对比
.\skill-scout.ps1 compare "apple-reminders" "things-mac"

# 交互式推荐
.\skill-scout.ps1 recommend
```

**示例输出：**
```
🔍 搜索『邮件』- 找到 2 个结果

  📧 Himalaya  [himalaya]
  ──────────────────────────────────────────
  ⭐ 质量: ⭐⭐⭐⭐⭐ (5/5)   💰 变现: 中
  📝 全平台邮件 CLI 最优解，支持多账户+MML 撰写
  🔗 替代: email-manager
```

## 评分标准（5分制）

| 维度 | 说明 |
|------|------|
| 质量 | 功能完整度 + 稳定性 + 实际效果 |
| 易安装 | 配置复杂度（1=难，5=开箱即用） |
| 平台 | 支持广度 |
| 变现 | 目标用户付费意愿 |

## 支持的场景

| 场景 | 推荐 Skills |
|------|------------|
| 日历/任务管理 | `things-mac`, `apple-reminders` |
| 笔记整理 | `obsidian`, `bear-notes`, `apple-notes` |
| 邮件处理 | `himalaya`, `email-manager` |
| 代码开发 | `coding-agent`, `github` |
| AI 搜索 | `web_search`, `gog` |
| 自动化 | `tmux`, `cron-helper`, `file-manager` |
| 智能家居 | `sonoscli`, `blucli` |
| 社交媒体 | `douyin-messager`, `imsg` |
| 飞书集成 | `feishu-doc`, `feishu-wiki`, `feishu-drive` |
| 出行 | `mcporter-railway-query` |
| 内容创作 | `audiopod`, `IMA Studio Image Generation` |
| 视频学习 | `bilibili-video-analyzer` |
| 安全/部署 | `healthcheck`, `render` |

## 数据来源

- 🏠 **第一手实测**：作者日常使用评测
- 🌐 **社区智慧**：InStreet Agent 社区真实反馈
- 📦 **Clawhub**：clawhub.com 公开数据

## 项目结构

```
skill-scout/
├── skill-scout.ps1      # CLI 推荐引擎
├── skills-index.json    # Skill 评测数据库
├── README.md
├── LICENSE              # MIT
└── .gitignore
```

## License

MIT © Skill Scout | 欢迎 Fork 和贡献
