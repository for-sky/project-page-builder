# Table 使用示例模板

## 模板用途
用于生成 CRUD 页面的 Table 使用示例模板

## 1. 基础表格

### 最简表格

```vue
<template>
  <Grid />
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '@/adapter/vxe-table';

const [Grid] = useVbenVxeGrid({
  gridOptions: {
    columns: [
      { field: 'name', title: 'Name' },
      { field: 'age', title: 'Age' },
      { field: 'email', title: 'Email' },
    ],
    data: [
      { name: 'Zhang San', age: 25, email: 'zhangsan@example.com' },
      { name: 'Li Si', age: 30, email: 'lisi@example.com' },
    ],
  },
});
</script>
```

## 2. 带搜索表单的表格

```vue
<template>
  <Grid />
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '@/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  showSearchForm: true,
  formOptions: {
    schema: [
      {
        component: 'Input',
        fieldName: 'name',
        label: 'Name',
      },
      {
        component: 'Input',
        fieldName: 'email',
        label: 'Email',
      },
    ],
  },
  gridOptions: {
    columns: [
      { field: 'name', title: 'Name' },
      { field: 'age', title: 'Age' },
      { field: 'email', title: 'Email' },
    ],
    proxyConfig: {
      ajax: {
        query: async ({ page, form }) => {
          // form is the search form values
          return await fetchTableData({
            page: page.currentPage,
            pageSize: page.pageSize,
            ...form,
          });
        },
      },
    },
  },
});
</script>
```

## 3. 远程数据加载

```vue
<template>
  <Grid />
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '@/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  gridOptions: {
    columns: [
      { field: 'name', title: 'Name' },
      { field: 'age', title: 'Age' },
      { field: 'email', title: 'Email' },
    ],
    proxyConfig: {
      ajax: {
        query: async ({ page }) => {
          const response = await fetchTableData({
            page: page.currentPage,
            pageSize: page.pageSize,
          });
          return {
            items: response.data,
            total: response.total,
          };
        },
      },
    },
  },
});
</script>
```

## 4. 带操作列的表格

```vue
<template>
  <Grid>
    <template #action="{ row }">
      <t-button variant="text" theme="primary" size="small" @click="handleEdit(row)">Edit</t-button>
      <t-button variant="text" theme="danger" size="small" @click="handleDelete(row)">Delete</t-button>
    </template>
  </Grid>
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '@/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  gridOptions: {
    columns: [
      { field: 'name', title: 'Name' },
      { field: 'age', title: 'Age' },
      { field: 'email', title: 'Email' },
      {
        field: 'action',
        title: 'Action',
        width: 200,
        slots: { default: 'action' },
      },
    ],
    proxyConfig: {
      ajax: {
        query: async ({ page }) => {
          return await fetchTableData({
            page: page.currentPage,
            pageSize: page.pageSize,
          });
        },
      },
    },
  },
});

const handleEdit = (row: any) => {
  console.log('Edit', row);
};

const handleDelete = (row: any) => {
  console.log('Delete', row);
};
</script>
```

## 5. 单元格编辑

```vue
<template>
  <Grid />
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '@/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  gridOptions: {
    columns: [
      {
        field: 'name',
        title: 'Name',
        editRender: { name: 'input' },
      },
      {
        field: 'age',
        title: 'Age',
        editRender: { name: 'input' },
      },
      { field: 'email', title: 'Email' },
    ],
    editConfig: {
      mode: 'cell',
      trigger: 'click',
    },
    data: [
      { name: 'Zhang San', age: 25, email: 'zhangsan@example.com' },
      { name: 'Li Si', age: 30, email: 'lisi@example.com' },
    ],
  },
});
</script>
```

## 6. 行编辑

```vue
<template>
  <Grid />
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '@/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  gridOptions: {
    columns: [
      {
        field: 'name',
        title: 'Name',
        editRender: { name: 'input' },
      },
      {
        field: 'age',
        title: 'Age',
        editRender: { name: 'input' },
      },
      { field: 'email', title: 'Email' },
    ],
    editConfig: {
      mode: 'row',
      trigger: 'click',
    },
    data: [
      { name: 'Zhang San', age: 25, email: 'zhangsan@example.com' },
      { name: 'Li Si', age: 30, email: 'lisi@example.com' },
    ],
  },
});
</script>
```

## 7. 树形表格

```vue
<template>
  <Grid />
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '@/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  gridOptions: {
    columns: [
      { field: 'name', title: 'Name', treeNode: true },
      { field: 'size', title: 'Size' },
      { field: 'type', title: 'Type' },
    ],
    treeConfig: {
      transform: true,
      parentField: 'parentId',
      rowField: 'id',
    },
    data: [
      { id: 1, name: 'Root', size: '-', type: 'Folder', parentId: null },
      { id: 2, name: 'Documents', size: '-', type: 'Folder', parentId: 1 },
      { id: 3, name: 'readme.md', size: '1KB', type: 'File', parentId: 2 },
    ],
  },
});
</script>
```

## 8. 固定列

```vue
<template>
  <Grid />
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '@/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  gridOptions: {
    columns: [
      { field: 'name', title: 'Name', fixed: 'left', width: 150 },
      { field: 'age', title: 'Age', width: 100 },
      { field: 'email', title: 'Email', width: 200 },
      { field: 'address', title: 'Address', width: 300 },
      { field: 'phone', title: 'Phone', width: 150 },
      { field: 'action', title: 'Action', fixed: 'right', width: 150 },
    ],
    data: [],
  },
});
</script>
```

## 9. 自定义单元格渲染（插槽方式）

```vue
<template>
  <Grid>
    <template #status="{ row }">
      <t-tag :theme="row.status === 1 ? 'success' : 'danger'" variant="light">
        {{ row.status === 1 ? 'Enabled' : 'Disabled' }}
      </t-tag>
    </template>
  </Grid>
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '@/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  gridOptions: {
    columns: [
      { field: 'name', title: 'Name' },
      {
        field: 'status',
        title: 'Status',
        slots: { default: 'status' },
      },
    ],
    data: [
      { name: 'Zhang San', status: 1 },
      { name: 'Li Si', status: 0 },
    ],
  },
});
</script>
```

## 10. 自定义单元格渲染（渲染器方式）

使用自定义渲染器前，需要先在适配器中注册（参考 `assets/table-adapter-template.md`）。

```vue
<template>
  <Grid />
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '@/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  gridOptions: {
    columns: [
      { field: 'name', title: 'Name' },
      {
        field: 'avatar',
        title: 'Avatar',
        cellRender: { name: 'CellImage' },
      },
      {
        field: 'link',
        title: 'Link',
        cellRender: { name: 'CellLink', props: { text: 'View Details' } },
      },
    ],
    data: [
      { name: 'Zhang San', avatar: 'https://example.com/avatar1.jpg', link: '#' },
      { name: 'Li Si', avatar: 'https://example.com/avatar2.jpg', link: '#' },
    ],
  },
});
</script>
```

## 11. 自定义工具栏

```vue
<template>
  <Grid>
    <template #toolbar-actions>
      <t-button theme="primary" @click="handleAdd">Add</t-button>
      <t-button variant="outline" @click="handleExport">Export</t-button>
    </template>

    <template #toolbar-tools>
      <t-button variant="outline" @click="handleRefresh">Refresh</t-button>
    </template>
  </Grid>
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '@/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  gridOptions: {
    columns: [
      { field: 'name', title: 'Name' },
      { field: 'age', title: 'Age' },
    ],
    data: [],
  },
});

const handleAdd = () => {
  console.log('Add');
};

const handleExport = () => {
  console.log('Export');
};

const handleRefresh = () => {
  gridApi.reload();
};
</script>
```

## 12. 使用 GridApi 方法

```vue
<template>
  <div>
    <t-space class="mb-4">
      <t-button @click="handleReload">Reload Table</t-button>
      <t-button @click="handleQuery">Query Table</t-button>
      <t-button @click="handleToggleSearch">Toggle Search Form</t-button>
      <t-button @click="handleSetLoading">Set Loading</t-button>
    </t-space>
    <Grid />
  </div>
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '@/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  showSearchForm: true,
  formOptions: {
    schema: [
      {
        component: 'Input',
        fieldName: 'name',
        label: 'Name',
      },
    ],
  },
  gridOptions: {
    columns: [
      { field: 'name', title: 'Name' },
      { field: 'age', title: 'Age' },
    ],
    proxyConfig: {
      ajax: {
        query: async ({ page }) => {
          return await fetchTableData({
            page: page.currentPage,
            pageSize: page.pageSize,
          });
        },
      },
    },
  },
});

// Reload table (will reset pagination)
const handleReload = () => {
  gridApi.reload();
};

// Query table (keep current pagination)
const handleQuery = () => {
  gridApi.query();
};

// Toggle search form display/hide
const handleToggleSearch = () => {
  gridApi.toggleSearchForm();
};

// Set loading state
const handleSetLoading = () => {
  gridApi.setLoading(true);
  setTimeout(() => {
    gridApi.setLoading(false);
  }, 2000);
};
</script>
```

## 13. 虚拟滚动

```vue
<template>
  <Grid />
</template>

<script setup lang="ts">
import { useVbenVxeGrid } from '@/adapter/vxe-table';

const [Grid, gridApi] = useVbenVxeGrid({
  gridOptions: {
    columns: [
      { field: 'name', title: 'Name' },
      { field: 'age', title: 'Age' },
      { field: 'email', title: 'Email' },
    ],
    scrollY: {
      enabled: true,
      gt: 100, // Enable virtual scrolling when data exceeds 100 rows
    },
    data: [], // Large amount of data
  },
});
</script>
```
