# 页面模板用法

## 说明
本项目业务页面不使用 Page 组件包裹，直接使用普通 div 或直接放置业务组件作为根元素。

## 基础结构
```vue
<template>
  <div>
    <!-- 业务内容 -->
  </div>
</template>

<script setup lang="ts">
</script>
```

## 使用规则
1. 页面根元素使用普通 `<div>` 即可
2. 不需要导入或使用 `Page` 组件
3. 表格页面直接使用 `useVbenVxeGrid` 生成的 Grid 组件
