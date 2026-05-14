---
name: project-page-builder
description: 在 当前项目中生成完整的页面代码、包括图片理解后的结构、CRUD 模块代码，包括页面、表单、表格以及 API 接口。当用户说"生成 CRUD""创建模块""新增页面""写 CRUD""生成表格页""创建 xxx 管理""生成 xxx 模块" "识别图片生成对应页面"等类似需求时，必须使用该 Skill。即使任务看起来很简单也不能跳过。不要直接生成代码。所有关于组件用法的问题，必须先阅读对应组件文档后再回答，绝不能凭记忆回答。页面不使用 Page 组件包裹，直接使用 div 作为根元素。
version: 0.1.1
---

# 页面生成器

## 流程入口

### 步骤 1：判断用户意图

根据用户输入判断走哪个流程：

| 用户意图 | 流程 | 指令 |
|---|---|---|
| 提供了图片（截图、设计稿等） | **图片识别流程** | 阅读 `image-analysis.md` 并执行 |
| 直接要求生成 CRUD 模块（无图片） | **CRUD 生成流程** | 阅读 `crud-generation.md` 并执行 |

**注意**：如果用户提供了图片，统一先走图片识别流程。在图片分析完成后再判断是否为 CRUD 页面，而不是在这一步猜测。

### 步骤 2：执行对应流程

确定流程后，**立即阅读对应的 md 文件**，严格按照文件中的步骤执行：

- **图片识别流程** → 阅读 `image-analysis.md`
- **CRUD 生成流程** → 阅读 `crud-generation.md`

### 步骤 3：图片识别流程的特殊分支

如果在图片识别流程中，识别出图片内容符合 CRUD 模块结构（表格 + 搜索 + 增删改查），则：
1. 完成图片分析步骤
2. 切换到 **CRUD 生成流程**（阅读 `crud-generation.md`），用图片分析结果作为需求输入
3. 继续执行 CRUD 生成的后续步骤

## 核心原则

- 所有代码必须符合 TypeScript strict 模式
- 遵循 Vben Admin 最佳实践与代码风格
- 保持代码简洁，避免过度设计
- 确保类型安全，减少运行时错误
- 必须启用 i18n

## 组件使用规则

### 优先使用框架封装组件

项目已在 `src/adapter/component/index.ts` 中注册了以下 Vben 表单组件，**优先使用这些组件**：

`Input`、`InputNumber`、`Select`、`TreeSelect`、`AutoComplete`、`Checkbox`、`CheckboxGroup`、`Radio`、`RadioGroup`、`Switch`、`DatePicker`、`RangePicker`、`TimePicker`、`TimeRangePicker`、`Textarea`、`Upload`、`Rate`、`Divider`、`Space`、`Tooltip`、`IconPicker`、`ApiComponent`

### 回退到 TDesign 原生组件

如果框架没有封装所需组件（如 `t-button`、`t-tag`、`t-table`、`t-tree`、`t-card`、`t-dialog`、`t-tabs`、`t-tooltip` 等），**直接使用 `tdesign-vue-next` 原生组件**：

```vue
<script setup lang="ts">
import { Card, Tag, Button as TButton, Tree } from 'tdesign-vue-next';
</script>

<template>
  <Card title="示例">
    <TButton theme="primary">
      按钮
    </TButton>
    <Tag>标签</Tag>
  </Card>
</template>
```

**TDesign 组件文档地址：** `https://tdesign.tencent.com/vue-next/overview`

**如果不确定 TDesign 某个组件的用法，使用 `WebFetch` 工具抓取文档页面：**
```
WebFetch https://tdesign.tencent.com/vue-next/components/button
```

### 组件选择决策流程

```
需要使用某个组件
  → 检查 src/adapter/component/index.ts 中是否已注册
    → 是 → 使用 Vben 封装组件（useVbenForm schema 中的 component 字段）
    → 否 → 直接使用 tdesign-vue-next 原生组件
      → 不确定用法？→ 抓取 TDesign 文档或搜索项目中已有用法
```
