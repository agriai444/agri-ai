<script setup lang='ts'>
import { ref, h, onMounted, computed, reactive } from 'vue';
import {
  NSpace, NButton, NDataTable, DataTableBaseColumn,
  useDialog, NResult, NModal, useMessage, DataTableColumns,
  NA, NText, NSwitch, NAvatar,
  DataTableRowKey
} from 'naive-ui';
import { useModelStore } from '@/store';
import { t } from '@/locales';
import { useIconRender } from '@/hooks/useIconRender';
import { useBasicLayout } from '@/hooks/useBasicLayout';
import { SvgIcon } from '@/components/common';
import Add from './Add.vue';
import Update from './Update.vue';
import Card from './Card.vue'
import { getImageUrl } from '@/utils/supabasehelper';

const { iconRender } = useIconRender();
const loadingActionDelete = ref(false);
const loadingActionEdit = ref(false);
const loading = ref(true);
const error_get = ref<boolean>(false);
const modelStore = useModelStore();

const checkedRowKeysRef = ref<Array<string | number>>([]);
const { isMobile } = useBasicLayout();
const dialog = useDialog();
const message = useMessage();
const rowEdit = ref<APIAI.ModelAI | null>(null);

// Compute the data for the current page
const data = computed(() => {
  const start = (pagination.page - 1) * pagination.pageSize;
  const end = start + pagination.pageSize;
  return modelStore.listModels.slice(start, end);
});

const pageSize = ref(10);
const itemCount = computed(() => modelStore.countTotalData);
const pagination = reactive({
  page: 1,
  pageCount: computed(() => Math.ceil(itemCount.value / pageSize.value)),
  pageSize: pageSize.value,
});

async function handleUpdate(row: APIAI.ModelAI) {
  modelStore.showModelUpdate = true;
  rowEdit.value = row;
}

const cardColumn = reactive<DataTableBaseColumn<APIAI.ModelAI>>({
  title: t('common.company'),
  key: 'company',
  render(row: APIAI.ModelAI) {
    return h(
      Card,
      {
        companyId: row.companyId
      },
    )
  },
})
const mainColumns = reactive<DataTableBaseColumn<APIAI.ModelAI>[]>([
  {
    title: t('common.name'),
    key: 'name',
    align: 'center',
    render(row: APIAI.ModelAI) {
      return h(NText, { strong: true }, { default: () => row.name });
    }
  },
  {
    title: t('common.modelCode'),
    key: 'modelCode',
    align: 'center',
    render(row: APIAI.ModelAI) {
      return h(NText, { type: 'info' }, { default: () => row.modelCode });
    },
    ellipsis: true
  },

  {
    title: t('common.description'),
    key: 'description',
    align: 'center',
    render(row: APIAI.ModelAI) {
      return h(NText, {}, { default: () => row.description || 'N/A' });
    },
    ellipsis: true
  },
  {
    title: t('common.version'),
    key: 'version',
    align: 'center',
    render(row: APIAI.ModelAI) {
      return h(NText, {}, { default: () => row.version || 'N/A' });
    },
    ellipsis: true
  },
  {
    title: t('common.isActivate'),
    key: 'isActivate',
    align: 'center',
    render(row: APIAI.ModelAI) {
      return h(NSwitch, { value: row.isActivate, disabled: true });
    }
  },
  {
    title: t('common.createdAt'),
    key: 'createdAt',
    align: 'center',
    render(row: APIAI.ModelAI) {
      return h(NText, {}, { default: () => new Date(row.createdAt).toLocaleString() });
    }
  },
  {
    title: t('common.updatedAt'),
    key: 'updatedAt',
    align: 'center',
    render(row: APIAI.ModelAI) {
      return h(NText, {}, { default: () => new Date(row.updatedAt).toLocaleString() });
    }
  }
]);


const columns = reactive<DataTableColumns<APIAI.ModelAI>>([
  {
    type: 'selection',
  },
  cardColumn,
  ...mainColumns,

  {
    title: t('common.actions'),
    key: 'actions',
    align: 'center',
    width: 100,
    render(row: APIAI.ModelAI) {
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

async function fetchData(): Promise<void> {
  try {
    loading.value = true;
    const { page, pageSize } = pagination;
    await modelStore.fetchDataAction({ limit: pageSize, offset: (page - 1) * pageSize });
   
  } catch (error: any) {
    error_get.value = true;
    console.error(t('chat.dataFetchError'), error.message);
  } finally {
    loading.value = false;
  }
}

onMounted(async () => {
  await fetchData();
});
const rowKey = (row: APIAI.ModelAI) => row.id!;

function handleDeleteAction(row: APIAI.ModelAI) {
  const deleteDialog = dialog.warning({
    title: t('common.deleteConfirmation'),
    content: t('common.deleteConfirmationMessage'),
    positiveText: t('common.yes'),
    negativeText: t('common.no'),
    onPositiveClick: async () => {
      try {
        deleteDialog.loading = true;
        await modelStore.deleteDataAction(row.id);
        message.success(t('common.deleteSuccess'));

        // Check if the current page is empty after deletion
        const start = (pagination.page - 1) * pagination.pageSize;
        const end = start + pagination.pageSize;
        const currentPageData = modelStore.listModels.slice(start, end);

        // If current page is empty and it is not the first page, navigate to the previous page
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
    },
  });
}

function handlePageChange(currentPage: number) {
  pagination.page = currentPage;
  fetchData();
}

function handleCheck(rowKeys: DataTableRowKey[]) {
  checkedRowKeysRef.value = rowKeys;
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

        // Convert IDs to string if necessary
        const deletePromises = checkedRowKeysRef.value.map(id => modelStore.deleteDataAction(String(id)));
        await Promise.all(deletePromises);
        message.success(t('common.deleteSuccess'));

        // Fetch data after deletion
        await fetchData();

        const start = (pagination.page - 1) * pagination.pageSize;
        const end = start + pagination.pageSize;
        const currentPageData = modelStore.listModels.slice(start, end);

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
</script>

<template>
  <div class="container_dashboard">
    <div class="header_dashboard">
      {{ t('common.models') }}
    </div>
    <div>
      <div class="flex gap-2 justify-end items-center my-2 mt-8">
        <NSpace vertical>
          <NSpace justify="space-between">
            <NButton
              @click="modelStore.showModelAdd = true"
              type="primary"
            >
              <div class="flex gap-2 items-center">
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
           :min-height="isMobile ? 380 : 540"
            :max-height="isMobile ? 400 : 700"
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
            v-model:show="modelStore.showModelAdd"
            :mask-closable="false"
            :auto-focus="false"
            preset="card"
            style="width: 95%; max-width: 800px;"
          >
            <Add />
          </NModal>
          <NModal
            v-model:show="modelStore.showModelUpdate"
            :mask-closable="false"
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
