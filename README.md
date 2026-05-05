# SwiftUI + CodeEditorView

## 简介

这个 Demo 演示如何在 `SwiftUI` 中直接使用 `CodeEditorView`。

它相对前一个 `STTextView` demo，优势在于更偏“代码编辑器”：

- 内置 syntax highlight
- 有 minimap
- 有 message 通道
- 设计目标就是 code editor

## 快速开始

### 环境要求

- macOS 14+
- Xcode.app 已安装

### 运行

```bash
cd /Volumes/SN550-2T/freewind-demos/swiftui-codeeditorview-macos-demo
DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer swift run
```

## 概念讲解

### 第一部分：最小编辑器实例

最小代码如下：

```swift
CodeEditor(
    text: $text,
    position: $position,
    messages: $messages,
    language: .swift()
)
```

这里已经把三个关键状态接出来了：

- `text`：编辑内容
- `position`：光标/滚动位置
- `messages`：诊断或提示信息

### 第二部分：语言与主题

`CodeEditorView` 依赖 `LanguageSupport`：

```swift
language: .swift()
```

主题通过 environment 注入：

```swift
.environment(
    \.codeEditorTheme,
    colorScheme == .dark ? Theme.defaultDark : Theme.defaultLight
)
```

这让它比普通文本框更像真正的 code editor。

### 第三部分：适合什么场景

这个库适合你想要：

- 纯 SwiftUI
- 原生路线
- 比普通文本框更接近 IDE

但又不想一上来自己拼完整 syntax/minimap/message 基建。

## 完整示例

完整代码在 `Sources/swiftui-codeeditorview-macos-demo/swiftui_codeeditorview_macos_demo.swift`。

运行后你会看到一个带 Swift 语言模式的 editor：

- 可直接编辑
- 会按浅色/深色模式切主题
- 保留 `messages` 接口，便于后续接 diagnostics

## 注意事项

- 这个 demo 没接外部 LSP
- `messages` 目前只是空集合，占位给后续 diagnostics
- 若你要完整 completion/hover，仍要继续接语言服务

## 完整讲解

`CodeEditorView` 的定位介于“普通文本组件”和“完整 IDE”之间。  
它已经把很多 code-editor 特征放进一个 SwiftUI view：

- 语言感知
- theme
- message 通道
- 更像 IDE 的视觉

这意味着你少写很多底层 UI 胶水。  
如果你比较看重：

1. 纯原生
2. 比 STTextView bare editor 更接近 code editor
3. 又不想上 WebView

那它是很顺手的折中点。

它的现实 tradeoff 也清楚：  
开箱比普通文本框强，但“智能体验”上限仍取决于你后续怎么接 diagnostics、completion、hover、definition 这些能力。
