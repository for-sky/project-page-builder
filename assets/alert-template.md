# Alert 使用示例模板

## 模板用途
用于生成 Alert 弹窗组件的使用示例模板

## 1. 基础 Alert

```typescript
import { alert } from '@hj-fe/common-ui';

// Simple message
alert('This is an alert message');

// With title
await alert('This is the message content', 'Alert Title');

// With options
await alert('This is the message content', 'Alert Title', {
  centered: true,
  confirmText: 'OK',
});
```

## 2. 自定义内容 Alert

```typescript
import { h } from 'vue';
import { alert } from '@hj-fe/common-ui';

alert({
  buttonAlign: 'center',
  content: 'Operation Successful',
});
```

## 3. 不同图标的 Alert

```typescript
import { alert } from '@hj-fe/common-ui';

// Success icon
await alert('Operation completed successfully!', 'Success', {
  icon: 'success',
});

// Error icon
await alert('An error occurred!', 'Error', {
  icon: 'error',
});

// Warning icon
await alert('Please be careful!', 'Warning', {
  icon: 'warning',
});

// Info icon
await alert('Here is some information', 'Info', {
  icon: 'info',
});

// Question icon
await alert('Do you understand?', 'Question', {
  icon: 'question',
});
```

## 4. 基础 Confirm 对话框

```typescript
import { confirm, alert } from '@hj-fe/common-ui';

// Simple confirm
confirm('This is an alert message')
  .then(() => {
    alert('Confirmed');
  })
  .catch(() => {
    alert('Canceled');
  });

// With title and options
try {
  await confirm('Are you sure you want to delete this item?', 'Confirm Delete', {
    confirmText: 'Delete',
    cancelText: 'Cancel',
    icon: 'warning',
  });
  console.log('User confirmed');
} catch {
  console.log('User cancelled');
}
```

## 5. 自定义底部的 Confirm

```typescript
import { h, ref } from 'vue';
import { confirm } from '@hj-fe/common-ui';
import { Checkbox, MessagePlugin } from 'tdesign-vue-next';

const checked = ref(false);

confirm({
  cancelText: 'No',
  confirmText: 'Yes',
  content:
    'Have you ever experienced something that feels like you\'ve been through it before?\nYou can even subconsciously predict what will happen next.\n\nSounds mysterious, have you ever felt this way?',
  footer: () =>
    h(
      Checkbox,
      {
        checked: checked.value,
        class: 'flex-1',
        'onUpdate:checked': (v) => (checked.value = v),
      },
      'Do not show again',
    ),
  icon: 'question',
  title: 'Mystery',
}).then(() => {
  if (checked.value) {
    MessagePlugin.success('I won\'t bother you with this question again');
  } else {
    MessagePlugin.info('I will ask you again next time');
  }
});
```

## 6. 带 beforeClose 的异步 Confirm

```typescript
import { confirm, alert } from '@hj-fe/common-ui';

confirm({
  beforeClose({ isConfirm }) {
    if (isConfirm) {
      // You can perform some async operations here. If false is returned, the dialog will not close
      return new Promise((resolve) => setTimeout(resolve, 2000));
    }
  },
  content: 'This is an alert message with async confirm',
  icon: 'success',
  contentMasking: true, // Show loading mask during beforeClose
}).then(() => {
  alert('Confirmed');
});
```

## 7. 自定义按钮对齐方式

```typescript
import { confirm } from '@hj-fe/common-ui';

// Center alignment
await confirm('Are you sure?', 'Confirm', {
  buttonAlign: 'center',
});

// End alignment (right)
await confirm('Are you sure?', 'Confirm', {
  buttonAlign: 'end',
});

// Start alignment (left)
await confirm('Are you sure?', 'Confirm', {
  buttonAlign: 'start',
});
```

## 8. 基础 Prompt 输入框

```typescript
import { prompt } from '@hj-fe/common-ui';

// Simple prompt
const result = await prompt({
  title: 'Enter Your Name',
  content: 'Please enter your name:',
  defaultValue: 'John Doe',
});

if (result) {
  console.log('User entered:', result);
}
```

## 9. 使用自定义组件的 Prompt

```typescript
import { prompt } from '@hj-fe/common-ui';
import { Input } from 'tdesign-vue-next';

const result = await prompt({
  title: 'Enter Email',
  content: 'Please enter your email address:',
  component: Input,
  componentProps: {
    type: 'email',
    placeholder: 'example@email.com',
  },
  defaultValue: '',
});

console.log('Email:', result);
```

## 10. 带校验的 Prompt

```typescript
import { prompt, alert } from '@hj-fe/common-ui';

const result = await prompt({
  title: 'Enter Age',
  content: 'Please enter your age (must be 18 or older):',
  defaultValue: '',
  beforeClose: ({ isConfirm, value }) => {
    if (isConfirm) {
      const age = Number(value);
      if (isNaN(age) || age < 18) {
        alert('Age must be 18 or older');
        return false; // Prevent close
      }
    }
    return true;
  },
});

console.log('Age:', result);
```

## 11. 使用自定义插槽和 useAlertContext 的 Prompt

```typescript
import { h } from 'vue';
import { prompt, useAlertContext, alert } from '@hj-fe/common-ui';
import { Input } from 'tdesign-vue-next';

prompt({
  component: () => {
    // Get alert context. Note: can only be called in setup or functional components
    const { doConfirm } = useAlertContext();
    return h(
      Input,
      {
        onKeydown(e: KeyboardEvent) {
          if (e.key === 'Enter') {
            e.preventDefault();
            // Call the confirm method provided by the dialog
            doConfirm();
          }
        },
        placeholder: 'Please enter',
        prefixIcon: 'wallet',
        type: 'number',
      },
    );
  },
  content:
    'This dialog demonstrates how to use custom slots and get the dialog context using useAlertContext.\nPress Enter in the input box to trigger the confirm operation.',
  icon: 'question',
  modelPropName: 'value',
}).then((val) => {
  if (val) alert(`You entered ${val}`);
});
```

## 12. 使用 Select 组件的 Prompt

```typescript
import { prompt, alert } from '@hj-fe/common-ui';
import { Select } from 'tdesign-vue-next';

prompt({
  component: Select,
  componentProps: {
    options: [
      { label: 'Option A', value: 'Option A' },
      { label: 'Option B', value: 'Option B' },
      { label: 'Option C', value: 'Option C' },
    ],
    placeholder: 'Please select',
    // The dialog sets body pointer-events to none, which affects dropdown click events
    popupClassName: 'pointer-events-auto',
  },
  content: 'This dialog demonstrates how to pass custom components using component',
  icon: 'question',
  modelPropName: 'value',
}).then((val) => {
  if (val) {
    alert(`You selected ${val}`);
  }
});
```

## 13. 带异步校验的 Prompt

```typescript
import { prompt, alert } from '@hj-fe/common-ui';
import { RadioGroup } from 'tdesign-vue-next';

function sleep(ms: number) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

prompt({
  async beforeClose(scope) {
    if (scope.isConfirm) {
      if (scope.value) {
        // Simulate async operation, can return false if not successful
        await sleep(2000);
      } else {
        alert('Please select an option');
        return false;
      }
    }
  },
  component: RadioGroup,
  componentProps: {
    class: 'flex flex-col',
    options: [
      { label: 'Option 1', value: 'option1' },
      { label: 'Option 2', value: 'option2' },
      { label: 'Option 3', value: 'option3' },
    ],
  },
  content: 'Select an option and then click [Confirm]',
  icon: 'question',
  modelPropName: 'value',
}).then((val) => {
  alert(`${val} has been set.`);
});
```

## 14. 自定义遮罩模糊

```typescript
import { alert } from '@hj-fe/common-ui';

await alert('Dialog with blurred background', 'Blur Effect', {
  overlayBlur: 5,
});
```

## 15. 在自定义组件中使用 useAlertContext

```vue
<template>
  <div>
    <p>Custom content in alert</p>
    <t-button @click="handleConfirm">Confirm</t-button>
    <t-button @click="handleCancel">Cancel</t-button>
  </div>
</template>

<script setup lang="ts">
import { useAlertContext } from '@hj-fe/common-ui';

const { doConfirm, doCancel } = useAlertContext();

const handleConfirm = () => {
  // Perform some validation or operation
  doConfirm();
};

const handleCancel = () => {
  doCancel();
};
</script>
```

```typescript
// Usage
import { alert } from '@hj-fe/common-ui';
import CustomContent from './CustomContent.vue';

await alert({
  title: 'Custom Component',
  content: CustomContent,
});
```
