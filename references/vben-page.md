# Vben Page 组件参考文档
## 组件概述
Page 是 Vben Admin 的标准页面布局组件，提供页面结构：页头、内容区、页脚。

## 组件属性（Props）
### title
- **Type**: `string | slot`
- **Default**: None
- **Description**: 页面标题，可通过 prop 或 slot 传入

### description
- **Type**: `string | slot`
- **Default**: None
- **Description**: 页面描述文本，显示在标题下方

### contentClass
- **Type**: `string`
- **Default**: None
- **Description**: 内容区自定义 CSS 类名

### headerClass
- **Type**: `string`
- **Default**: None
- **Description**: 页头区自定义 CSS 类名

### footerClass
- **Type**: `string`
- **Default**: None
- **Description**: 页脚区自定义 CSS 类名

### autoContentHeight
- **Type**: `boolean`
- **Default**: `false`
- **Description**: 自动调整内容区高度

## 插槽
### default
- **Description**: 页面主内容区域

### title
- **Description**: 自定义页面标题（优先级高于 title prop）

### description
- **Description**: 自定义页面描述（优先级高于 description prop）

### extra
- **Description**: 页面头部右侧扩展内容区域

### footer
- **Description**: 页面底部内容区域

## 重要说明
**页头渲染规则**：
- 如果 `title`、`description`、`extra` 都没有内容（无论来自 props 还是 slots），页头不会渲染。
- 至少提供其中一项，页头才会显示。

## 使用模板
**具体模板用法和代码示例请参考**：`assets/page-template.md`
