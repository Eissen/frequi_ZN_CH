# VSCode 英文查找替换工具推荐

针对 FreqUI 汉化工作，推荐以下 VSCode 扩展和技巧：

## 🔍 内置功能（无需安装）

### 1. 多文件查找替换（最常用）

**快捷键：** `Ctrl+Shift+H` (Windows/Linux) 或 `Cmd+Shift+H` (Mac)

**使用方法：**
1. 按 `Ctrl+Shift+H` 打开查找替换面板
2. 在搜索框输入要查找的英文文本
3. 在替换框输入中文翻译
4. 点击搜索框右侧的文件夹图标，选择搜索范围（如 `src/components`）
5. 使用正则表达式（点击 `.*` 图标）进行复杂匹配
6. 点击"全部替换"或逐个替换

**示例：**
- 查找：`'Stop Bot'`
- 替换：`'停止机器人'`
- 范围：`src/components/ftbot`

### 2. 正则表达式查找替换

启用正则模式（点击搜索框右侧的 `.*` 图标），可以使用强大的正则表达式：

**常用模式：**

```regex
# 查找所有 title="..." 中的英文
title="([^"]+)"

# 查找所有 '...' 字符串中的英文（单引号）
'([A-Z][^']+)'

# 查找所有 message: '...' 中的文本
message:\s*'([^']+)'
```

**替换示例：**
- 查找：`title="([^"]+)"`
- 替换：`title="$1"` （先找到所有，再手动替换）

### 3. 多光标编辑

**快捷键：** `Ctrl+D` (选择下一个相同文本) 或 `Alt+Click` (添加光标)

**使用场景：**
- 同一个文件中多次出现的相同文本
- 需要逐个确认替换的情况

## 📦 推荐扩展

### 1. **Find and Replace** (扩展 ID: `mde.find-and-replace`)

功能强大的查找替换工具，支持：
- 多文件批量替换
- 正则表达式
- 保存替换历史
- 预览替换结果

**安装：**
```bash
code --install-extension mde.find-and-replace
```

### 2. **Replace Rules** (扩展 ID: `adammaras.replace-rules`)

可以定义替换规则，批量执行多个替换操作。

**安装：**
```bash
code --install-extension adammaras.replace-rules
```

### 3. **Batch Replace** (扩展 ID: `m1guelpf.batch-replace`)

支持使用 JSON 文件定义批量替换规则。

**安装：**
```bash
code --install-extension m1guelpf.batch-replace
```

### 4. **i18n Ally** (扩展 ID: `lokalise.i18n-ally`)

虽然这个项目没有使用 i18n，但这个扩展可以帮助：
- 查找所有硬编码的文本
- 管理翻译键值对
- 如果将来要添加 i18n 支持，这个工具很有用

**安装：**
```bash
code --install-extension lokalise.i18n-ally
```

### 5. **Search and Replace** (扩展 ID: `gabrielbb.search-and-replace`)

增强的搜索替换功能，支持：
- 多文件搜索替换
- 正则表达式
- 文件过滤

**安装：**
```bash
code --install-extension gabrielbb.search-and-replace
```

## 🎯 针对汉化工作的最佳实践

### 方法一：使用内置多文件查找替换

1. **打开查找替换：** `Ctrl+Shift+H`
2. **启用正则表达式：** 点击 `.*` 图标
3. **设置搜索范围：** 点击文件夹图标，选择 `src/components/ftbot`
4. **逐步替换：** 先替换常见的短语，再替换完整句子

**示例替换列表：**

| 查找（正则） | 替换为 |
|------------|--------|
| `'Stop Bot'` | `'停止机器人'` |
| `'Start Trading'` | `'开始交易'` |
| `'Pause - Stop Entering'` | `'暂停 - 停止入场'` |
| `'Reload'` | `'重新加载'` |
| `'ForceExit all'` | `'强制平仓所有'` |

### 方法二：创建替换脚本

创建一个 JSON 文件定义所有替换规则：

**文件：`replace-rules.json`**

```json
{
  "rules": [
    {
      "find": "'Stop Bot'",
      "replace": "'停止机器人'",
      "files": "**/*.vue"
    },
    {
      "find": "'Start Trading'",
      "replace": "'开始交易'",
      "files": "**/*.vue"
    },
    {
      "find": "title=\"Start Trading\"",
      "replace": "title=\"开始交易\"",
      "files": "**/*.vue"
    },
    {
      "find": "'Pause - Stop Entering'",
      "replace": "'暂停 - 停止入场'",
      "files": "**/*.vue"
    },
    {
      "find": "'Reload'",
      "replace": "'重新加载'",
      "files": "**/*.vue"
    },
    {
      "find": "'ForceExit all'",
      "replace": "'强制平仓所有'",
      "files": "**/*.vue"
    },
    {
      "find": "'Stop the bot loop from running\\?'",
      "replace": "'确定要停止机器人运行吗？'",
      "files": "**/*.vue"
    },
    {
      "find": "'Reload configuration \\(including strategy\\)\\?'",
      "replace": "'重新加载配置（包括策略）？'",
      "files": "**/*.vue"
    }
  ]
}
```

### 方法三：使用命令行工具（sed/awk）

对于大量文件，可以使用命令行工具：

```bash
# 在 frequi 目录下批量替换
cd /home/ec2-user/frequi

# 使用 sed 替换（先备份！）
find src -name "*.vue" -type f -exec sed -i.bak "s/'Stop Bot'/'停止机器人'/g" {} \;

# 查看替换结果
grep -r "停止机器人" src/
```

**⚠️ 警告：** 使用命令行工具前一定要先备份或使用 git！

## 🔧 实用技巧

### 1. 使用文件过滤

在查找替换时，可以使用文件过滤：
- `*.vue` - 只搜索 Vue 文件
- `src/components/ftbot/*.vue` - 只搜索特定目录
- `!**/node_modules/**` - 排除 node_modules

### 2. 保存搜索历史

VSCode 会记住你的搜索历史，可以：
- 点击搜索框下拉箭头查看历史
- 使用 `↑` `↓` 键在历史中切换

### 3. 使用工作区搜索

如果只搜索当前打开的文件：
- `Ctrl+F` - 当前文件查找
- `Ctrl+H` - 当前文件替换

### 4. 预览替换结果

在替换前，可以：
1. 点击"查找全部"查看所有匹配项
2. 逐个检查每个匹配项
3. 使用"替换"按钮逐个替换，或"全部替换"批量替换

## 📋 推荐的汉化工作流程

### 第一步：准备替换列表

创建一个文本文件，列出所有需要替换的文本：

```
'Stop Bot' → '停止机器人'
'Start Trading' → '开始交易'
'Pause - Stop Entering' → '暂停 - 停止入场'
...
```

### 第二步：按模块替换

1. **机器人控制模块** (`src/components/ftbot/BotControls.vue`)
2. **交易列表模块** (`src/components/ftbot/TradeList.vue`)
3. **仪表板模块** (`src/views/DashboardView.vue`)
4. 等等...

### 第三步：测试验证

每次替换后：
1. 保存文件
2. 检查开发服务器是否正常运行
3. 在浏览器中查看效果
4. 检查是否有语法错误

### 第四步：使用 Git 管理

```bash
# 创建分支
git checkout -b zh-cn-localization

# 提交更改
git add .
git commit -m "汉化: 机器人控制组件"

# 查看更改
git diff
```

## 🎨 VSCode 设置优化

在 `.vscode/settings.json` 中添加：

```json
{
  "search.exclude": {
    "**/node_modules": true,
    "**/dist": true,
    "**/.git": true
  },
  "search.useGlobalIgnoreFiles": true,
  "search.useIgnoreFiles": true,
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  }
}
```

## 💡 高级技巧

### 使用 VSCode 任务自动化

创建 `.vscode/tasks.json`：

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "查找所有英文文本",
      "type": "shell",
      "command": "grep -r \"title=\\|message:\" src/ --include=\"*.vue\" | grep -E \"[A-Z][a-z]+\"",
      "problemMatcher": []
    }
  ]
}
```

运行任务：`Ctrl+Shift+P` → 输入 "Run Task"

## 📚 相关资源

- [VSCode 搜索文档](https://code.visualstudio.com/docs/editor/codebasics#_search-and-replace)
- [正则表达式参考](https://code.visualstudio.com/docs/editor/codebasics#_regex)
- [VSCode 扩展市场](https://marketplace.visualstudio.com/)

## ⚠️ 注意事项

1. **备份重要文件：** 批量替换前先提交到 git
2. **逐步替换：** 不要一次性替换所有内容，分批进行
3. **检查语法：** 替换后检查 Vue 文件语法是否正确
4. **测试功能：** 每次替换后测试相关功能是否正常
5. **保持一致性：** 确保相同术语的翻译一致

