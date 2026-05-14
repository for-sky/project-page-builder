# CountToAnimator 使用示例模板

## 模板用途
用于生成数字动画组件的使用示例模板

## 1. 基础用法

```vue
<template>
  <VbenCountToAnimator :end-val="30000" />
</template>

<script setup lang="ts">
import { VbenCountToAnimator } from '@hj-fe/common-ui';
</script>
```

## 2. 自定义前缀与分隔符

```vue
<template>
  <VbenCountToAnimator
    :duration="3000"
    :end-val="2000000"
    :start-val="1"
    prefix="$"
    separator="/"
  />
</template>

<script setup lang="ts">
import { VbenCountToAnimator } from '@hj-fe/common-ui';
</script>
```

## 3. 自定义后缀

```vue
<template>
  <VbenCountToAnimator
    :end-val="99.99"
    :decimals="2"
    suffix="%"
  />
</template>

<script setup lang="ts">
import { VbenCountToAnimator } from '@hj-fe/common-ui';
</script>
```

## 4. 自定义颜色与时长

```vue
<template>
  <VbenCountToAnimator
    :end-val="10000"
    :duration="5000"
    color="#ff6b6b"
  />
</template>

<script setup lang="ts">
import { VbenCountToAnimator } from '@hj-fe/common-ui';
</script>
```

## 5. 手动控制动画

```vue
<template>
  <div>
    <VbenCountToAnimator
      ref="countToRef"
      :end-val="50000"
      :autoplay="false"
    />
    <div class="mt-4">
      <t-button @click="handleStart">Start</t-button>
      <t-button @click="handleReset">Reset</t-button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { VbenCountToAnimator } from '@hj-fe/common-ui';

const countToRef = ref();

const handleStart = () => {
  countToRef.value?.start();
};

const handleReset = () => {
  countToRef.value?.reset();
};
</script>
```

## 6. 监听动画事件

```vue
<template>
  <VbenCountToAnimator
    :end-val="88888"
    @started="handleStarted"
    @finished="handleFinished"
  />
</template>

<script setup lang="ts">
import { VbenCountToAnimator } from '@hj-fe/common-ui';

const handleStarted = () => {
  console.log('Animation started');
};

const handleFinished = () => {
  console.log('Animation finished');
};
</script>
```

## 7. 小数位设置

```vue
<template>
  <VbenCountToAnimator
    :end-val="3.1415926"
    :decimals="4"
  />
</template>

<script setup lang="ts">
import { VbenCountToAnimator } from '@hj-fe/common-ui';
</script>
```

## 8. 禁用缓动效果

```vue
<template>
  <VbenCountToAnimator
    :end-val="100000"
    :use-easing="false"
  />
</template>

<script setup lang="ts">
import { VbenCountToAnimator } from '@hj-fe/common-ui';
</script>
```
