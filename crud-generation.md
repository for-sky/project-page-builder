# CRUD 生成流程

## 适用场景

- 用户直接要求生成 CRUD 模块（无图片）
- 图片识别流程中判断为 CRUD 页面，转入此流程

---

## 强制执行步骤（任何步骤都不能跳过）

### 步骤 1：收集需求（必须先询问，不能跳过）

在生成任何代码之前，如果用户未提供以下信息，必须逐项提问，并在得到确认后才能进入步骤 2。
不要根据上下文猜测后直接生成：

- 模块名称（英文，例如 user、product）
- 字段列表与类型（name、type、required、校验规则）
- 是否需要多标签（multi-tab）
- 特殊功能需求（导入/导出、批量操作等）
- 必须启用 i18n

**如果是从图片识别流程转入的，用图片分析结果作为需求输入，但仍需确认模块名称和未明确的信息。**

### 步骤 2：确认接口来源（必须询问用户，不能跳过）

在生成 `types.ts` 和 `index.ts` 之前，必须确认接口数据的来源。

#### 2.1 询问用户接口来源

使用 `AskUserQuestion` 工具询问用户：

> **"接口数据从哪里获取？"**
> - 选项 A：从 Apifox MCP 获取（用户提供项目名和接口名）
> - 选项 B：自定义接口（AI 根据需求自行定义，但需用户确认）
> - 选项 C：用户直接提供接口信息

#### 2.2 从 Apifox MCP 获取接口

如果用户选择从 Apifox 获取：

1. 调用 `mcp_apifox-new-mcp_listAccessibleProjects` 获取可访问的项目列表
2. 使用 `AskUserQuestion` 让用户选择目标项目
3. 调用 `mcp_apifox-new-mcp_getProjectSummary` 获取项目结构
4. 调用 `mcp_apifox-new-mcp_getStructureInfo` 搜索相关接口（`entityType: "endpoint"`）
5. 使用 `AskUserQuestion` 让用户确认需要用到的接口列表
6. 调用 `mcp_apifox-new-mcp_readEntityDetails` 读取每个接口的完整详情
7. 根据接口详情生成 `types.ts` 中的请求/响应类型

**如果 Apifox MCP 工具不可用（连接失败、无权限等）**，回退到自定义接口模式（步骤 2.3），并告知用户。

#### 2.3 自定义接口

如果用户选择自定义接口：

1. 根据步骤 1 收集的需求，列出需要定义的接口清单（增删改查 + 特殊操作）
2. 列出每个接口的：方法（GET/POST/PUT/DELETE）、路径、请求参数、响应结构
3. 使用 `AskUserQuestion` 展示接口清单，让用户确认或修改
4. 用户确认后，根据接口定义生成 `types.ts` 中的类型

#### 2.4 用户直接提供

如果用户直接提供了接口信息（如 Swagger JSON、接口文档等），直接使用用户提供的数据生成类型。

**⚠️ 无论如何，在生成 `types.ts` 之前，必须向用户展示最终的类型定义清单并获得确认。**

### 步骤 3：阅读参考文档（生成前必须阅读）

**优先阅读默认 CRUD 模板：`assets/crud-template.md`**

**在生成任何组件之前，必须先阅读对应文档。绝不能凭记忆生成。**

**在使用 useVbenModal、useVbenDrawer、useVbenVxeGrid 之前，必须在项目中搜索并确认真实的 import 路径。绝不能猜。**

**组件使用规则：** 参照 `SKILL.md` 中的"组件使用规则"。优先使用 `src/adapter/component/index.ts` 中注册的 Vben 组件；如果框架没有封装所需组件，直接使用 `tdesign-vue-next` 原生组件。不确定用法时，使用 `WebFetch` 抓取 `https://tdesign.tencent.com/vue-next/components/[组件名]` 查看文档。

| Component Type | Read This Doc First | Then Refer to This Template |
|---|---|---|
| Form | `references/vben-form.md` | `assets/form-template.md` |
| Table | `references/vben-table.md` | `assets/table-usage-template.md` |
| Modal | `references/vben-modal.md` | `assets/modal-template.md` |
| Drawer | `references/vben-drawer.md` | `assets/drawer-template.md` |
| Count Animator | `references/vben-count-animator.md` | `assets/count-animator-template.md` |
| Ellipsis Text | `references/vben-ellipsis-text.md` | `assets/ellipsis-text-template.md` |
| Alert | `references/vben-alert.md` | `assets/alert-template.md` |

### 步骤 4：生成文件结构

下列所有文件都必须生成。即使用户已经提供了信息，也不能漏掉任何一个：

```
src/
├── api/
│   └── [module]/
│       ├── types.ts              # Type definitions, must generate
│       └── index.ts              # API interfaces, must generate
├── router/
│   └── routes/
│       └── modules/
│           └── [module].ts       # Route config, must generate
├── locales/
│   └── langs/
│       ├── zh-CN/
│       │   └── page.json             # Append [module] translations here
│       └── en-US/
│           └── page.json             # Append [module] translations here
└── views/
    └── [module]/                 # e.g. push/
        ├── index.vue             # Main page, must generate
        └── components/              # Sub-component directory
            ├── form.vue          # Form component, must generate
            └── data.ts           # Data config, must generate
```

**重要：`index.vue` 和 `data.ts` 位于 `[module]/` 根目录；`form.vue`、`drawer.vue` 等组件位于 `[module]/modules/`。不要额外再嵌套一层 `[module]` 子目录。**

**文件职责：**
- `types.ts`：定义请求/响应类型与实体类型
- `index.ts`：封装 CRUD API 方法（create、read、update、delete）
- `[module].ts`：路由配置，定义菜单与页面路由
- `form.vue`：使用 `useVbenModal` 或 `useVbenDrawer` 的表单组件
- `data.ts`：表格列配置与搜索表单 schema
- `index.vue`：主页面，使用 `useVbenVxeGrid` 集成表格

### 步骤 5：代码质量检查（输出总结前必须完成，不能跳过）

#### 5.1 自动化脚本检查（先执行）

**Windows (PowerShell)：**

```powershell
powershell -File .trae/skills/project-page-builder/scripts/check.ps1 -ApiPath <api-path> -ViewsPath <views-path>
# Example: powershell -File .trae/skills/project-page-builder/scripts/check.ps1 -ApiPath src/api/system/push -ViewsPath src/views/system/push
```

**Linux/macOS (Bash)：**

```bash
bash .trae/skills/project-page-builder/scripts/check.sh <api-path> <views-path>
# Example: bash .trae/skills/project-page-builder/scripts/check.sh src/api/system/push src/views/system/push
```

如果脚本输出错误，修复错误并重新运行。
只有当所有检查都通过后，才能进入 5.2。

#### 5.2 人工文档核对（脚本通过后再执行）

脚本无法验证组件 API 的使用是否正确，必须对照文档进行人工核对：

- [ ] Read `references/vben-form.md`, verify form API usage in form.vue
- [ ] Read `references/vben-table.md`, verify table column config in data.ts
- [ ] Read `references/vben-modal.md` or `vben-drawer.md`, verify modal/drawer usage
- [ ] Verify type definitions in types.ts match usage in form.vue, data.ts, and index.ts
- [ ] Verify API method parameters match request types defined in types.ts
- [ ] Verify i18n: all Chinese/English text in code uses `$t()`, no hardcoded strings
- [ ] Verify i18n: zh-CN and en-US translation keys are consistent and complete

修复发现的任何不一致。只有在所有检查都通过后，才能输出最终总结。

---

## ⚠️ 严重警告：二次确认与点击事件绝对不能同时配置

AI 经常犯这个错误，必须严格遵守以下规则。

### ❌ 错误示例（会导致方法被调用两次）

```ts
{
  onClick: handleDelete.bind(null, record), // ❌ 第一次调用
  popConfirm: {
    title: '是否确认删除？',
    confirm: handleDelete.bind(null, record), // ❌ 第二次调用
  },
}
```

### ✅ 正确示例

使用二次确认（需要确认）：

```ts
{
  popConfirm: {
    title: '是否确认删除？',
    confirm: handleDelete.bind(null, record),
  },
}
```

使用点击事件（不需要确认）：

```ts
{
  onClick: handleEdit.bind(null, record),
}
```

### 检查清单（生成代码后必须检查）

- [ ] 如果配置了二次确认（如 `popConfirm.confirm`），是否同时配置了 `onClick`？如果有，立即删除其中一个
- [ ] 如果配置了 `onClick`，是否又配置了二次确认？如果有，立即删除其中一个
- [ ] 任何单个操作入口只能选择一种触发方式：点击触发或确认触发

---

## ⚠️ 严格禁止：绝对不要修改用户未要求的代码

这是最重要的规则，必须严格遵守。

### ❌ 严重错误

用户要求："已发布的数据不允许修改和删除"

AI 错误做法（绝对不要这样做）：

```ts
// ❌ 错误：擅自修改了用户已有配置
{
  auth: 'xxx:publish',
}
```

### ✅ 正确做法

用户要求什么，就只做什么，其他保持不变：

```ts
// ✅ 正确：只添加用户要求的限制逻辑
{
  auth: 'xxx:update',
  ifShow: () => record.published !== 1,
}
```

### 检查清单（每次修改代码前必须确认）

- [ ] 我是否只改动了用户明确要求修改的部分？
- [ ] 我是否改动了用户未提及的代码（包括权限、接口路径、字段名、默认值、路由、组件结构）？
- [ ] 如果我认为用户方案"可能有问题"，是否先提问而不是直接改？

---

## 输出格式

生成完成后，必须严格按以下格式输出总结：

```
✅ [Module Name] CRUD Module Generation Complete

📁 Generated Files:
- src/api/[module]/types.ts
- src/api/[module]/index.ts
- src/router/routes/modules/[module].ts
- src/views/[module]/index.vue
- src/views/[module]/modules/form.vue
- src/views/[module]/data.ts

📝 Updated Files:
- src/locales/langs/zh-CN/page.json (append [module] translations)
- src/locales/langs/en-US/page.json (append [module] translations)

🎯 Next Steps:
1. Adjust API endpoint URLs to match actual backend paths
2. Add route configuration
3. Adjust field validation and display logic based on business requirements
```
