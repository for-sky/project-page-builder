# Drawer 组件使用模板

## 模板用途
用于生成 CRUD 页面时的 Drawer 配置模板

## 必需导入

```typescript
import { useVbenDrawer } from '@/adapter/form';
```

## 1. 基础 Drawer 模板

### 基础结构

```typescript
const [Drawer, drawerApi] = useVbenDrawer({
  title: 'Title',
  onConfirm: async () => {
    // Confirm action
    console.log('Confirmed');
  },
});
```

### 带内容的 Drawer

```vue
<template>
  <Drawer>
    <div class="p-4">
      <p>This is drawer content</p>
    </div>
  </Drawer>
</template>

<script setup lang="ts">
import { useVbenDrawer } from '@/adapter/form';

const [Drawer, drawerApi] = useVbenDrawer({
  title: 'Notice',
  onConfirm: async () => {
    console.log('Confirm action');
  },
});
</script>
```

## 2. 组件拆分模板

### 外部组件

```vue
<template>
  <Drawer />
</template>

<script setup lang="ts">
import { useVbenDrawer } from '@/adapter/form';
import DrawerContent from './drawer-content.vue';

const [Drawer, drawerApi] = useVbenDrawer({
  title: 'Edit',
  connectedComponent: DrawerContent,
  onConfirm: async () => {
    const data = drawerApi.getData();
    console.log('Submit data:', data);
  },
});

// Open drawer
const handleOpen = () => {
  drawerApi.open();
};
</script>
```

### 内部组件（drawer-content.vue）

```vue
<template>
  <div class="p-4">
    <a-input v-model:value="formData.name" placeholder="Please enter name" />
  </div>
</template>

<script setup lang="ts">
import { useVbenDrawer } from '@/adapter/form';
import { reactive } from 'vue';

const [Drawer, drawerApi] = useVbenDrawer({});

const formData = reactive({
  name: '',
});

// Set shared data
drawerApi.setData(formData);
</script>
```

## 3. 常用配置模板

### 左侧抽屉

```typescript
const [Drawer, drawerApi] = useVbenDrawer({
  title: 'Left Drawer',
  placement: 'left',
});
```

### 顶部抽屉

```typescript
const [Drawer, drawerApi] = useVbenDrawer({
  title: 'Top Drawer',
  placement: 'top',
});
```

### 底部抽屉

```typescript
const [Drawer, drawerApi] = useVbenDrawer({
  title: 'Bottom Drawer',
  placement: 'bottom',
});
```

### 自定义宽度

```typescript
const [Drawer, drawerApi] = useVbenDrawer({
  title: 'Custom Width',
  class: 'w-[800px]',
});
```

### 隐藏底部按钮

```typescript
const [Drawer, drawerApi] = useVbenDrawer({
  title: 'No Footer',
  footer: false,
});
```

### 自定义按钮文案

```typescript
const [Drawer, drawerApi] = useVbenDrawer({
  title: 'Custom Buttons',
  confirmText: 'Submit',
  cancelText: 'Back',
});
```

## 4. API 使用模板

### 打开/关闭 Drawer

```typescript
// Open
drawerApi.open();

// Close
drawerApi.close();
```

### 动态设置状态

```typescript
// Set title
drawerApi.setState({
  title: 'New Title',
});

// Set loading state
drawerApi.setState({
  loading: true,
});

// Disable confirm button
drawerApi.setState({
  confirmDisabled: true,
});
```

### 数据共享

```typescript
// Set data
drawerApi.setData({
  id: 1,
  name: 'John',
});

// Get data
const data = drawerApi.getData();
console.log(data);
```

### 锁定/解锁

```typescript
// Lock (submitting)
drawerApi.lock(true);

// Unlock
drawerApi.unlock();
```

## 5. 事件处理模板

### 完整事件示例

```typescript
const [Drawer, drawerApi] = useVbenDrawer({
  title: 'Event Example',

  // Open/close state change
  onOpenChange: (isOpen) => {
    console.log('Drawer state:', isOpen);
  },

  // Open animation complete
  onOpened: () => {
    console.log('Opened');
  },

  // Before close confirmation
  onBeforeClose: () => {
    const confirm = window.confirm('Are you sure to close?');
    return confirm; // Return false to prevent closing
  },

  // Confirm button
  onConfirm: async () => {
    try {
      drawerApi.lock(true);
      await submitData();
      drawerApi.close();
    } finally {
      drawerApi.unlock();
    }
  },

  // Cancel button
  onCancel: () => {
    console.log('Cancelled');
  },

  // Close animation complete
  onClosed: () => {
    console.log('Closed');
  },
});
```

## 6. 插槽使用模板

### 自定义底部按钮

```vue
<template>
  <Drawer>
    <div class="p-4">
      <p>Content area</p>
    </div>

    <template #prepend-footer>
      <a-button>Extra Button</a-button>
    </template>

    <template #append-footer>
      <a-button type="link">Help</a-button>
    </template>
  </Drawer>
</template>
```

### 完全自定义底部

```vue
<template>
  <Drawer>
    <div class="p-4">
      <p>Content area</p>
    </div>

    <template #footer>
      <div class="flex justify-between">
        <a-button @click="handleReset">Reset</a-button>
        <div>
          <a-button @click="drawerApi.close()">Cancel</a-button>
          <a-button type="primary" @click="handleSubmit">Submit</a-button>
        </div>
      </div>
    </template>
  </Drawer>
</template>
```

### 自定义关闭图标

```vue
<template>
  <Drawer>
    <div class="p-4">
      <p>Content area</p>
    </div>

    <template #close-icon>
      <CloseCircleOutlined />
    </template>
  </Drawer>
</template>
```

### 标题右侧扩展内容

```vue
<template>
  <Drawer>
    <div class="p-4">
      <p>Content area</p>
    </div>

    <template #extra>
      <a-button type="link">More Actions</a-button>
    </template>
  </Drawer>
</template>
```

## 7. 完整示例

### 编辑用户 Drawer

```vue
<template>
  <div>
    <a-button type="primary" @click="handleEdit">Edit User</a-button>
    <Drawer />
  </div>
</template>

<script setup lang="ts">
import { useVbenDrawer } from '@/adapter/form';
import { reactive } from 'vue';
import UserForm from './user-form.vue';

const [Drawer, drawerApi] = useVbenDrawer({
  title: 'Edit User',
  class: 'w-[600px]',
  connectedComponent: UserForm,

  onOpenChange: (isOpen) => {
    if (isOpen) {
      // Load data when opening
      loadUserData();
    }
  },

  onConfirm: async () => {
    try {
      drawerApi.lock(true);
      const formData = drawerApi.getData();
      await updateUser(formData);
      message.success('Saved successfully');
      drawerApi.close();
    } catch (error) {
      message.error('Save failed');
    } finally {
      drawerApi.unlock();
    }
  },
});

const handleEdit = () => {
  drawerApi.open();
};

const loadUserData = async () => {
  drawerApi.setState({ loading: true });
  try {
    const data = await fetchUser(1);
    drawerApi.setData(data);
  } finally {
    drawerApi.setState({ loading: false });
  }
};
</script>
```
