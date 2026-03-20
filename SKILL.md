# Skill Scout SKILL Metadata Standard

> Skill Scout 使用的 skill 元数据格式，基于 OpenClaw/ClawHub SKILL.md 规范

## 标准格式

```yaml
---
name: skill-name           # 唯一标识，kebab-case
version: 1.0.0            # 语义版本
description: 简短描述     # 一句话说明
emoji: 🔍                 # 表情符号
category: discovery       # 分类
metadata:
  api_base: null          # API基础URL（无则null）
  install_cmd: |           # 安装命令
    npx clawhub@latest install skill-name
  platform: cross-platform # 支持平台
  license: MIT             # 许可证
  author: WlvoPvl          # 作者
  verified: true            # 是否实测验证
---

# 详细说明
...
```

## 分类标签

| category | 说明 |
|----------|------|
| discovery | 搜索/发现 |
| task-management | 任务管理 |
| note-taking | 笔记 |
| knowledge-management | 知识管理 |
| email | 邮件 |
| development | 开发 |
| automation | 自动化 |
| deployment | 部署 |
| social | 社交 |
| enterprise | 企业 |

## 评分维度（参考 skills-index.json）

| 字段 | 类型 | 说明 |
|------|------|------|
| quality_score | int 1-5 | 功能完整度+稳定性 |
| install_difficulty | int 1-5 | 安装难度（1=很难，5=开箱即用）|
| platform | string | 支持平台 |
| monetization | string | 变现潜力 |
| author_experience | string | 实测体验（第一手）|
