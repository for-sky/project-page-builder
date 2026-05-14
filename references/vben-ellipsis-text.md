# Vben EllipsisText（省略文本）

框架提供了文本展示组件，可配置长文本省略、tooltip 提示、展开/收起等能力。

**具体用法示例和代码模板请参考**：`assets/ellipsis-text-template.md`

## 重要说明

如果现有组件封装无法满足需求，可以使用原生组件或自行封装组件。框架提供的组件并非强制，按需使用即可。

## 基础用法

通过 max-width 设置最大宽度，超出部分会显示省略号。

## 可折叠文本块

通过 line 设置折叠后的行数，expand 属性用于设置是否支持展开/收起。

## 自定义 Tooltip

通过 tooltip 插槽自定义提示内容。

## 自动显示 Tooltip

通过 tooltip-when-ellipsis 设置，仅在文本超长并出现省略时才触发 tooltip。

## API

## Props

### expand
- **Type**: `boolean`
- **Default**: `false`
- **Description**: 支持点击展开/收起

### line
- **Type**: `number`
- **Default**: `1`
- **Description**: 文本最大显示行数

### maxWidth
- **Type**: `number | string`
- **Default**: `'100%'`
- **Description**: 文本区域最大宽度

### placement
- **Type**: `'bottom' | 'left' | 'right' | 'top'`
- **Default**: `'top'`
- **Description**: tooltip 位置

### tooltip
- **Type**: `boolean`
- **Default**: `true`
- **Description**: 启用文本 tooltip

### tooltipWhenEllipsis
- **Type**: `boolean`
- **Default**: `false`
- **Description**: 内容超长时自动启用文本 tooltip

### ellipsisThreshold
- **Type**: `number`
- **Default**: `3`
- **Description**: 仅在设置 tooltipWhenEllipsis 后生效，文本截断检测像素差阈值，值越大判定越严格；若出现异常可自行调整

### tooltipBackgroundColor
- **Type**: `string`
- **Default**: -
- **Description**: tooltip 背景色

### tooltipColor
- **Type**: `string`
- **Default**: -
- **Description**: tooltip 文字颜色

### tooltipFontSize
- **Type**: `string`
- **Default**: -
- **Description**: tooltip 字体大小

### tooltipMaxWidth
- **Type**: `number`
- **Default**: -
- **Description**: tooltip 最大宽度，不设置则与文本宽度保持一致

### tooltipOverlayStyle
- **Type**: `CSSProperties`
- **Default**: `{ textAlign: 'justify' }`
- **Description**: tooltip 内容区域样式

## 事件

### expandChange
- **Type**: `(isExpand: boolean) => void`
- **Description**: 展开状态变化

## 插槽

### default
- **Description**: 文本内容

### tooltip
- **Description**: 启用文本 tooltip 时用于自定义提示内容
