<script setup lang="ts">
import { ref, computed, reactive, onMounted, h } from 'vue';
import { PropType } from 'vue';
import {
  NSpace, NButton, NDataTable, NResult,
  DataTableColumns, DataTableRowKey,
  useDialog, NModal,
  useMessage,
  DataTableBaseColumn
} from 'naive-ui';
import { useBasicLayout } from '@/hooks/useBasicLayout';
import { SvgIcon } from '@/components/common';
import { t } from '@/locales';
import { useIconRender } from '@/hooks/useIconRender';


const action = reactive<DataTableColumns<T>>([
  {
    title: t('common.actions'),
    key: 'actions',
    width:100,
 align:'center',
    render(row: T) {
      return h(
        'div',
        { class: 'flex gap-1' },
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
                  handleDeleteAction(row);
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
// Define the generic type T
const props = defineProps<{
  title: string;
  columns: DataTableBaseColumn<T>[];
  modelStore: {
    countTotalData: number;
    listData: Array<T>;
    fetchDataAction: (params: { limit: number; offset: number }) => Promise<void>;
    deleteDataAction: (id: string) => Promise<void>;
    showModelAdd: boolean;
    showModelUpdate: boolean;
  };
  Add: typeof import('vue');
  Update: typeof import('vue');
}>();

const columns = reactive<DataTableBaseColumn<T>[]>([
  {
    type: 'selection',

  },
 ...props.columns,
  ...action
]);
const { iconRender } = useIconRender();
const { isMobile } = useBasicLayout();
const checkedRowKeys = ref<DataTableRowKey[]>([]);
const loadingActionDelete = ref(false);
const loadingActionEdit = ref(false);
const loading = ref(true);
const error = ref<boolean>(false);
const checkedRowKeysRef = ref<Array<string | number>>([]);
const dialog = useDialog();
const message = useMessage();
const rowEdit = ref<T | null>(null);

const modelStore = props.modelStore;
const pageSize = ref(10);
const pagination = reactive({
  page: 1,
  pageCount: computed(() => Math.ceil(modelStore.countTotalData / pageSize.value)),
  pageSize: pageSize.value
});

const data = computed(() => {
  const start = (pagination.page - 1) * pagination.pageSize;
  const end = start + pagination.pageSize;
  return modelStore.listData.slice(start, end);
});

// Handle update
async function handleUpdate(row: T) {
  modelStore.showModelUpdate = true;
  rowEdit.value = row;
}

// Row key function
const rowKey = (row: T) => (row as any).id!;

// Handle delete action for a single row
function handleDeleteAction(row: T) {
  const deleteDialog = dialog.warning({
    title: t('common.deleteConfirmation'),
    content: t('common.deleteConfirmationMessage'),
    positiveText: t('common.yes'),
    negativeText: t('common.no'),
    onPositiveClick: async () => {
      try {
        deleteDialog.loading = true;
        await modelStore.deleteDataAction((row as any).id);
        message.success(t('common.deleteSuccess'));

        // Adjust pagination if needed
        const start = (pagination.page - 1) * pagination.pageSize;
        const end = start + pagination.pageSize;
        const currentPageData = modelStore.listData.slice(start, end);
        if (currentPageData.length === 0 && pagination.page > 1) {
          pagination.page -= 1;
        }

        await fetchData();
      } catch (error: any) {
        deleteDialog.loading = false;
        message.error(t('common.deleteFailed'));
      } finally {
        deleteDialog.loading = false;
      }
    }
  });
}

// Handle page change
function handlePageChange(currentPage: number) {
  pagination.page = currentPage;
  fetchData();
}

// Handle checked row keys
function handleCheck(rowKeys: DataTableRowKey[]) {
  checkedRowKeysRef.value = rowKeys;
}

// Delete selected rows
function deleteSelectedRows() {
  const deleteDialog = dialog.warning({
    title: t('common.deleteConfirmation'),
    content: t('common.deleteConfirmationMessage'),
    positiveText: t('common.yes'),
    negativeText: t('common.no'),
    onPositiveClick: async () => {
      try {
        deleteDialog.loading = true;
        const deletePromises = checkedRowKeysRef.value.map(id => modelStore.deleteDataAction(String(id)));
        await Promise.all(deletePromises);
        message.success(t('common.deleteSuccess'));

        // Adjust pagination after deletion
        const start = (pagination.page - 1) * pagination.pageSize;
        const end = start + pagination.pageSize;
        const currentPageData = modelStore.listData.slice(start, end);
        if (currentPageData.length === 0 && pagination.page > 1) {
          pagination.page -= 1;
        }

        await fetchData();
      } catch (error: any) {
        console.error(t('common.deleteFailed'), error.message);
        message.error(t('common.deleteFailed'));
      } finally {
        deleteDialog.loading = false;
      }
    }
  });
}

async function fetchData(): Promise<void> {
  try {
    loading.value = true;
    const { page, pageSize } = pagination;
    await modelStore.fetchDataAction({ limit: pageSize, offset: (page - 1) * pageSize });
  } catch (error: any) {
    error.value = true;
    console.error(t('chat.dataFetchError'), error.message);
  } finally {
    loading.value = false;
  }
}

onMounted(async () => {
  await fetchData();
});
</script>


<template>
  <div class="container_dashboard">
    <div class="header_dashboard">
      {{ title }}
    </div>
    <div>
      <div class="flex gap-2 justify-end items-center my-2 mt-8">
       <div class="w-full flex flex-col gap-1">
          <div class="flex gap-4 items-center justify-end">
            <NButton @click="modelStore.showModelAdd = true" type="primary">
              <div class="flex gap-2 items-center">
                <SvgIcon icon="mdi:add-bold" class="text-base" />
                <div class="hidden md:block">{{ t('common.add') }}</div>
              </div>
            </NButton>

            <NButton
              strong
              secondary
              type="error"
              :disabled="checkedRowKeys.length === 0"
              @click="deleteSelectedRows"
            >
              <div class="flex gap-2 items-center">
                <SvgIcon icon="fluent:delete-32-regular" class="text-base" />
                <div class="hidden md:block">{{ t('common.delete') }}</div>
              </div>
            </NButton>
          </div>
          <NDataTable
            remote
            :min-height="isMobile ? 380 : 540"
            :max-height="isMobile ? 400 : 700"
           
            :size="isMobile ? 'small' : 'small'"
            v-model:checked-row-keys="checkedRowKeys"
            striped
            :loading="loading"
            :columns="columns"
            :data="data"
            @update:page="handlePageChange"
            :pagination="pagination"
            v-if="!error"
            :row-key="rowKey"
:maxWidth="200"
    :scroll-x="700"
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
        </div>
      </div>
    </div>
  </div>

  <NModal
    v-model:show="modelStore.showModelAdd"
    :mask-closable="false"
    :auto-focus="false"
    preset="card"
    style="width: 95%; max-width: 800px;"
  >
    <component :is="Add" />
  </NModal>

  <NModal
    v-model:show="modelStore.showModelUpdate"
    :mask-closable="false"
    :auto-focus="false"
    preset="card"
    style="width: 95%; max-width: 800px;"
  >
    <component :is="Update" :item="rowEdit!" />
  </NModal>
</template>