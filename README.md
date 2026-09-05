# 数学错题整理（本地离线版）

一款**个人使用、Android、本地离线、以打印为核心**的数学错题整理 App。

原项目（AI 错题本）基于 Flutter 开发；本项目在保留 Flutter / Riverpod / GoRouter / Drift 等工程基础的同时，
改造成**不使用任何 AI / OCR / 云服务**的本地应用。当前阶段数据与代码为全新设计，不与旧 AI 数据库兼容。

**产品原则：数学内容准确 > 自动化程度 > 视觉效果。原图永不修改、不改坏公式与图形。**

## 当前功能（Phase 1）

- **试卷（Paper）管理**：新建 / 编辑 / 删除试卷。
- **拍照 / 相册导入多张试卷照片（Page）**：原图保留在本地文件系统，永不修改。
- **本地确定性图片质量检查**：清晰度（Laplacian 方差）、曝光、有效分辨率；
  质量不佳时不强制拒绝，由用户选择「仍然使用 / 重新拍摄 / 跳过」。
- **Page 浏览器**：横向翻页浏览每张试卷照片。
- **手动矩形框选错题区域（Block）**：选区以 0~1 归一化坐标保存；
  支持左上 / 中央 / 右下、反向拖动与边界越界，保存前校验选区是否过小。
- **错题篮**：框选后可「新建错题」或「加入已有错题（Q3 / Q7 / Q11…）」，
  支持**跨页**给同一道错题连续添加区域块。
- **Block 分类**：题干 / 选项 / 题目续接 / 图形 / 答案 / 解答过程 / 答题过程 / 老师批注 / 其他。
- **错题本与错题详情**：题目列表、Block 缩略图、**拖动排序**、删除、题号/标题/知识点编辑。
- **答案资源（AnswerResource）数据模型**：答案与题目分离，可标记来源（原卷/答案册/搜题/AI 平台截图/手输等，仅作标签）。

### 不包含的能力

本项目明确**不包含**以下内容（未来也不会加入为产品功能）：

- 云服务器、账号登录、联网同步
- OCR / 数学 OCR / LaTeX 识别
- 大语言模型、AI 视觉分析、AI 追问、AI 出题、AI 图片增强
- 任何改变公式、符号、数字、几何图的生成式处理
- API Key / 付费 OCR / LLM 服务

## 技术栈

| 分类 | 技术 |
|------|------|
| 框架 | Flutter（Android） |
| 状态管理 | Riverpod |
| 路由 | GoRouter |
| 本地数据库 | Drift (SQLite，独立于旧库) |
| 图片本地处理 | image（纯 Dart 解码 / 裁剪 / 指标） |
| 图片选择 | image_picker |
| 主题方案 | flex_color_scheme + Material 3 |

图片处理全部在**本地**完成：灰度直方图 / Laplacian 清晰度 / 曝光统计 / 矩形裁剪等，
不使用任何 AI 模型或云端接口。

## 项目结构

```
lib/
├── main.dart                       # 新应用入口（本地离线产品）
├── src/mistake/                    # 当前产品代码
│   ├── db/                         # Drift 数据模型 Paper/Page/Question/Block/AnswerResource
│   ├── storage/                    # 本地图片存储（原图/区块裁剪）
│   ├── services/                   # 图片质量检查、选区归一化几何
│   ├── screens/                    # 试卷/页浏览/框选/错题本/错题详情
│   └── providers.dart
└── src/…（旧 AI 错题本模块，暂保留待后续阶段清理，不参与新入口）
```

## 数据与隐私

- 所有数据与图片保存在**本地**（SQLite + 文件系统），不联网、不收集任何信息。
- 拍摄 / 导入的原始照片被原样保留在
  `papers/<paperId>/original/`；框选裁剪产物写入 `papers/<paperId>/blocks/`。
- Block 坐标使用归一化 0~1 存储（`x, y, width, height`），保证与显示尺寸无关。

## 路线图（后续阶段）

- **Phase 2**：本地图像清理（光照归一化、去噪、锐化、白边裁剪、彩色手写去除）、
  手写擦除/恢复编辑器、字号统一估算、标签管理、ZIP 备份恢复。
- **Phase 3**：打印核心 —— A4 排版引擎、剪贴错题纸 / 复习卷两种 PDF 模式、
  每题答题空间调节、A4 预览与导出、Android 打印分享。

## 开发

### 环境要求
- Flutter SDK >= 3.4.0
- Android SDK

### 安装依赖
```bash
flutter pub get
```

### 运行
```bash
flutter run
```

### 测试与静态检查
```bash
flutter analyze
flutter test
```

### 构建 APK
```bash
flutter build apk --release
```

## 原项目来源

本项目由 [tjunsh/ai-wrong-notebook](https://github.com/tjunsh/ai-wrong-notebook)
（AI 错题本）改造而来。原项目的技术栈与部分工程结构为本项目提供了基础；
当前产品已去除 AI / OCR 相关产品能力，改为本地离线的数学错题整理与打印工具。

## License

MIT（详见 [LICENSE](LICENSE)）。
