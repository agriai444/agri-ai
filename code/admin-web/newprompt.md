
this List.vue and Add.vue and Update.vue and  store/index.ts for CompanyAI now i want for ModelAI


declare namespace APIAI {

    type inputOutputData = 'Text' | 'Image' | 'Audio' | 'Video' | 'Documents'
    interface CompanyAI {
      id?: string; // UUID
      name: string;
      companyUrl?: string; // Optional
      logoUrl?: string; // Optional
      apiUrl: string;
      isActivate: boolean;
      createdAt: string; // Timestamp
      updatedAt: string; // Timestamp
    }
  
    interface ModelAI {
      id: string; // UUID
      companyId: string; // UUID referencing CompanyAI
      name: string;
      modelCode: string;
      description?: string; // Optional
      isActivate: boolean;
      version?: string; // Optional
      createdAt: string; // Timestamp
      updatedAt: string; // Timestamp
    }
}




# store/index.ts

```typescript
import { defineStore } from 'pinia';
import { supabase } from '@/utils/supabase';
import { camelToSnake, snakeToCamel } from '@/utils/functions';

export const useModelStore = defineStore('model', {
  state: () => ({
    listModels: [] as APIAI.ModelAI[],
    showModelAdd: false,
    showModelUpdate: false,
    initState: (): APIAI.ModelAI => ({
      id: '',
      companyId: '',
      name: '',
      modelCode: '',
      description: '',
      isActivate: false,
      version: '',
      createdAt: '',
      updatedAt: '',
    }),
    countTotalData: 0
  }),

  actions: {
    async fetchDataAction({ limit, offset }: { limit: number; offset: number }) {
      try {
        const { data, totalCount } = await fetchData({ limit, offset });
        this.listModels = data;
        this.countTotalData = totalCount;
      } catch (error: any) {
        console.error('Error fetching data:', error.message);
        throw error;
      }
    },

    async insertDataAction(model: APIAI.ModelAI) {
      try {
        const newModel = await insertData(model);
        this.listModels.push(newModel);
        this.countTotalData += 1;
      } catch (error: any) {
        console.error('Error inserting data:', error.message);
        throw error;
      }
    },

    async updateDataAction(model: APIAI.ModelAI) {
      try {
        const updatedModel = await updateData(model);
        const index = this.listModels.findIndex(m => m.id === updatedModel.id);
        if (index !== -1) {
          this.listModels[index] = updatedModel;
        }
      } catch (error: any) {
        console.error('Error updating data:', error.message);
        throw error;
      }
    },

    async deleteDataAction(id: string) {
      try {
        await deleteData(id);
        this.listModels = this.listModels.filter(model => model.id !== id);
        this.countTotalData -= 1;
      } catch (error: any) {
        console.error('Error deleting data:', error.message);
        throw error;
      }
    }
  }
});

const fetchData = async ({ limit, offset }: { limit: number; offset: number }): Promise<{ data: APIAI.ModelAI[], totalCount: number }> => {
  try {
    const { data, count, error } = await supabase
      .from('ai_model')
      .select('*', { count: 'exact' })
      .order('updated_at')
      .range(offset, offset + limit - 1);

    if (error) {
      throw error;
    }

    const camelData = data?.map(snakeToCamel) || [];
    return { data: camelData as APIAI.ModelAI[], totalCount: count || 0 };
  } catch (error: any) {
    console.error('Error fetching models from Supabase:', error.message);
    throw error;
  }
};

const insertData = async (dataInserted: APIAI.ModelAI): Promise<APIAI.ModelAI> => {
  try {
    const snakeData = [dataInserted].map(camelToSnake);
    const { data, error } = await supabase
      .from('ai_model')
      .insert(snakeData)
      .select();

    if (error) {
      throw error;
    }

    const inserted = data ? data[0] : null;
    if (!inserted) {
      throw new Error('No data returned after insertion');
    }

    const camelData = [inserted].map(snakeToCamel);
    return camelData[0] as APIAI.ModelAI;
  } catch (error: any) {
    console.error('Error inserting model:', error.message);
    throw error;
  }
};

const updateData = async (dataUpdated: APIAI.ModelAI): Promise<APIAI.ModelAI> => {
  try {
    const snakeData = [dataUpdated].map(camelToSnake);
    const { data, error } = await supabase
      .from('ai_model')
      .update(snakeData)
      .eq('id', dataUpdated.id)
      .select();

    if (error) {
      throw error;
    }

    const updated = data ? data[0] : null;
    if (!updated) {
      throw new Error('No data returned after update');
    }

    const camelData = [updated].map(snakeToCamel);
    return camelData[0] as APIAI.ModelAI;
  } catch (error: any) {
    console.error('Error updating model:', error.message);
    throw error;
  }
};

const deleteData = async (id: string): Promise<void> => {
  try {
    const { error } = await supabase
      .from('ai_model')
      .delete()
      .eq('id', id);

    if (error) {
      throw error;
    }
  } catch (error: any) {
    console.error('Error deleting model:', error.message);
    throw error;
  }
};


```

List.vue

```vue
<script setup lang='ts'>
import { ref, h, onMounted, computed, reactive } from 'vue'
import {
  NSpace, NButton, NDataTable, DataTableBaseColumn,
  useDialog, NResult,
  DataTableRowKey, NModal,
  useMessage, DataTableColumns,
  NA,
  NText,
  NSwitch,
  NAvatar,
} from 'naive-ui'
import { useCompanyStore } from '@/store'
import { t } from '@/locales';
import { useIconRender } from '@/hooks/useIconRender'
import { useBasicLayout } from '@/hooks/useBasicLayout';
import { SvgIcon } from '@/components/common';
import Add from './Add.vue'
import Update from './Update.vue'
import { getImageUrl } from '@/utils/supabasehelper';
const { iconRender } = useIconRender()
const loadingActionDelete = ref(false)
const loadingActionEdit = ref(false)
const loading = ref(true)
const error_get = ref<boolean>(false)
const companyStore = useCompanyStore()
const checkedRowKeysRef = ref<Array<string | number>>([])
const { isMobile } = useBasicLayout()
const dialog = useDialog()
const message = useMessage();
const rowEdit = ref<APIAI.CompanyAI | null>(null);
// Compute the data for the current page
const data = computed(() => {
  const start = (pagination.page - 1) * pagination.pageSize;
  const end = start + pagination.pageSize;
  return companyStore.listCompanies.slice(start, end);
});

const pageSize = ref(10);
const itemCount = computed(() => companyStore.countTotalData);
const pagination = reactive({
  page: 1,
  pageCount: computed(() => Math.ceil(itemCount.value / pageSize.value)),
  pageSize: pageSize.value,
});



async function handleUpdate(row: APIAI.CompanyAI) {
  companyStore.showModelUpdate = true;
  rowEdit.value = row;
}


const mainColumns = reactive<DataTableBaseColumn<APIAI.CompanyAI>[]>([
  {
    title: t('common.name'),
    key: 'name',
    align: 'center',
    render(row: APIAI.CompanyAI) {
      return h(NText, { strong: true }, { default: () => row.name });
    }
  },
  {
    title: t('common.companyUrl'),
    key: 'companyUrl',
    align: 'center',
    render(row: APIAI.CompanyAI) {
      return row.companyUrl ? h(NA, { href: row.companyUrl, target: '_blank' }, { default: () => row.companyUrl }) : null;
    },
    ellipsis: true
  },
  {
    title: t('common.logoUrl'),
    key: 'logoUrl',
    align: 'center',
    render(row: APIAI.CompanyAI) {
      const hasLogoUrl = row.logoUrl !== null && row.logoUrl !== undefined && row.logoUrl.trim() !== '';

      const defaultIcon = h(SvgIcon, {
        icon: "mdi:company",
        class: "text-lg text-primary"
      });

      return hasLogoUrl
        ? h(NAvatar, {
          round: true,
          src: row.logoUrl,
          size: "large"
        })
        : defaultIcon;
    },
    ellipsis: true
  },
  {
    title: t('common.apiUrl'),
    key: 'apiUrl',
    align: 'center',
    render(row: APIAI.CompanyAI) {
      return h(NText, { type: 'info' }, { default: () => row.apiUrl });
    },
    ellipsis: true
  },
  {
    title: t('common.isActivate'),
    key: 'isActivate',
    align: 'center',
    render(row: APIAI.CompanyAI) {
      return h(NSwitch, { value: row.isActivate, disabled: true });
    }
  },
  {
    title: t('common.createdAt'),
    key: 'createdAt',
    align: 'center',
    render(row: APIAI.CompanyAI) {
      return h(NText, {}, { default: () => new Date(row.createdAt).toLocaleString() });
    }
  },
  {
    title: t('common.updatedAt'),
    key: 'updatedAt',
    align: 'center',
    render(row: APIAI.CompanyAI) {
      return h(NText, {}, { default: () => new Date(row.updatedAt).toLocaleString() });
    }
  }
]);


const columns = reactive<DataTableColumns<APIAI.CompanyAI>>([
  {
    type: 'selection',
  },
  ...mainColumns,
  {
    title: t('common.actions'),
    key: 'actions',
    align: 'center',
    width: 100,
    render(row: APIAI.CompanyAI) {
      return h(
        'div',
        {
          class: 'flex gap-1'
        },
        [
          h(
            NButton,
            {
              strong: true,
              tertiary: true,
              size: 'small',
              loading: loadingActionEdit.value,
              style: "border-radius:100%",
              onClick: async () => {
                try {
                  await handleUpdate(row);
                } catch (error: any) {
                  console.error(t('common.updateFailed'), error.message);
                }
              }
            },
            { default: () => h(iconRender({ icon: 'fluent:edit-32-regular', color: 'blue' })) }
          ),
          h(
            NButton,
            {
              strong: true,
              tertiary: true,
              size: 'small',
              loading: loadingActionDelete.value,
              style: "border-radius:100%",
              onClick: async () => {
                try {
                  handleDeleteAction(row)
                } catch (error: any) {
                  console.error(t('common.deleteFailed'), error.message);
                }
              }
            },
            { default: () => h(iconRender({ icon: 'fluent:delete-32-regular', color: 'red' })) }
          )
        ]
      )
    }
  },
]);

async function fetchData(): Promise<void> {
  try {
    loading.value = true;
    const { page, pageSize } = pagination;
    await companyStore.fetchDataAction({ limit: pageSize, offset: (page - 1) * pageSize });

    // Resolve image URLs for each company
    companyStore.listCompanies = await Promise.all(companyStore.listCompanies.map(async (company) => {
      // Check if logoUrl is present
      if (company.logoUrl) {
        try {
          company.logoUrl = await getImageUrl(companyStore.bucket ,company.logoUrl);
        } catch (error) {
          console.error(`Failed to fetch image for company ${company.name}:`, error);

        }
      }

      return {
        ...company
      };
    }));
  } catch (error: any) {
    error_get.value = true;
    console.error(t('chat.dataFetchError'), error.message);
  } finally {
    loading.value = false;
  }
}




onMounted(async () => {
  await fetchData()
})


function handleDeleteAction(row: APIAI.CompanyAI) {
  const deleteDialog = dialog.warning({
    title: t('common.deleteConfirmation'),
    content: t('common.deleteConfirmationMessage'),
    positiveText: t('common.yes'),
    negativeText: t('common.no'),
    onPositiveClick: async () => {
      try {
        deleteDialog.loading = true
        await companyStore.deleteDataAction(row.id!)
        message.success(t('common.deleteSuccess'));



        // Check if the current page is empty after deletion
        const start = (pagination.page - 1) * pagination.pageSize;
        const end = start + pagination.pageSize;
        const currentPageData = companyStore.listCompanies.slice(start, end);

        // If current page is empty and it is not the first page, navigate to the previous page
        if (currentPageData.length === 0 && pagination.page > 1) {
          pagination.page -= 1;
        }

        await fetchData();
      } catch (error: any) {
        deleteDialog.loading = false
        message.error(t('common.deleteFailed'));
      } finally {
        deleteDialog.loading = false
      }
    },
  });
}
const rowKey = (row: APIAI.CompanyAI) => row.id!;

function handleCheck(rowKeys: DataTableRowKey[]) {
  checkedRowKeysRef.value = rowKeys
}

function deleteSelectedRows() {
  const deleteDialog = dialog.warning({
    title: t('common.deleteConfirmation'),
    content: t('common.deleteConfirmationMessage'),
    positiveText: t('common.yes'),
    negativeText: t('common.no'),
    onPositiveClick: async () => {
      try {
        deleteDialog.loading = true;

        // Verify that IDs are correct
        console.log('Selected Row Keys:', checkedRowKeysRef.value);

        // Convert IDs to string if necessary
        const deletePromises = checkedRowKeysRef.value.map(id => companyStore.deleteDataAction(String(id)));
        await Promise.all(deletePromises);
        message.success(t('common.deleteSuccess'));

        // Fetch data after deletion
        await fetchData();

        const start = (pagination.page - 1) * pagination.pageSize;
        const end = start + pagination.pageSize;
        const currentPageData = companyStore.listCompanies.slice(start, end);

        // Debug current page data
        console.log('Current Page Data:', currentPageData);

        // Navigate to the previous page if current page is empty
        if (currentPageData.length === 0 && pagination.page > 1) {
          pagination.page -= 1;
        }

        // Fetch data again to ensure correct display
        await fetchData();

      } catch (error: any) {
        console.error(t('common.deleteFailed'), error.message);
        message.error(t('common.deleteFailed'));
      } finally {
        deleteDialog.loading = false;
      }
    },
  });
}



function handlePageChange(currentPage: number) {
  pagination.page = currentPage;
  fetchData();
}
</script>

<template>
  <div class="container_dashboard">

    <div class="header_dashboard">
      {{ t('common.companes') }}
    </div>
    <div>
      <div class="flex gap-2 justify-end items-center my-2 mt-8">
        <NSpace vertical>
          <NSpace justify="space-between">

            <NButton
              @click="companyStore.showModelAdd = true"
              type="primary"
            >
              <div class="flex gap-2  items-center">
                <SvgIcon
                  icon="mdi:add-bold"
                  class=" text-base"
                />
                <div class="hidden md:block">{{ t('common.add') }}</div>
              </div>
            </NButton>

            <NButton
              strong
              secondary
              type="error"
              :disabled="checkedRowKeysRef.length > 0 ? false : true"
              @click="deleteSelectedRows"
            >
              <div class="flex gap-2 items-center">
                <SvgIcon
                  icon="fluent:delete-32-regular"
                  class=" text-base"
                />
                <div class="hidden md:block">{{ t('common.delete') }}</div>
              </div>

            </NButton>
          </NSpace>
          <NDataTable
            remote
            :min-height="isMobile ? 380 : 370"
            :max-height="isMobile ? 400 : 370"
            :size="isMobile ? 'small' : 'small'"
            v-model:checked-row-keys="checkedRowKeysRef"
            striped
            :loading="loading"
            :columns="columns"
            :data="data"
            @update:page="handlePageChange"
            :pagination="pagination"
            v-if="!error_get"
            :row-key="rowKey"
            @update:checked-row-keys="handleCheck"
          />
          <NResult
            v-else
            status="warning"
            title="Error"
            description="Error fetching data."
          >
            <template #footer>
              <NButton @click="fetchData">
                {{ t('common.tryAgain') }}
              </NButton>
            </template>
          </NResult>
          <NModal
            v-model:show="companyStore.showModelAdd"
            :mask-closable=false
            :auto-focus="false"
            preset="card"
            style="width: 95%; max-width: 800px;"
          >
            <Add />
          </NModal>
          <NModal
            v-model:show="companyStore.showModelUpdate"
            :mask-closable=false
            :auto-focus="false"
            preset="card"
            style="width: 95%; max-width: 800px;"
          >
            <Update :item="rowEdit!" />
          </NModal>
        </NSpace>
      </div>
    </div>
  </div>
</template>

```

Add.vue
```vue
<script setup lang="ts">
import { ref, computed } from 'vue';
import { NForm, NInput, NButton, FormInst, FormRules, NUpload, NSwitch, useMessage, NGrid, NFormItemGi, UploadCustomRequestOptions } from 'naive-ui';
import { t } from '@/locales';
import { useCompanyStore } from '@/store';
import { supabase } from '@/utils/supabase';
import { useBasicLayout } from '@/hooks/useBasicLayout';
const { isMobile } = useBasicLayout()
const span = computed(() => {
  return isMobile ? 24 : 12
})
const companyStore = useCompanyStore();
const message = useMessage();
const formRef = ref<FormInst | null>(null);
const loading = ref(false);
const model = ref<APIAI.CompanyAI>(companyStore.initState());

const rules: FormRules = {
  name: [{ required: true, message: t('common.nameRequired'), trigger: ['input', 'blur'] }],
  apiUrl: [{ required: true, message: t('common.apiUrlRequired'), trigger: ['input', 'blur'] }]
};



async function handleAddData() {
  try {
    loading.value = true;
    await companyStore.insertDataAction(model.value);
    loading.value = false;
    companyStore.showModelAdd = false;
    message.success(t('common.addSuccess'));
  } catch (error: any) {
    loading.value = false;
    console.error(t('common.addFailed'), error.message);
    message.error(t('common.addFailed'), error.message);
  }
}

const customRequest = async ({ file, data: dataParams, onFinish, onError, onProgress }: UploadCustomRequestOptions) => {
  try {
    if (!dataParams) {
      throw new Error('dataParams is undefined');
    }

    const progressEvent = { loaded: 20, total: 100 };
    const percentCompleted = Math.round((progressEvent.loaded * 100) / progressEvent.total);
    onProgress({ percent: percentCompleted });

    const { data, error } = await supabase.storage.from(dataParams.bucket).upload(`${file.name}`, file.file!, {
      cacheControl: '3600',
      upsert: false
    });

    if (error) {
      if (error.statusCode === "409" && error.error === "Duplicate") {
        
        model.value.logoUrl =file.name;
        onFinish()
      } else {
        throw error;
      }
    }

    if (data) {
      model.value.logoUrl = data.path;
      onFinish();
    }
  } catch (error: any) {
    console.log(error);
    message.error(error.message);
    onError();
  }
};

function isButtonDisabled() {
  return !model.value.name || !model.value.apiUrl || loading.value;
}

function handleValidateButtonClick(e: MouseEvent) {
  e.preventDefault();
  formRef.value?.validate((errors) => {
    if (!errors) {
      handleAddData();
    } else {
      message.error(t('auth.fillAllField'));
    }
  });
}
</script>

<template>
  <div class="border-none shadow-none flex flex-col gap-2 p-2 rounded-lg">
    <div class="post-heading mb-1">
      <div class="gtext text-2xl font-bold underlined">{{ t('common.addNew') }}</div>
    </div>
    <NForm
      ref="formRef"
      :model="model"
      :rules="rules"
      size="large"
    >
      <div>
        <NGrid
          :span="span"
          :x-gap="24"
        >
          <NFormItemGi
            :span="span"
            path="logoUrl"
            :label="t('common.logoUrl')"
          >
            <NUpload
              accept="image/*"
              list-type="image-card"
              :max="1"
              :data="{
             
                'bucket': 'company'
              }"
              path="logoUrl"
              :custom-request="customRequest"
            >
            </NUpload>
          </NFormItemGi>
          <NFormItemGi
            :span="span"
            path="name"
            :label="t('common.name')"
          >
            <NInput
              v-model:value="model.name"
              @keyup.enter="handleValidateButtonClick"
              :placeholder="t('common.name')"
              clearable
              @keydown.enter.prevent
            />
          </NFormItemGi>
          <NFormItemGi
            :span="span"
            path="companyUrl"
            :label="t('common.companyUrl')"
          >
            <NInput
              @keyup.enter="handleValidateButtonClick"
              v-model:value="model.companyUrl"
              :placeholder="t('common.companyUrl')"
              clearable
              @keydown.enter.prevent
            />
          </NFormItemGi>

          <NFormItemGi
            :span="span"
            path="apiUrl"
            :label="t('common.apiUrl')"
          >
            <NInput
              @keyup.enter="handleValidateButtonClick"
              v-model:value="model.apiUrl"
              :placeholder="t('common.apiUrl')"
              clearable
              @keydown.enter.prevent
            />
          </NFormItemGi>
          <NFormItemGi
            :span="span"
            path="isActivate"
            :label="t('common.isActivate')"
          >
            <NSwitch
              v-model:value="model.isActivate"
              size="large"
            />
          </NFormItemGi>
        </NGrid>
      </div>
      <div style="display: flex; justify-content: flex-end">
        <NButton
          type="primary"
          style="width:100%;"
          size="large"
          :loading="loading"
          :disabled="isButtonDisabled()"
          @click="handleValidateButtonClick"
        >
          {{ t('common.addNew') }}
        </NButton>
      </div>
    </NForm>
  </div>
</template>
```

Update.vue
```vue
<script setup lang="ts">
import { ref, computed, defineProps } from 'vue';
import { NForm, NInput, NButton, FormInst, FormRules, NUpload, NSwitch, useMessage, NGrid, NFormItemGi, UploadCustomRequestOptions, UploadFileInfo } from 'naive-ui';
import { t } from '@/locales';
import { useCompanyStore } from '@/store';
import { supabase } from '@/utils/supabase';
import { useBasicLayout } from '@/hooks/useBasicLayout';

const props = defineProps<{ item: APIAI.CompanyAI }>();

const { isMobile } = useBasicLayout();
const span = computed(() => (isMobile ? 24 : 12));

const companyStore = useCompanyStore();
const message = useMessage();
const formRef = ref<FormInst | null>(null);
const loading = ref(false);
const originalModel = ref<APIAI.CompanyAI>({ ...props.item });
const model = ref<APIAI.CompanyAI>({ ...props.item });

const rules: FormRules = {
  name: [{ required: true, message: t('common.nameRequired'), trigger: ['input', 'blur'] }],
  apiUrl: [{ required: true, message: t('common.apiUrlRequired'), trigger: ['input', 'blur'] }]
};

const customRequest = async ({ file, data: dataParams, onFinish, onError, onProgress }: UploadCustomRequestOptions) => {
  try {
    if (!dataParams) {
      throw new Error('dataParams is undefined');
    }

    const progressEvent = { loaded: 20, total: 100 };
    const percentCompleted = Math.round((progressEvent.loaded * 100) / progressEvent.total);
    onProgress({ percent: percentCompleted });

    const { data, error } = await supabase.storage.from(dataParams.bucket).upload(`${file.name}`, file.file!, {
      cacheControl: '3600',
      upsert: false
    });

    if (error) {
      if (error.statusCode === "409" && error.error === "Duplicate") {
        
        model.value.logoUrl = file.name;
        onFinish()
      } else {
        throw error;
      }
    }

    if (data) {
      model.value.logoUrl = data.path;
      onFinish();
    }
  } catch (error: any) {
    console.log(error);
    message.error(error.message);
    onError();
  }
};

const isButtonDisabled = computed(() => {
  return loading.value || !model.value.name || !model.value.apiUrl || JSON.stringify(model.value) === JSON.stringify(originalModel.value);
});



const previewFileList = ref<UploadFileInfo[]>([
    {
        id: '',
        name: model.value.logoUrl ?? '',
        status: 'finished',
        url: model.value.logoUrl
    },
])

async function handleUpdateData() {
  try {
    loading.value = true;

    await companyStore.updateDataAction(model.value);
    loading.value = false;
    companyStore.showModelUpdate = false;
    message.success(t('common.updateSuccess'));
  } catch (error: any) {
    loading.value = false;
    console.error(t('common.updateFailed'), error.message);
    message.error(t('common.updateFailed'), error.message);
  }
}

function handleValidateButtonClick(e: MouseEvent) {
  e.preventDefault();
  formRef.value?.validate((errors) => {
    if (!errors) {
      handleUpdateData();
    } else {
      message.error(t('auth.fillAllField'));
    }
  });
}
</script>

<template>
  <div class="border-none shadow-none flex flex-col gap-2 p-2 rounded-lg">
    <div class="post-heading mb-1">
      <div class="gtext text-2xl font-bold underlined">{{ t('common.update') }}</div>
    </div>
    <NForm
      ref="formRef"
      :model="model"
      :rules="rules"
      size="large"
    >
      <div>
        <NGrid
          :span="span"
          :x-gap="24"
        >
          <NFormItemGi
            :span="span"
            path="logoUrl"
            :label="t('common.logoUrl')"
          >
            <NUpload
              accept="image/*"
              list-type="image-card"
              :max="1"
              path="logoUrl"
              :data="{
             
             'bucket': 'company'
           }"
              :default-file-list="previewFileList"
              :custom-request="customRequest"
            >
            </NUpload>
          </NFormItemGi>
          <NFormItemGi
            :span="span"
            path="name"
            :label="t('common.name')"
          >
            <NInput
              v-model:value="model.name"
              :placeholder="t('common.name')"
              clearable
              @keydown.enter.prevent
            />
          </NFormItemGi>
          <NFormItemGi
            :span="span"
            path="companyUrl"
            :label="t('common.companyUrl')"
          >
            <NInput
              v-model:value="model.companyUrl"
              :placeholder="t('common.companyUrl')"
              clearable
              @keydown.enter.prevent
            />
          </NFormItemGi>
          <NFormItemGi
            :span="span"
            path="apiUrl"
            :label="t('common.apiUrl')"
          >
            <NInput
              v-model:value="model.apiUrl"
              :placeholder="t('common.apiUrl')"
              clearable
              @keydown.enter.prevent
            />
          </NFormItemGi>
          <NFormItemGi
            :span="span"
            path="isActivate"
            :label="t('common.isActivate')"
          >
            <NSwitch
              v-model:value="model.isActivate"
              size="large"
            />
          </NFormItemGi>
        </NGrid>
      </div>
      <div style="display: flex; justify-content: flex-end">
        <NButton
          type="primary"
          style="width:100%;"
          size="large"
          :loading="loading"
          :disabled="isButtonDisabled"
          @click="handleValidateButtonClick"
        >
          {{ t('common.update') }}
        </NButton>
      </div>
    </NForm>
  </div>
</template>



```