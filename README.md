# Chinese Writing Kit

## 为什么

常规的 Lint 工具通常专注于代码质量，而忽略了中文文本的书写规范。中文写作有其独特的规则和风格要求，尤其是在标点符号、数字格式、空格使用等方面；此外还有中英文混排的特殊需求。本项目旨在利用更智能的 Copilot，检查并统一中文文本的书写风格，提升文档的专业性和可读性。

本项目旨在提供格式化的中文写作规范，而不会对内容本身进行检查或修改。

## 使用方法

### 一键安装

**macOS / Linux：**

```bash
curl -fsSL https://raw.githubusercontent.com/carolyn-sun/chinese-writing-kit/main/init.sh | bash
```

**Windows (PowerShell)：**

```powershell
irm https://raw.githubusercontent.com/carolyn-sun/chinese-writing-kit/main/init.ps1 | iex
```

### 手动安装

1. 将 `chinese-writing-kit.instructions.md` 文件复制到你的代码库根目录下的 `.github/instructions` 文件夹中（如果没有该文件夹，请先创建）。
2. 确保文件路径为 `.github/instructions/chinese-writing-kit.instructions.md`。
3. 提交并推送到你的代码库。

更多信息请参考 [Adding repository custom instructions for GitHub Copilot](https://docs.github.com/en/copilot/customizing-copilot/adding-repository-custom-instructions-for-github-copilot)。

### 工作方式

GitHub Copilot 会**自动读取**仓库中的 `.instructions.md` 文件，并在以下场景中应用这些规范：

- **代码补全**：当你在 Markdown/MDX 文件中编写中文内容时，Copilot 的自动补全会遵循规范。
- **Copilot Chat**：在对话中请求生成或修改中文文档时，Copilot 会参考这些指令。
- **Copilot Edits**：使用 Copilot 进行批量编辑时，会自动应用规范。

### 手动检查现有文件

如需检查和修复现有文件，可以在 Copilot Chat 中使用以下提示：

```
请检查当前文件的中文写作规范，并修复不符合规范的地方。
```

或批量检查：

```
请检查 docs 目录下所有 Markdown 文件的中文写作规范。
```

### GitHub Action 自动化配置

如果你希望在多个项目中自动同步此规范，可以在你的仓库中添加一个 GitHub Action。

在 `.github/workflows/setup-writing-kit.yml` 中添加：

```yaml
name: Setup Chinese Writing Kit

on:
  schedule:
    - cron: '0 0 1,15 * *' # 每两周运行一次 (每月 1 号和 15 号)
  push:
    branches: [ main ]
  workflow_dispatch:

jobs:
  setup:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Copy Instructions
        uses: carolyn-sun/chinese-writing-kit@main
      - name: Commit and Push
        run: |
          git config --local user.email "action@github.com"
          git config --local user.name "GitHub Action"
          git add .github/instructions/chinese-writing-kit.instructions.md
          git commit -m "chore: sync chinese writing kit instructions" || echo "No changes to commit"
          git push
```

### 注意事项

- Custom instructions 在 Copilot 生成内容时自动生效，无需额外配置。
- 目前不支持保存时自动检查/修复，需要手动通过 Copilot Chat 触发。
- 此 Action 仅负责将规范文件复制到目标仓库的 `.github/instructions/` 目录。