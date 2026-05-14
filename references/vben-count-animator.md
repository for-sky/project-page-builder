# Vben CountToAnimator（数字动画）

框架提供了一个数字动画组件，支持数字滚动动画效果。

如果文档中未包含参数说明，请参考在线示例。

**具体用法示例和代码模板请参考**：`assets/count-to-template.md`

## 重要说明

如果现有组件封装无法满足需求，可以使用原生组件或自行封装组件。框架提供的组件并非强制，按需使用即可。

## 基础用法

通过 start-val 和 end-val 设置数字动画起止值，持续时间为 3000ms。

示例：30,000

## 自定义前缀与分隔符

通过 prefix 和 separator 设置数字动画前缀与分隔符。

示例：$2/000/000

## Props

### startVal
- **Type**: `number`
- **Default**: `0`
- **Description**: 起始值

### endVal
- **Type**: `number`
- **Default**: `2021`
- **Description**: 结束值

### duration
- **Type**: `number`
- **Default**: `1500`
- **Description**: 动画时长

### autoplay
- **Type**: `boolean`
- **Default**: `true`
- **Description**: 自动执行

### prefix
- **Type**: `string`
- **Default**: -
- **Description**: 前缀

### suffix
- **Type**: `string`
- **Default**: -
- **Description**: 后缀

### separator
- **Type**: `string`
- **Default**: `,`
- **Description**: 分隔符

### color
- **Type**: `string`
- **Default**: -
- **Description**: 字体颜色

### useEasing
- **Type**: `boolean`
- **Default**: `true`
- **Description**: 是否启用缓动动画

### transition
- **Type**: `string`
- **Default**: `linear`
- **Description**: 动画效果

### decimals
- **Type**: `number`
- **Default**: `0`
- **Description**: 保留小数位数

## 事件

### started
- **Type**: `() => void`
- **Description**: 动画开始

### finished
- **Type**: `() => void`
- **Description**: 动画结束

### onStarted
- **Type**: `() => void`
- **Description**: 动画开始

### onFinished
- **Type**: `() => void`
- **Description**: 动画结束

## 方法

### start
- **Type**: `() => void`
- **Description**: 开始执行动画

### reset
- **Type**: `() => void`
- **Description**: 重置
