# Form 组件使用模板

## 模板用途
用于生成 CRUD 页面时的 Form 配置模板

## 必需导入

```typescript
import { useVbenForm, z } from '@/adapter/form';
```

## 1. 基础 Form 模板

### 基础结构

```typescript
const [Form, formApi] = useVbenForm({
  // Form configuration
  commonConfig: {
    componentProps: {
      class: 'w-full',
    },
  },
  // Form layout
  layout: 'horizontal',
  // Form schema
  schema: [
    {
      fieldName: 'name',
      label: 'Name',
      component: 'Input',
      rules: 'required',
    },
  ],
});
```

### 常用字段类型

#### 文本输入
```typescript
{
  fieldName: 'username',
  label: 'Username',
  component: 'Input',
  rules: z.string().min(3, { message: 'At least 3 characters' }),
  componentProps: {
    placeholder: 'Please enter username',
  },
}
```

#### 数字输入
```typescript
{
  fieldName: 'age',
  label: 'Age',
  component: 'InputNumber',
  componentProps: {
    min: 0,
    max: 150,
  },
}
```

#### 下拉选择
```typescript
{
  fieldName: 'status',
  label: 'Status',
  component: 'Select',
  rules: 'selectRequired',
  componentProps: {
    options: [
      { label: 'Enabled', value: 1 },
      { label: 'Disabled', value: 0 },
    ],
  },
}
```

#### 日期选择器
```typescript
{
  fieldName: 'birthday',
  label: 'Birthday',
  component: 'DatePicker',
  componentProps: {
    format: 'YYYY-MM-DD',
  },
}
```

#### 日期范围选择器
```typescript
{
  fieldName: 'dateRange',
  label: 'Date Range',
  component: 'RangePicker',
  componentProps: {
    format: 'YYYY-MM-DD',
  },
}
```

#### 开关
```typescript
{
  fieldName: 'enabled',
  label: 'Enabled',
  component: 'Switch',
  defaultValue: true,
}
```

#### 多行文本
```typescript
{
  fieldName: 'description',
  label: 'Description',
  component: 'Textarea',
  componentProps: {
    rows: 4,
    placeholder: 'Please enter description',
  },
}
```

## 2. 联动表单模板

### 基础联动示例

```typescript
const [Form, formApi] = useVbenForm({
  schema: [
    {
      fieldName: 'type',
      label: 'Type',
      component: 'Select',
      componentProps: {
        options: [
          { label: 'Personal', value: 'personal' },
          { label: 'Company', value: 'company' },
        ],
      },
    },
    {
      fieldName: 'idCard',
      label: 'ID Card',
      component: 'Input',
      // Show based on type field
      dependencies: {
        triggerFields: ['type'],
        show(values) {
          return values.type === 'personal';
        },
      },
    },
    {
      fieldName: 'companyName',
      label: 'Company Name',
      component: 'Input',
      // Show based on type field
      dependencies: {
        triggerFields: ['type'],
        show(values) {
          return values.type === 'company';
        },
      },
    },
  ],
});
```

### 动态禁用示例

```typescript
{
  fieldName: 'email',
  label: 'Email',
  component: 'Input',
  dependencies: {
    triggerFields: ['useEmail'],
    disabled(values) {
      return !values.useEmail;
    },
  },
}
```

### 动态必填示例

```typescript
{
  fieldName: 'phone',
  label: 'Phone',
  component: 'Input',
  dependencies: {
    triggerFields: ['contactType'],
    required(values) {
      return values.contactType === 'phone';
    },
  },
}
```

### 动态组件参数示例

```typescript
{
  fieldName: 'city',
  label: 'City',
  component: 'Select',
  dependencies: {
    triggerFields: ['province'],
    componentProps(values, formApi) {
      // Load city list based on province
      return {
        options: getCitiesByProvince(values.province),
      };
    },
  },
}
```

## 3. 自定义组件表单模板

### 使用字段插槽

```vue
<template>
  <Form>
    <!-- Custom field rendering -->
    <template #customField="{ value, onChange }">
      <div class="custom-component">
        <a-input :value="value" @change="onChange" />
        <span class="hint">Custom hint message</span>
      </div>
    </template>
  </Form>
</template>

<script setup lang="ts">
const [Form, formApi] = useVbenForm({
  schema: [
    {
      fieldName: 'customField',
      label: 'Custom Field',
      component: 'Input', // Will be overridden by slot
    },
  ],
});
</script>
```

### 自定义渲染内容

```typescript
{
  fieldName: 'avatar',
  label: 'Avatar',
  component: 'Input',
  renderComponentContent: ({ value, onChange }) => {
    return h('div', { class: 'avatar-uploader' }, [
      h('img', { src: value || '/default-avatar.png' }),
      h('button', { onClick: () => handleUpload(onChange) }, 'Upload'),
    ]);
  },
}
```

## 4. Form 方法使用

### 获取表单值
```typescript
const values = formApi.getValues();
console.log(values);
```

### 设置表单值
```typescript
formApi.setValues({
  name: 'John',
  age: 25
});
```

### 校验表单
```typescript
const isValid = await formApi.validate();
if (isValid) {
  // Submit form
}
```

### 重置表单
```typescript
formApi.resetForm();
```

### 更新 Schema
```typescript
formApi.updateSchema([
  {
    fieldName: 'newField',
    label: 'New Field',
    component: 'Input',
  },
]);
```

## 5. 完整示例

```typescript
const [Form, formApi] = useVbenForm({
  layout: 'horizontal',
  commonConfig: {
    componentProps: {
      class: 'w-full',
    },
  },
  schema: [
    {
      fieldName: 'username',
      label: 'Username',
      component: 'Input',
      rules: z.string().min(3).max(20),
    },
    {
      fieldName: 'type',
      label: 'User Type',
      component: 'Select',
      componentProps: {
        options: [
          { label: 'Normal User', value: 'normal' },
          { label: 'VIP User', value: 'vip' },
        ],
      },
    },
    {
      fieldName: 'vipLevel',
      label: 'VIP Level',
      component: 'Select',
      dependencies: {
        triggerFields: ['type'],
        show(values) {
          return values.type === 'vip';
        },
        componentProps: {
          options: [
            { label: 'VIP1', value: 1 },
            { label: 'VIP2', value: 2 },
            { label: 'VIP3', value: 3 },
          ],
        },
      },
    },
    {
      fieldName: 'email',
      label: 'Email',
      component: 'Input',
      rules: z.string().email(),
    },
    {
      fieldName: 'enabled',
      label: 'Enabled',
      component: 'Switch',
      defaultValue: true,
    },
  ],
  handleSubmit: async (values) => {
    console.log('Submit data:', values);
    // Call API to submit
  },
});
```
