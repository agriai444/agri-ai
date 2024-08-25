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
    },
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
    title: t('common.apiKey'),
    key: 'apiKey',
    align: 'center',
    render(row: APIAI.CompanyAI) {
      return h(NText, { type: 'info' }, { default: () => row.apiKey });
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
            v-model:show="companyStore.showModelAdd"
            :mask-closable=false
            :auto-focus="false"
            preset="card"
            style="width: 95%; max-width: 800px;"
          >
            <Add/>
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
