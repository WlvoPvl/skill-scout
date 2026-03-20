# Skill Scout 🔍

> 发现、评测、推荐 OpenClaw Skills 的智能引擎

[![Stars](https://img.shields.io/github/stars/skill-scout/skill-scout?style=social)](https://github.com/skill-scout/skill-scout)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 痛点

OpenClaw 有 **121+ 个 Skills**，但：
- ❌ Clawhub 无搜索、无推荐
- ❌ 不知道哪个 skill 适合自己的场景
- ❌ 装了不好用，不知道替代方案
- ❌ 优质 skill 淹没在噪音里

## 解决方案

Skill Scout = **结构化 Skill 数据库 + 推荐引擎**

| 功能 | 免费版 | Pro 版 |
|------|--------|--------|
| Skill 索引浏览 | ✅ | ✅ |
| 场景化推荐 | ✅ | ✅ |
| 安装命令生成 | ✅ | ✅ |
| AI 深度对比 | ❌ | ✅ |
| 个性化配置咨询 | ❌ | ✅ |

## 快速开始

```powershell
# 查询适合的场景的 skill
.\skill-scout.ps1 find "日程管理"

# 查看 skill 详情
.\skill-scout.ps1 info things-mac

# 竞品对比
.\skill-scout.ps1 compare "apple-reminders" "things-mac"
```

## 支持的场景

| 场景 | 推荐 Skills |
|------|------------|
| 日历/任务管理 | `things-mac`, `apple-reminders` |
| 笔记整理 | `apple-notes`, `bear-notes`, `obsidian` |
| 邮件处理 | `himalaya`, `email-manager` |
| 代码开发 | `coding-agent`, `github` |
| AI 搜索 | `web_search`, `gog` (Gmail/Calendar) |
| 自动化 | `tmux`, `sonoscli`, `blucli` |
| 文件管理 | `file-manager` |
| 社交媒体 | `douyin-messager`, `imsg` |
| 飞书集成 | `feishu-doc`, `feishu-wiki`, `feishu-drive` |
| 出行 | `mcporter-railway-query` |
| 健康/监控 | `healthcheck` |
| 内容创作 | `audiopod`, `IMA Studio Image Generation` |
| 视频学习 | `bilibili-video-analyzer` |
| 定时任务 | `cron-helper` |

## 项目结构

```
skill-scout/
├── skill-scout.ps1      # CLI 推荐引擎
├── skills-index.json    # Skill 数据库
├── README.md
├── CONTRIBUTING.md
└── LICENSE
```

## 数据来源

- 第一手评测：作者实际使用过的 skill
- 社区反馈：InStreet Agent 社区真实评价
- Clawhub 索引：clawhub.com 公开数据

## 如何贡献

发现优质 skill 或有评测数据？欢迎 PR：
1. Fork 本仓库
2. 更新 `skills-index.json`
3. 提交 PR，带上使用体验

详见 [CONTRIBUTING.md](CONTRIBUTING.md)

## License

MIT © Skill Scout
