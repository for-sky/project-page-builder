# Modal 组件使用模板

## 模板用途
用于生成 CRUD 页面时的 Modal 配置模板

## 必需导入

```typescript
import { useVbenModal } from '@/adapter/form';
```

## 1. 基础 Modal 模板

### 基础结构

```typescript
const [Modal, modalApi] = useVbenModal({
  title: 'Title',
  onConfirm: async () => {
    // Confirm action
    console.log('Confirmed');
  },
});
```

### 带内容的 Modal

```vue
<template>
  <Modal>
    <div class="p-4">
      <p>This is modal content</p>
    </div>
  </Modal>
</template>

<script setup lang="ts">
import { useVbenModal } from '@/adapter/form';

const [Modal, modalApi] = useVbenModal({
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
  <Modal />
</template>

<script setup lang="ts">
import { useVbenModal } from '@/adapter/form';
import ModalContent from './modal-content.vue';

const [Modal, modalApi] = useVbenModal({
  title: 'Edit',
  connectedComponent: ModalContent,
  onConfirm: async () => {
    const data = modalApi.getData();
    console.log('Submit data:', data);
  },
});

// Open modal
const handleOpen = () => {
  modalApi.open();
};
</script>
```

### 内部组件（modal-content.vue）

```vue
<template>
  <div class="p-4">
    <a-input v-model:value="formData.name" placeholder="Please enter name" />
  </div>
</template>

<script setup lang="ts">
import { useVbenModal } from '@/adapter/form';
import { reactive } from 'vue';

const [Modal, modalApi] = useVbenModal({});

const formData = reactive({
  name: '',
});

// Set shared data
modalApi.setData(formData);
</script>
```

## 3. 常用配置模板

### 可拖拽 Modal

```typescript
const [Modal, modalApi] = useVbenModal({
  title: 'Draggable',
  draggable: true,
});
```

### 全屏 Modal

```typescript
const [Modal, modalApi] = useVbenModal({
  title: 'Fullscreen',
  fullscreen: true,
});
```

### 居中显示

```typescript
const [Modal, modalApi] = useVbenModal({
  title: 'Centered',
  centered: true,
});
```

### 自定义宽度

```typescript
const [Modal, modalApi] = useVbenModal({
  title: 'Custom Width',
  class: 'w-[800px]',
});
```

### 隐藏底部按钮

```typescript
const [Modal, modalApi] = useVbenModal({
  title: 'No Footer',
  footer: false,
});
```

### 自定义按钮文案

```typescript
const [Modal, modalApi] = useVbenModal({
  title: 'Custom Buttons',
  confirmText: 'Submit',
  cancelText: 'Back',
});
```

## 4. API 使用模板

### 打开/关闭 Modal

```typescript
// Open
modalApi.open();

// Close
modalApi.close();
```

### 动态设置状态

```typescript
// Set title
modalApi.setState({
  title: 'New Title',
});

// Set loading state
modalApi.setState({
  loading: true,
});

// Disable confirm button
modalApi.setState({
  confirmDisabled: true,
});
```

### 数据共享

```typescript
// Set data
modalApi.setData({
  id: 1,
  name: 'John',
});

// Get data
const data = modalApi.getData();
console.log(data);
```

### 锁定/解锁

```typescript
// Lock (submitting)
modalApi.lock(true);

// Unlock
modalApi.unlock();
```

## 5. 事件处理模板

### 完整事件示例

```typescript
const [Modal, modalApi] = useVbenModal({
  title: 'Event Example',

  // Open/close state change
  onOpenChange: (isOpen) => {
    console.log('Modal state:', isOpen);
  },

  // Open animation complete
  onOpened: () => {
    console.log('Opened');
  },

  // Before close confirmation
  onBeforeClose: async () => {
    const confirm = await showConfirm('Are you sure to close?');
    return confirm; // Return false to prevent closing
  },

  // Confirm button
  onConfirm: async () => {
    try {
      modalApi.lock(true);
      await submitData();
      modalApi.close();
    } finally {
      modalApi.unlock();
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
  <Modal>
    <div class="p-4">
      <p>Content area</p>
    </div>

    <template #prepend-footer>
      <a-button>Extra Button</a-button>
    </template>

    <template #append-footer>
      <a-button type="link">Help</a-button>
    </template>
  </Modal>
</template>
```

### 完全自定义底部

```vue
<template>
  <Modal>
    <div class="p-4">
      <p>Content area</p>
    </div>

    <template #footer>
      <div class="flex justify-between">
        <a-button @click="handleReset">Reset</a-button>
        <div>
          <a-button @click="modalApi.close()">Cancel</a-button>
          <a-button type="primary" @click="handleSubmit">Submit</a-button>
        </div>
      </div>
    </template>
  </Modal>
</template>
```

## 7. 完整示例

### 编辑用户 Modal

```vue
<template>
  <div>
    <a-button type="primary" @click="handleEdit">Edit User</a-button>
    <Modal />
  </div>
</template>

<script setup lang="ts">
import { useVbenModal } from '@/adapter/form';
import { reactive } from 'vue';
import UserForm from './user-form.vue';

const [Modal, modalApi] = useVbenModal({
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
      modalApi.lock(true);
      const formData = modalApi.getData();
      await updateUser(formData);
      message.success('Saved successfully');
      modalApi.close();
    } catch (error) {
      message.error('Save failed');
    } finally {
      modalApi.unlock();
    }
  },
});

const handleEdit = () => {
  modalApi.open();
};

const loadUserData = async () => {
  modalApi.setState({ loading: true });
  try {
    const data = await fetchUser(1);
    modalApi.setData(data);
  } finally {
    modalApi.setState({ loading: false });
  }
};
</script>
```
