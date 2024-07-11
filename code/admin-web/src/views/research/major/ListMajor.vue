<script setup lang='ts'>
import { ref, h, onMounted, computed, defineAsyncComponent, reactive } from 'vue'
import { useMessage,useDialog, NSpace, NButton, NDataTable, NBadge, NTooltip, DataTableColumns, NGradientText } from 'naive-ui'
import { useMajorStore } from '@/store'
import { t } from '@/locales';
import { useIconRender } from '@/hooks/useIconRender'
import { useBasicLayout } from '@/hooks/useBasicLayout';
import { SvgIcon } from '@/components/common';

const AddMajor = defineAsyncComponent(() => import('./AddMajor.vue'))
const EditMajor = defineAsyncComponent(() => import('./EditMajor.vue'))

const { iconRender } = useIconRender()
const loadingActionDelete = ref(false)
const loadingActionEdit = ref(false)
const loading = ref(true)
const majorStore = useMajorStore()
const checkedRowKeysRef = ref<Array<string | number>>([])
const { isMobile } = useBasicLayout()
const show = ref(false)
const showEdit = ref(false)

const renderTooltip = (trigger, content) => {
  return h(NTooltip, null, {
    trigger: () => trigger,
    default: () => content
  })
}
const dialog = useDialog()
const message = useMessage();
function handleDeleteAction(row: Research.Major) {
  const deleteDialog = dialog.warning({
    title: t('chat.deleteConfirmation'),
    content: t('chat.deleteConfirmationMessage'),
    positiveText: t('common.yes'),
    negativeText: t('common.no'),
    onPositiveClick: async () => {
      try {
        deleteDialog.loading = true
        await majorStore.deleteMajorAction(row.id!)
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

const rowEdit = ref<Research.Major | null>(null);

async function handleUpdateMajor(row: Research.Major) {
  showEdit.value = true;
  rowEdit.value = row;
}

const bucket = 'research';

function createTooltipContent(row: Research.Major): string {
  const tooltipContent = `
    Updated At: ${new Date(row.updated_at as unknown as string).toLocaleString()}
  `;
  return tooltipContent;
}

const pagination = ref({
  pageSize: isMobile ? 20 : 20,
});

const columns = reactive<DataTableColumns<Research.Major>>([
  {
    type: 'selection',
    options: [
      'all',
      'none',
    ],
  },
  {
    title: t('major.major'),
    key: 'major',
    className: 'age',
    render(row: Research.Major) {
      const badgeType = row.is_active === 'true' ? 'success' : 'error';

      return h(
        'div',
        {
          class: 'flex gap-4 item-center'
        },
        [
          h(NBadge,
            {
              dot: true,
              processing: false,
              type: badgeType,
            },
            [
              // You can customize this part based on your Major data structure
              h('div', { class: 'text-xs' }, row.name),
              // End of customization
            ]
          ),
          h('div', { class: 'flex gap-3  item-end' },
            [
              h('div', { class: 'text-xs' }, new Date(row.created_at as unknown as string).toLocaleString()),
              renderTooltip(
                h(
                  NGradientText,
                  {
                    size: 14,
                    placement: "center",
                    type: 'danger'
                  },
                  { default: () => h(iconRender({ icon: 'ep:info-filled', color: 'black' })) }
                ),
                createTooltipContent(row)
              )
            ]
          ),
        ]
      );
    },
    sortOrder: false,
  },
  {
    title: t('research.actions'),
    key: 'actions',
    align: 'center',
    width: 100,
    render(row: Research.Major) {
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
              onClick: async () => {
                try {
                  await handleUpdateMajor(row);
                } catch (error: any) {
                  console.error('Error updating major:', error.message);
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
              onClick: () => handleDeleteAction(row)
            },
            { default: () => h(iconRender({ icon: 'fluent:delete-32-regular', color: 'red' })) }
          ),

        ]
      );
    }
  },
]);

async function getDataAsync() {
  try {
    const result = await majorStore.fetchMajorsAction();
    loading.value = false
    return result;
  } catch (error: any) {
    console.error('Error fetching data:', error.message);
    loading.value = false
    throw error;
  }
}

const data = computed(() => majorStore.$state)
onMounted(() => {
  getDataAsync();
})

</script>

<style scoped>

:deep(th) {
  color: rgba(0, 0, 128, 0.75) !important;
  font-size: medium;
  font-weight: bolder;
}

</style>

<template>
  <div class="container_dashboard">
    <div class="h_table">
      <div class="header_dashboard">
        {{ t('major.majors') }}
      </div>
      <NButton
        @click="show = true"
        type="primary"
        class="text-xl text-white  font-semibold bg-primary px-2 w-44 rounded-full"
      >
        {{ t('major.addMajor') }}
      </NButton>
      <AddMajor
        v-if="show"
        v-model:visible="show"
      />
    </div>
    <div class="">
      <NSpace
        vertical
        :size="12"
      >
        <NSpace>
        </NSpace>
        <NDataTable
          :size="isMobile ? 'small' : 'small'"
          striped
          :loading="loading"
          ref="dataTableInst"
          :columns="columns"
          :data="data"
          :pagination="pagination"
          :max-height="isMobile ? 400 : 370"
          :min-height="isMobile ? 380 : 370"
          :paginate-single-page=false
          v-model:checked-row-keys="checkedRowKeysRef"
          @update:sorter="handleSorterChange"
        />
      </NSpace>
    </div>
  </div>

  <div>
    <EditMajor
      v-if="showEdit"
      v-model:visible="showEdit"
      :row="rowEdit"
    />
  </div>
</template>
