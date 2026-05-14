# Vben Form 组件参考文档
## 组件概述
Vben Form 是框架提供的表单组件，兼容 Ant Design Vue、Element Plus、Naive UI 等 UI 框架，底层表单校验使用 vee-validate。

## 基础用法
使用 `useVbenForm` 创建表单实例，并通过 schema 配置表单字段。

## Schema 配置
### fieldName
- **Type**: `string`
- **Required**: 是
- **Description**: 字段名，对应表单数据 key

### label
- **Type**: `string`
- **Default**: 无
- **Description**: 字段标签文本

### component
- **Type**: `string`
- **Required**: 是
- **Description**: 使用的组件类型
- **Optional**: `Input`, `Select`, `DatePicker`, `Checkbox`, `Radio`, `Switch`, `Textarea`, `InputNumber`, etc.

### componentProps
- **Type**: `object`
- **Default**: `{}`
- **Description**: 传递给组件的 props

### defaultValue
- **Type**: `any`
- **Default**: 无
- **Description**: 字段默认值

### rules
- **Type**: `string | object`
- **Default Value**: 无
- **Description**: 校验规则，支持 vee-validate 规则与 zod schema

#### 使用 zod 进行复杂校验
```typescript
import { z } from '@/adapter/form';
// Basic type
{
  rules: z.string().min(1, { message: 'Please enter a string' });
}
// Optional (can be undefined), and carries a default value
{
  rules: z.string().default('default value').optional();
}
// Can be an empty string, undefined, or an email address
{
  rules: z.union([z.string().email().optional(), z.literal('')]);
}
{
  rules: z.string().email().or(z.literal('')).optional();
}
// Complex validation
{
  rules: z.string()
    .min(1, { message: 'Please enter' })
    .refine((value) => value === '123', {
      message: 'Value must be 123',
    });
}
```

### dependencies
- **Type**: `object`
- **Default**: None
- **Description**: 字段依赖配置，用于表单联动

#### dependencies configuration items
```typescript
dependencies: {
  // Trigger fields; cascading will only trigger when these field values ​​change
  triggerFields: ['name'],
  // Dynamically determine whether the current field needs to be displayed; if not, destroy it directly
  if(values, formApi) {},
  // Dynamically determine whether the current field needs to be displayed; if not, hide it using CSS
  show(values, formApi) {},
  // Dynamically determine whether the current field needs to be disabled
  disabled(values, formApi) {},
  // This function is triggered whenever a field changes:
  trigger(values, formApi) {},
  // Dynamic rules
  rules(values, formApi) {},
  // Dynamic required fields
  required(values, formApi) {},
  // Dynamic component parameters
  componentProps(values, formApi) {},
}
```

## FormApi 方法
useVbenForm 返回值的第二个参数包含以下方法：
### submitForm
- **Description**: 提交表单
- **Type**: `(e:Event)=>Promise<Record<string,any>>`

### validateAndSubmitForm
- **Description**: 校验并提交表单
- **Type**: `(e:Event)=>Promise<Record<string,any>>`

### resetForm
- **Description**: 重置表单
- **Type**: `()=>Promise<void>`

### `setValues`
- **Description**: 设置表单值。默认会过滤未在 schema 中定义的字段。
- **Type**: `(fields: Record<string, any>, filterFields?: boolean, shouldValidate?: boolean) => Promise<void>`

### getValues
- **Description**: 获取表单值。
- **Type**: `(fields:Record<string, any>,shouldValidate: boolean = false)=>Promise<void>`

### validate
- **Description**: 表单校验。
- **Type**: `()=>Promise<void>`

### validateField
- **Description**: 校验指定字段。
- **Type**: `(fieldName: string)=>Promise<ValidationResult<unknown>>`

### isFieldValid
- **Description**: 检查字段是否已通过校验。
- **Type**: `(fieldName: string)=>Promise<ValidationResult<unknown>>` `string)=>Promise<boolean>`

### resetValidate
- **Description**: 重置表单校验
- **Type**: `()=>Promise<void>`

### updateSchema
- **Description**: 更新 formSchema
- **Type**: `(schema:FormSchema[])=>void`

### setFieldValue
- **Description**: 设置字段值
- **Type**: `(field: string, value: any, shouldValidate?: boolean)=>Promise<void>`

### setState
- **Description**: 设置组件状态（props）
- **Type**: `(stateOrFn:| ((prev: VbenFormProps) => Partial<VbenFormProps>)| Partial<VbenFormProps>)=>Promise<void>`

### getState
- **Description**: 获取组件状态（props）
- **Type**: `()=>Promise<VbenFormProps>`

### getFieldComponentRef
- **Description**: 获取指定字段组件实例
- **Type**: `<T=unknown>(fieldName: string)=>T`

### getFocusedField
- **Description**: 获取当前聚焦字段
- **Type**: `()=>string|undefined`

## Props 配置
所有属性都可传入 useVbenForm 的第一个参数。

### layout
- **Description**: 表单项布局
- **Type**: `'horizontal' | 'vertical' | 'inline'`
- **Default**: `horizontal`

### showCollapseButton
- **Description**: 是否显示折叠按钮
- **Type**: `boolean`
- **Default**: `false`

### wrapperClass
- **Description**: 表单布局，基于 tailwindcss
- **Type**: `any`

### actionWrapperClass
- **Description**: 表单操作区类名
- **Type**: `any`

### actionLayout
- **Description**: 表单操作按钮位置
- **Type**: `'newLine' | 'rowEnd' | 'inline'`
- **Default**: `rowEnd`

### actionPosition
- **Description**: 表单操作按钮对齐方式
- **Type**: `'left' | 'center' | 'right'`
- **Default Value**: `right`

### handleReset
- **Description**: 表单重置回调
- **Type**: `(values: Record<string, any>) => Promise<void> | void`

### handleSubmit
- **Description**: 表单提交回调
- **Type**: `(values: Record<string, any>) => Promise<void> | void`

### handleValuesChange
- **Description**: 表单值变化回调
- **Type**: `(values: Record<string, any>, fieldsChanged: string[]) => void`
- **Note**:
- The first parameter, `values`, contains the current value object after the form changes.
- The second parameter, `fieldsChanged`, is an array containing all changed field names (available in v5.5.4+).
- `fieldsChanged` only contains field names defined in the schema, not mapped field names.

### handleCollapsedChange
- **Description**: 表单折叠/展开状态变化回调
- **Type**: `(collapsed: boolean) => void`

### actionButtonsReverse
- **Description**: 反转操作按钮顺序
- **Type**: `boolean`
- **Default**: `false`

### showDefaultActions
- **Description**: 是否显示默认操作按钮
- **Type**: `boolean`
- **Default**: `true`

### collapsed
- **Description**: 是否折叠，仅在 showCollapseButton 为 true 时生效
- **Type**: `boolean`
- **Default**: `false`

### collapseTriggerResize
- **Description**: 折叠时触发 resize 事件
- **Type**: `boolean`
- **Default**: `false`

### collapsedRows
- **Description**: 折叠时保留的行数
- **Type**: `number`
- **Default**: `1`

### fieldMappingTime
- **Description**: 将表单中的数组值映射到两个字段。
- **Type**: `[string, [string, string], Nullable<string>|[string,string]|((any,string)=>any)?][]`
- **Example**: `[['timeRange', ['startTime', 'endTime'], 'YYYY-MM-DD']]`
- **Note**:
- First parameter: The field name to be mapped
- Second parameter: The array of mapped field names
- Third parameter (optional): Format mask or formatting function
- Setting to null will result in unformatted mapping of the original value (applicable to non-date and time fields)

### commonConfig
- **Description**: 表单项通用配置；每项配置会传递给每个表单项。
- **Type**: `FormCommonConfig`

### schema
- **Description**: 每个表单项的配置。
- **Type**: `FormSchema[]`

### submitOnEnter
- **Description**: 按下 Enter 键时提交表单
- **Type**: `boolean`
- **Default**: `false`

### submitOnChange
- **Description**: 字段值变化时提交表单（内部防抖）
- **Type**: `boolean`
- **Default**: `false`

### compact
- **Description**: 是否启用紧凑模式（忽略校验信息预留空间）
- **Type**: `boolean`
- **Default**: `false`

### scrollToFirstError
- **Description**: 表单校验失败时是否自动滚动到第一个错误字段
- **Type**: `boolean`
- **Default**: `false`

## 使用模板
**具体模板用法和代码示例请参考**：`assets/form-template.md`

## 插槽
### 内置插槽
| Slot Name | Description |
|--------|------|
| reset-before | 重置按钮前 |
| submit-before | 提交按钮前 |
| expand-before | 展开按钮前 |
| expand-after | 展开按钮后 |

### 字段插槽
除上述内置插槽外，schema 中每个字段的 fieldName 也可作为插槽名。

**重要说明**：
- 字段插槽优先级高于 component 属性中定义的组件。
- 当提供与 fieldName 同名插槽时，会使用该插槽内容作为该字段组件。
- 此时 component 的值会被忽略。

## TypeScript 类型定义
### ActionButtonOptions
```typescript
interface ActionButtonOptions {
  class?: ClassType; // Style
  disabled?: boolean; // Whether disabled
  loading?: boolean; // Whether loading
  size?: ButtonVariantSize; // Button size
  variant?: ButtonVariants; // Button type
  show?: boolean; // Whether to show
  content?: string; // Button text
  [key: string]: any; // Any property
}
```

### FormCommonConfig
```typescript
interface FormCommonConfig {
  componentProps?: ComponentProps; // Props for all form items
  controlClass?: string; // Control styles for all form items
  colon?: boolean; // Display a colon after the label
  disabled?: boolean; // Disabled status for all form items
  formFieldProps?: Partial<typeof Field>; // Styles for all form items
  formItemClass?: (() => string) | string; // Grid layout for all form items
  hideLabel?: boolean; // Hide all form item labels
  hideRequiredMark?: boolean; // Whether to hide required markers
  labelClass?: string; // Label style for all form items
  labelWidth?: number; // Label width for all form items
  modelPropName?: string; // Model property name (default "modelValue")
  wrapperClass?: string; // Wrapper style for all form items
}
```

### FormSchema
```typescript
interface FormSchema<T = BaseFormComponentType> extends FormCommonConfig {
  component: Component | T; // Component
  componentProps?: ComponentProps; // Component parameters
  defaultValue?: any; // Default value
  dependencies?: FormItemDependencies; // Dependencies
  description?: string; // Description
  fieldName: string; // Field name (required)
  help?: CustomRenderType; // Help information
  hide?: boolean; // Whether to hide form items
  label?: CustomRenderType; // Form label
  renderComponentContent?: RenderComponentContentType; // Custom component internal rendering
  rules?: FormSchemaRuleType; // Field rules
  suffix?: CustomRenderType; // Suffix
}
