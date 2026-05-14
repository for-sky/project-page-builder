# Vben Vxe Table（表格）

框架提供了基于 vxe-table 的 Table 组件，并结合 Vben Form 做了二次封装。

头部搜索表单使用 Vben Form，表体使用 vxe-grid 组件，支持分页、排序、筛选等能力。

如果文档中没有参数说明，请查看在线示例或 vxe-grid 官方 API 文档（https://vxetable.cn/v4/#/grid/api）。

**具体用法示例和代码模板请参考**：`assets/table-usage-template.md`

## 重要说明

如果现有组件封装无法满足需求，可以使用原生组件或自行封装组件。框架提供的组件并非强制，按需使用即可。

## 适配器

表格基于 vxe-table 实现，因此可使用 vxe-table 的全部能力。针对不同 UI 框架，我们提供了适配器以提升兼容性。

**具体适配器配置和代码示例请参考**：`assets/table-adapter-template.md`

## 搜索表单

搜索表单使用 Vben Form，请参考 Vben Form 文档。

启用搜索表单后，可在 toolbarConfig 中将 search 设为 true，在工具栏显示搜索表单控制按钮。所有以 form- 开头的插槽都会透传给搜索表单。

## 自定义分隔线

启用搜索表单后，表单与表格之间会显示分隔线。该分隔线默认使用组件背景色并横向铺满整个 Vben Vxe Table，与页面默认背景融合。如果将 Vben Vxe Table 放在不同背景色容器中（例如 Card 内），默认分隔线可能显得突兀。下面示例展示如何自定义分隔线。

```typescript
const [Grid] = useVbenVxeGrid({
  formOptions: {},
  gridOptions: {},
  // 完全移除分隔线
  separator: false,
  // 也可以使用以下代码移除分隔线
  // separator: { show: false },
  // 或使用以下代码修改分隔线颜色
  // separator: { backgroundColor: 'rgba(100,100,0,0.5)' },
});
```

## API

useVbenVxeGrid 返回一个数组，第一个元素是表格组件，第二个元素是表格方法。

```vue
<script setup lang="ts">
import { useVbenVxeGrid } from '@/adapter/vxe-table';

// Grid 是表格组件
// gridApi 是表格方法
const [Grid, gridApi] = useVbenVxeGrid({
  gridOptions: {
    toolbarConfig: {
      refresh: true,
      custom: true,
    },
  },
  formOptions: {},
  gridEvents: {},
  // Properties
  // Events
});
</script>

<template>
  <Grid />
</template>
```

## GridApi 方法

useVbenVxeGrid 返回值中的第二个参数是包含若干表格方法的对象。

### setLoading
- **Description**: 设置 loading 状态
- **Type**: `(loading: boolean) => void`

### setGridOptions
- **Description**: 设置 vxe-table grid 组件参数
- **Type**: `(options: Partial<VxeGridProps['gridOptions']>) => void`

### reload
- **Description**: 重新加载表格，会重置为初始状态
- **Type**: `(params?: any) => void`

### query
- **Description**: 重新查询表格，保留当前分页
- **Type**: `(params?: any) => void`

### grid
- **Description**: vxe-table grid 实例
- **Type**: `VxeGridInstance`

### formApi
- **Description**: vbenForm api 实例
- **Type**: `FormApi`

### toggleSearchForm
- **Description**: 设置搜索表单显示状态
- **Type**: `(show?: boolean) => boolean`
- **Note**: 省略参数时，表单会在显示/隐藏间切换

## Props 配置

所有属性都可传入 useVbenVxeGrid 的第一个参数。

### tableTitle
- **Type**: `string`
- **Description**: Table title

### tableTitleHelp
- **Type**: `string`
- **Description**: Table title help information

### gridClass
- **Type**: `string`
- **Description**: Grid component class

### gridOptions
- **Type**: `VxeTableGridProps`
- **Description**: Grid component parameters

### gridEvents
- **Type**: `VxeGridListeners`
- **Description**: Grid component triggered events

### formOptions
- **Type**: `VbenFormProps`
- **Description**: Form parameters

### showSearchForm
- **Type**: `boolean`
- **Default**: `false`
- **Description**: Whether to display search form

### separator
- **Type**: `boolean | SeparatorOptions`
- **Default**: `true`
- **Version**: >5.5.4
- **Description**: Separator between search form and table body

### showToolbar
- **Type**: `boolean`
- **Default**: `true`
- **Description**: Whether to display toolbar

## 插槽

大多数插槽说明可在 vxe-table 官方文档中找到，但工具栏部分做了自定义，可通过以下插槽定制工具栏：

### toolbar-actions
- **Description**: Left side of toolbar (near table title)

### toolbar-tools
- **Description**: Right side of toolbar (left of vxeTable native tool buttons)

### table-title
- **Description**: Table title slot

### 搜索表单插槽

对于使用搜索表单的表格，所有以 form- 开头的插槽都会透传给表单。

## 单元格编辑

将 editConfig.mode 指定为 cell 可启用单元格编辑。

```typescript
  editConfig: {
    mode: 'cell',
    trigger: 'click',
  },
```

## 行编辑

将 editConfig.mode 指定为 row 可启用行编辑。

```typescript
  editConfig: {
    mode: 'row',
    trigger: 'click',
  },
```

## 树形表格

树形表格数据源为平铺结构。可通过 treeConfig 配置实现树形表格。

```typescript
treeConfig: {
  transform: true, // 指定为树形表格
  parentField: 'parentId', // 父节点字段名
  rowField: 'id', // 行数据字段名
},
```

## 固定表头/列

列固定可选值：`'left' | 'right' | '' | null`

## 自定义单元格

实现自定义单元格有两种方式：

1. 通过插槽
2. 通过 customCell 自定义单元格（需先注册 renderer）

```typescript
// 表格配置可使用 cellRender: { name: 'CellImage' }
vxeUI.renderer.add('CellImage', {
  renderDefault(_renderOpts, params) {
    const { column, row } = params;
    return h(Image, { src: row[column.field] } as any); // 注意：Image 组件来自 Antd，需显式导入，否则会使用 js 的 Image 类
  },
});

// 表格配置可使用 cellRender: { name: 'CellLink' }
vxeUI.renderer.add('CellLink', {
  renderDefault(renderOpts) {
    const { props } = renderOpts;
    return h(
      Button,
      { size: 'small', type: 'link' },
      { default: () => props?.text },
    );
  },
});
```

## 虚拟滚动

通过 scroll-y.enabled 与 scroll-y.gt 组合启用，其中 enabled 是总开关，gt 表示当总行数大于指定值时自动开启。

详细文档：https://vxetable.cn/v4/#/component/grid/scroll/vertical
