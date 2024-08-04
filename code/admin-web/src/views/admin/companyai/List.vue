<script setup lang='ts'>
import { ref, h, onMounted, computed, reactive } from 'vue'
import {
  NSpace, NButton, NDataTable, DataTableBaseColumn,
  useDialog, NEmpty, NResult,
  DataTableRowKey, NModal,
  useMessage, DataTableFilterState, DataTableColumns,
  NA,
  NText,
  NImage,
  NSwitch,
} from 'naive-ui'
import { useCompanyStore } from '@/store'
import { t } from '@/locales';
import { useIconRender } from '@/hooks/useIconRender'
import { useBasicLayout } from '@/hooks/useBasicLayout';
// import Card from './Card.vue'
// import { FilterTable } from './components/index'
import { SvgIcon } from '@/components/common';
import Add from './Add.vue'
// import Update from './Update.vue'

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
const data = computed(() => companyStore.listCompanies)
const pageSize: number = 10
const pages = computed(() => companyStore.countTotalData)
const pagination = reactive({
  page: pages!,
  pageSize: pageSize,
  showSizePicker: true,
  onChange: (page: number) => {
    pagination.page = page
  },
  onUpdatePageSize: (pageSize: number) => {
    pagination.pageSize = pageSize
    pagination.page = 1
  }
})
function handleDeleteAction(row: APIAI.CompanyAI) {
  const deleteDialog = dialog.warning({
    title: t('chat.deleteConfirmation'),
    content: t('chat.deleteConfirmationMessage'),
    positiveText: t('common.yes'),
    negativeText: t('common.no'),
    onPositiveClick: async () => {
      try {
        deleteDialog.loading = true
        await companyStore.deleteDataAction(row.id!)
        message.success(t('chat.deleteSuccess'));
      } catch (error: any) {
        deleteDialog.loading = false
        message.error(t('chat.deleteFailed'));
      } finally {
        deleteDialog.loading = false
      }
    },
  });
}

async function handleUpdate(row: APIAI.CompanyAI) {
  companyStore.showModelUpdate = true;
  rowEdit.value = row;
}


const mainColumns = reactive<DataTableBaseColumn<APIAI.CompanyAI>[]>([
  {
    title: t('common.name'),
    key: 'name',
    render(row: APIAI.CompanyAI) {
      return h(NText, { strong: true }, { default: () => row.name });
    }
  },
  {
    title: t('common.companyUrl'),
    key: 'companyUrl',
    render(row: APIAI.CompanyAI) {
      return row.companyUrl ? h(NA, { href: row.companyUrl, target: '_blank' }, { default: () => row.companyUrl }) : null;
    }
  },
  {
    title: t('common.logoUrl'),
    key: 'logoUrl',
    render(row: APIAI.CompanyAI) {
      return row.logoUrl ? h(NImage, { src: row.logoUrl, alt: `${row.name} logo`, width: 50 }) : null;
    }
  },
  {
    title: t('common.apiUrl'),
    key: 'apiUrl',
    render(row: APIAI.CompanyAI) {
      return h(NText, { type: 'info' }, { default: () => row.apiUrl });
    }
  },
  {
    title: t('common.isActivate'),
    key: 'isActivate',
    render(row: APIAI.CompanyAI) {
      return h(NSwitch, { value: row.isActivate, disabled: true });
    }
  },
  {
    title: t('common.createdAt'),
    key: 'createdAt',
    render(row: APIAI.CompanyAI) {
      return h(NText, {}, { default: () => new Date(row.createdAt).toLocaleString() });
    }
  },
  {
    title: t('common.updatedAt'),
    key: 'updatedAt',
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

async function initData(): Promise<void> {
  try {
    loading.value = true
    await companyStore.countTotalDataAction()
    await companyStore.fetchDataAction({
      limit: pageSize,
      offset: 0,
    })
  } catch (error: any) {
    error_get.value = true
    console.error(t('chat.dataFetchError'), error.message)
  } finally {
    loading.value = false
  }
}

onMounted(async () => {
  console.log("hh")
  await initData()
})

function deleteSelectedRows() {
  const deleteDialog = dialog.warning({
    title: t('chat.deleteConfirmation'),
    content: t('chat.deleteConfirmationMessage'),
    positiveText: t('common.yes'),
    negativeText: t('common.no'),
    onPositiveClick: async () => {
      try {
        deleteDialog.loading = true;
        const deletePromises = checkedRowKeysRef.value.map((id) =>
          companyStore.deleteDataAction(id)
        );
        await Promise.all(deletePromises);
        message.success(t('chat.deleteSuccess'));
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
      {{ t('common.companes') }}
    </div>
    <div>
      <div class="flex gap-2 justify-end items-center my-2 mt-8">
        <NSpace vertical>
          <NSpace justify="space-between">

            <NButton @click="companyStore.showModelAdd = true" type="primary">
              <div class="flex gap-2  items-center">
                <SvgIcon icon="mdi:add-bold" class=" text-base" />
                <div class="hidden md:block">{{ t('common.add') }}</div>
              </div>
            </NButton>

            <NButton strong secondary type="error" :disabled="checkedRowKeysRef.length > 0 ? false : true"
              @click="deleteSelectedRows">
              <div class="flex gap-2 items-center">
                <SvgIcon icon="fluent:delete-32-regular" class=" text-base" />
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
          :loading="loading" :columns="columns" :data="data" :pagination="pagination" v-if="!error_get" />
          <NResult v-else status="warning" title="Error" description="Error fetching data.">
            <template #footer>
              <NButton @click="initData">
                {{ t('common.tryAgain') }}
              </NButton>
            </template>
          </NResult>
          <NModal v-model:show="companyStore.showModelAdd" :mask-closable=false :auto-focus="false" preset="card"
          style="width: 95%; max-width: 800px;">
            <Add />
          </NModal>
          <!--  <NModal v-model:show="companyStore.showModelUpdate" preset="dialog">
        <Update :rowEdit="rowEdit" />
      </NModal> -->
        </NSpace>
      </div>
    </div>
  </div>
</template>
