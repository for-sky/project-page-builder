# Table 适配器配置模板

## 模板用途
用于生成 CRUD 页面时的 Table 适配器配置模板

## 适配器说明

每个应用都可以按需配置自己的 vxe-table 适配器。下面是一个简单配置示例：

```typescript
import { h } from 'vue';

import { setupVbenVxeTable, useVbenVxeGrid } from '@hj-fe/plugins/vxe-table';

import { Button, Image } from 'tdesign-vue-next';

import { useVbenForm } from './form';

setupVbenVxeTable({
  configVxeTable: (vxeUI) => {
    vxeUI.setConfig({
      grid: {
        align: 'center',
        border: false,
        columnConfig: {
          resizable: true,
        },
        minHeight: 180,
        formConfig: {
          // 全局禁用 vxe-table 的 form 配置，改用 formOptions
          enabled: false,
        },
        proxyConfig: {
          autoLoad: true,
          response: {
            result: 'items',
            total: 'total',
            list: 'items',
          },
          showActiveMsg: true,
          showResponseMsg: false,
        },
        round: true,
        showOverflow: true,
        size: 'small',
      },
    });

    // 表格配置可使用 cellRender: { name: 'CellImage' }
    vxeUI.renderer.add('CellImage', {
      renderTableDefault(_renderOpts, params) {
        const { column, row } = params;
        return h(Image, { src: row[column.field] });
      },
    });

    // 表格配置可使用 cellRender: { name: 'CellLink' }
    vxeUI.renderer.add('CellLink', {
      renderTableDefault(renderOpts) {
        const { props } = renderOpts;
        return h(
          Button,
          { size: 'small', theme: 'primary', variant: 'text' },
          { default: () => props?.text },
        );
      },
    });

    // 可在此扩展 vxe-table 全局配置，例如自定义格式化
    // vxeUI.formats.add
  },
  useVbenForm,
});

export { useVbenVxeGrid };

export type * from '@hj-fe/plugins/vxe-table';
```
