# Vben Alert（提示弹窗）

框架提供了一些轻量级提示弹窗，只需 JS 代码即可动态快速创建，无需在 template 中编写结构代码。

**具体用法示例和代码模板请参考**：`assets/alert-template.md`

## 重要说明

如果现有组件封装无法满足需求，可以使用原生组件或自行封装组件。框架提供的组件并非强制，按需使用即可。

## 适用场景

Alert 与 Modal 功能类似，但只适用于简单场景。例如临时、动态地弹出确认框、输入框等。若弹窗需求更复杂，请使用 VbenModal。

## 注意

当 Alert 动态创建的弹窗已处于打开状态时，其快捷方法 alert、confirm、prompt 不支持 HMR（热更新）。代码变更后需要先关闭弹窗再重新打开。

## useAlertContext

当弹窗的内容、底部或图标使用了自定义组件时，可以在这些组件中使用 useAlertContext 获取当前弹窗上下文对象，从而主动控制弹窗。

**注意**：useAlertContext 只能在 setup 或函数式组件中使用。

### 方法

#### doConfirm
- **Type**: `() => void`
- **Version**: >5.5.4
- **Description**: 调用弹窗确认操作

#### doCancel
- **Type**: `() => void`
- **Version**: >5.5.4
- **Description**: 调用弹窗取消操作

## 类型定义

### IconType

```typescript
/** 预设图标类型 */
export type IconType = 'error' | 'info' | 'question' | 'success' | 'warning';
```

### BeforeCloseScope

```typescript
export type BeforeCloseScope = {
  /** 是否由点击确认按钮触发关闭 */
  isConfirm: boolean;
};
```

### AlertProps

```typescript
export type AlertProps = {
  /** 关闭前回调，若返回 false 将阻止关闭 */
  beforeClose?: (
    scope: BeforeCloseScope,
  ) => boolean | Promise<boolean | undefined> | undefined;
  /** 边框 */
  bordered?: boolean;
  /** 按钮对齐方式 */
  buttonAlign?: 'center' | 'end' | 'start';
  /** 取消按钮文本 */
  cancelText?: string;
  /** 是否居中显示 */
  centered?: boolean;
  /** 确认按钮文本 */
  confirmText?: string;
  /** 弹窗容器额外样式类 */
  containerClass?: string;
  /** 弹窗提示内容 */
  content: Component | string;
  /** 弹窗内容额外样式类 */
  contentClass?: string;
  /** 执行 beforeClose 回调期间，在内容区显示加载遮罩 */
  contentMasking?: boolean;
  /** 弹窗底部内容（与按钮在同一容器） */
  footer?: Component | string;
  /** 弹窗图标（位于标题前） */
  icon?: Component | IconType;
  /** 弹窗遮罩模糊效果 */
  overlayBlur?: number;
  /** 是否显示取消按钮 */
  showCancel?: boolean;
  /** 弹窗标题 */
  title?: string;
};
```

### PromptProps

```typescript
export type PromptProps<T = any> = {
  /** 关闭前回调，若返回 false 将阻止关闭 */
  beforeClose?: (scope: {
    isConfirm: boolean;
    value: T | undefined;
  }) => boolean | Promise<boolean | undefined> | undefined;
  /** 用于接收用户输入的组件 */
  component?: Component;
  /** 输入组件属性 */
  componentProps?: Recordable<any>;
  /** 输入组件插槽 */
  componentSlots?: Recordable<Component>;
  /** 默认值 */
  defaultValue?: T;
  /** 输入组件的值属性名 */
  modelPropName?: string;
} & Omit<AlertProps, 'beforeClose'>;
```

## 函数签名

### alert / confirm

```typescript
/**
 * alert 与 confirm 的函数签名一致。
 * confirm 默认显示取消按钮，而 alert 默认只有一个按钮
 */
export function alert(options: AlertProps): Promise<void>;
export function alert(
  message: string,
  options?: Partial<AlertProps>,
): Promise<void>;
export function alert(
  message: string,
  title?: string,
  options?: Partial<AlertProps>,
): Promise<void>;
```

### prompt

```typescript
/**
 * 弹出输入框的函数签名。
 * beforeClose 参数会传入当前输入值
 * component 指定用于接收用户输入的组件，默认为 Input
 * componentProps 用于设置输入组件属性
 * defaultValue 为默认值
 * modelPropName 为输入组件值属性名，默认为 modelValue
 */
export async function prompt<T = any>(
  options: Omit<AlertProps, 'beforeClose'> & {
    beforeClose?: (
      scope: BeforeCloseScope & {
        /** 输入组件当前值 */
        value: T;
      },
    ) => boolean | Promise<boolean | undefined> | undefined;
    component?: Component;
    componentProps?: Recordable<any>;
    defaultValue?: T;
    modelPropName?: string;
  },
): Promise<T | undefined>;
```
