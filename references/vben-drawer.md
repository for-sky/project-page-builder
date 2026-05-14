# Vben Drawer 组件参考文档

## 组件概述
Vben Drawer 是框架提供的抽屉组件，支持自动高度、加载态等特性。

## 重要说明

- 如果现有组件封装无法满足需求，可以使用原生组件或自行封装组件
- 框架提供的组件并非强制，请按需使用
- 文档示例中可能出现部分国际化和主题色问题，实际使用时通常不会出现

## 基础用法
使用 `useVbenDrawer` 创建基础抽屉。

## 组件拆分
业务场景下抽屉内容可能较复杂，建议将抽屉内容抽离为独立组件以复用。可使用 `connectedComponent` 参数连接内外组件，无需额外处理。

## 自动高度计算
抽屉会自动计算内容高度。当内容超出一定高度时会出现滚动条。该能力可与加载效果和 `prepend-footer` 插槽配合使用。

## 使用 API
可通过 `drawerApi` 调用抽屉方法，并通过 `setState` 更新抽屉状态。

## 数据共享
使用 `connectedComponent` 参数时，内外组件可共享数据。结合 `drawerApi` 的数据读写与 `onOpenChange`，可满足大部分场景需求。

## 优先级规则

**参数优先级**：`slot > props > state`（state 由 API 和 useVbenDrawer 参数更新）

- 若已通过 slot 或 props 传入，`setState` 将不生效
- 此时请通过 slot 或 props 更新状态

**连接组件优先级**：
- 使用 `connectedComponent` 时，会存在 2 个 `useVbenDrawer` 实例
- 若两者设置了相同参数，内部实例（不带 `connectedComponent`）优先
- 例如都设置了 `onConfirm` 时，以内部 `onConfirm` 为准
- 例外：`onOpenChange` 事件会在内外组件都触发

**销毁配置**：
- 使用 `connectedComponent` 时，可通过 `destroyOnClose` 控制关闭抽屉时是否销毁 connectedComponent
- 销毁后组件会重建，内部变量、状态和数据都会恢复到初始状态

**默认属性**：
- 若默认行为不符合预期，可在 `src\bootstrap.ts` 中修改 `setDefaultDrawerProps` 参数
- 例如：默认隐藏全屏按钮、修改默认 ZIndex 等

## API

```typescript
// Drawer 为抽屉组件
// drawerApi 提供抽屉方法
const [Drawer, drawerApi] = useVbenDrawer({
  // Properties
  // Events
});
```

## Props 配置

所有属性都可以传入 useVbenDrawer 的第一个参数。

### appendToMain
- **Type**: `boolean`
- **Default**: `false`
- **Description**: 是否挂载到内容区（默认挂载到 body）
- **Note**: 挂载到内容区时，页面根元素使用普通 div 即可

### connectedComponent
- **Type**: `Component`
- **Default**: -
- **Description**: 连接另一个 Drawer 组件

### destroyOnClose
- **Type**: `boolean`
- **Default**: `false`
- **Description**: 关闭时销毁

### title
- **Type**: `string | slot`
- **Default**: -
- **Description**: 标题

### titleTooltip
- **Type**: `string | slot`
- **Default**: -
- **Description**: 标题提示信息

### description
- **Type**: `string | slot`
- **Default**: -
- **Description**: 描述信息

### isOpen
- **Type**: `boolean`
- **Default**: `false`
- **Description**: Drawer 打开状态

### loading
- **Type**: `boolean`
- **Default**: `false`
- **Description**: Drawer 加载状态

### closable
- **Type**: `boolean`
- **Default**: `true`
- **Description**: 显示关闭按钮

### closeIconPlacement
- **Type**: `'left' | 'right'`
- **Default**: `right`
- **Description**: 关闭按钮位置

### modal
- **Type**: `boolean`
- **Default**: `true`
- **Description**: 显示遮罩

### header
- **Type**: `boolean`
- **Default**: `true`
- **Description**: 显示头部

### footer
- **Type**: `boolean | slot`
- **Default**: `true`
- **Description**: 显示底部

### confirmLoading
- **Type**: `boolean`
- **Default**: `false`
- **Description**: 确认按钮加载状态

### closeOnClickModal
- **Type**: `boolean`
- **Default**: `true`
- **Description**: 点击遮罩关闭 Drawer

### closeOnPressEscape
- **Type**: `boolean`
- **Default**: `true`
- **Description**: 按 ESC 键关闭 Drawer

### confirmText
- **Type**: `string | slot`
- **Default**: Confirm
- **Description**: 确认按钮文本

### cancelText
- **Type**: `string | slot`
- **Default**: Cancel
- **Description**: 取消按钮文本

### placement
- **Type**: `'left' | 'right' | 'top' | 'bottom'`
- **Default**: `right`
- **Description**: Drawer 位置

### showCancelButton
- **Type**: `boolean`
- **Default**: `true`
- **Description**: 显示取消按钮

### showConfirmButton
- **Type**: `boolean`
- **Default**: `true`
- **Description**: 显示确认按钮

### class
- **Type**: `string`
- **Default**: -
- **Description**: Drawer 类名，可通过它配置宽度

### contentClass
- **Type**: `string`
- **Default**: -
- **Description**: Drawer 内容区类名

### footerClass
- **Type**: `string`
- **Default**: -
- **Description**: Drawer 底部区域类名

### headerClass
- **Type**: `string`
- **Default**: -
- **Description**: Drawer 头部区域类名

### zIndex
- **Type**: `number`
- **Default**: `1000`
- **Description**: Drawer ZIndex 层级

### overlayBlur
- **Type**: `number`
- **Default**: -
- **Description**: 遮罩模糊程度

## DrawerApi 方法

### setState
- **Description**: 动态设置 Drawer 状态属性
- **Type**: `(((prev: ModalState) => Partial<ModalState>) | Partial<ModalState>) => drawerApi`

### open
- **Description**: 打开 Drawer
- **Type**: `() => void`

### close
- **Description**: 关闭 Drawer
- **Type**: `() => void`

### setData
- **Description**: 设置共享数据
- **Type**: `<T>(data: T) => drawerApi`

### getData
- **Description**: 获取共享数据
- **Type**: `<T>() => T`

### useStore
- **Description**: 获取响应式状态
- **Type**: -

### lock
- **Description**: 将 Drawer 标记为提交中并锁定当前状态
- **Type**: `(isLock: boolean) => drawerApi`
- **Version**: >5.5.3
- **Details**: 用于锁定 Drawer 状态，通常用于数据提交期间，防止用户重复提交、误关闭抽屉或修改表单数据等。锁定后，确认按钮进入 loading，同时禁用取消和关闭按钮，阻止 ESC 或点击遮罩关闭，并启用加载动画覆盖内容区域。调用 close 关闭被锁定的 Drawer 时会自动解锁。

### unlock
- **Description**: lock 的反向操作，用于解锁 Drawer 状态，也是 lock(false) 的别名
- **Type**: `() => drawerApi`
- **Version**: >5.5.3

## 事件

以下事件仅在通过 `useVbenDrawer({onCancel:()=>{}})` 传入时生效。

### onBeforeClose
- **Description**: 关闭前触发，返回 false 将阻止关闭
- **Type**: `() => boolean`

### onCancel
- **Description**: 点击取消按钮时触发
- **Type**: `() => void`

### onClosed
- **Description**: 关闭动画完成时触发
- **Type**: `() => void`
- **Version**: >5.5.2

### onConfirm
- **Description**: 点击确认按钮时触发
- **Type**: `() => void`

### onOpenChange
- **Description**: Drawer 打开或关闭时触发
- **Type**: `(isOpen: boolean) => void`

### onOpened
- **Description**: 打开动画完成时触发
- **Type**: `() => void`
- **Version**: >5.5.2

## 插槽

除上述支持 slot 的属性外，还可以通过插槽自定义抽屉内容。

### default
- **Description**: 默认插槽 - Drawer 内容

### prepend-footer
- **Description**: 取消按钮左侧

### center-footer
- **Description**: 取消和确认按钮之间（未使用 footer 插槽时生效）

### append-footer
- **Description**: 确认按钮右侧

### close-icon
- **Description**: 关闭按钮图标

### extra
- **Description**: 额外内容（标题右侧）

## 使用模板

**具体模板用法和代码示例请参考**：`assets/drawer-template.md`
