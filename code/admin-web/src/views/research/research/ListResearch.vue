<script setup lang='ts'>
import { ref, h, onMounted, computed, defineAsyncComponent, reactive, defineComponent, render } from 'vue'
import { NSpace, NButton, NDataTable, NAvatar, useDialog, useMessage, NBadge, NTooltip, DataTableColumns, NGradientText } from 'naive-ui'
import { useResearchStore} from '@/store'
import { t } from '@/locales';
import { useIconRender } from '@/hooks/useIconRender'
import { supabaseUrlImage } from '@/utils/supabase';
import { useBasicLayout } from '@/hooks/useBasicLayout';
import { SvgIcon } from '@/components/common';
import { Filter } from 'naive-ui/es/data-table/src/interface';
import {AvatarGroup, State, Process , CardResearch} from './components/index'
const { iconRender } = useIconRender()
const loadingActionDelete = ref(false)
const loadingActionEdit = ref(false)
const loading = ref(true)
const researchStore = useResearchStore()
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
function handleDeleteAction(row: Research.Research) {
  const deleteDialog = dialog.warning({
    title: t('chat.deleteConfirmation'),
    content: t('chat.deleteConfirmationMessage'),
    positiveText: t('common.yes'),
    negativeText: t('common.no'),
    onPositiveClick: async () => {
      try {
        deleteDialog.loading = true
        await researchStore.deleteUniversityAction(row.id!)
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
const rowEdit = ref<Research.Research | null>(null);
async function handleUpdateUniversity(row: Research.Research) {
  // Assuming showEdit is a ref or reactive variable
  showEdit.value = true;
  rowEdit.value = row;
}

const bucket = 'research';

function createTooltipContent(row: Research.Research): string {

  // const tooltipContent = `
  // Additional information about ${row.name} 
  //   Created At: ${row.created_at}
  //   Updated At: ${row.updated_at}
  // `;

  const tooltipContent = `
  Updated At: ${new Date(row.updated_at as unknown as string).toLocaleString()}
  `;
  return tooltipContent;
}

const pagination = ref({
  pageSize: isMobile ? 20 : 20,
});

const customFilter: Filter<Research.Research> = (value, row) => {
  
  return row.state.indexOf(String(value)) !== -1;
};
const columns = reactive<DataTableColumns<Research.Research>>([
  // {
  //   type: 'selection',
  //   options: [
  //     'all',
  //     'none',
  //   ],
  // },
  {
    title: t('re.re') ,
    key: 're',
    className: 're',
    render(row: Research.Research) {
      return h( CardResearch)
    },
    // render(row: Research.Research) {
    //   const avatarProps = {
    //     round: true,
    //     size: 'medium',
    //     src: `${supabaseUrlImage}/${bucket}/${row.id}`,
    //   };

    //   const badgeType = row.is_actvity  ? 'success' : 'error';

    //   return h(
    //     'div',
    //     {
    //       class: 'flex gap-4 item-center'
    //     },
    //     [
    //       h(NBadge,
    //         {
    //           dot: true,
    //           processing: false,
    //           type: badgeType,
    //         },
    //         [
    //           h(NAvatar, avatarProps),
    //         ]
    //       ),

    //       h('div',
    //         { class: 'flex flex-col' }, [
    //         h('div', { class: 'font-bold text-base' }, row.fake_title),
            

    //         h('div', { class: 'flex gap-3  item-end' },
    //           [
    //           h('div', { class: 'text-xs' }, new Date(row.created_at as unknown as string).toLocaleString()),
    //             renderTooltip(
    //       h(
    //         NGradientText,
    //         {
    //           size: 14,
    //           placement:"center",
    //           type: 'danger'
    //         },
    //         { default: () => h(iconRender({ icon: 'ep:info-filled', color: 'black' })) }
    //       ),
    //      createTooltipContent(row) 
    //     )
    //           ]
    //         ),
          
    //       ]
    //       )
    //     ]
    //   );
    // },
    sortOrder: false,
  sorter: 'default',
  filterMultiple: true,
 
    filterOptions: [
      {
        label: 'pinding',
        value: 'pinding'
      },
      {
        label: 'Complete',
        value: 'Complete'
      },
    ],
    filter: customFilter,
 


  },
  // {
  //   title:  t('research.students') ,
  //   key: 'avater',
  //   align:'center',
  //   render(row: Research.Research) {
  //     return h(
  //       AvatarGroup,
  //     )
  //   }
  // },
  // {
  //   title:  t('research.process') ,
  //   key: 'avater',
  //   align:'center',
  //   render(row: Research.Research) {
  //     return h(
  //       Process,
  //     )
  //   }
  // },
  // {
  //   title:  t('research.state') ,
  //   key: 'avater',
  //   align:'center',
  //   render(row: Research.Research) {
  //     return h(
  //       State,
  //     )
  //   }
  // },
  // {
  //   title:  t('research.actions') ,
  //   key: 'actions',
  //   align:'center',
  //   width:100,
  //   render(row: Research.Research) {
  //     return h(
  //       'div',
  //       {
  //         class: 'flex gap-1'
  //       },
  //       [
  //         h(
  //           NButton,
  //           {
  //             strong: true,
  //             tertiary: true,
  //             size: 'small',
  //             loading: loadingActionEdit.value,
  //             onClick: async () => {
  //               try {
  //                 await handleUpdateUniversity(row);
  //               } catch (error: any) {

  //                 console.error('Error updating university:', error.message);
  //               }
  //             }
  //           },
  //           { default: () => h(iconRender({ icon: 'fluent:edit-32-regular', color: 'blue' })) }
  //         ),

  //         h(
  //           NButton,
  //           {
  //             strong: true,
  //             tertiary: true,
  //             size: 'small',
  //             loading: loadingActionDelete.value,
  //             onClick: () => handleDeleteAction(row)
  //           },
  //           { default: () => h(iconRender({ icon: 'fluent:delete-32-regular', color: 'red' })) }
  //         ),

  //       ]
  //     );
  //   }
  // },

]);


// async function getDataAsync() {
//   try {
//     const result = await researchStore.fetchUniversitiesAction();
//     loading.value = false

//     return result;
//   } catch (error: any) {
//     console.error('Error fetching data:', error.message);
//     loading.value = false
//     throw error;
//   }
// }


const data = computed(() => {
  return researchStore.$state.list_re_state.map(item => item.re_info);
});

onMounted(() => {
  console.log(researchStore.$state.list_re_state.map(item => item.re_info))
  loading.value = false
//   getDataAsync();
})
const dataTableInstRef = ref(null)

const dataTableInst = dataTableInstRef

const nameColumnReactive = reactive(columns[1])
const columnsRef = ref(columns)
function sortName (order) {
  console.log(nameColumnReactive)
        nameColumnReactive.sortOrder = order
        console.log(nameColumnReactive)
 }

 function  handleSorterChange (sorter: { columnKey: any; order: any; }) {
  console.log(sorter,"sorter")
        columnsRef.value.forEach((column) => {
          /** column.sortOrder !== undefined means it is uncontrolled */
          console.log("column",column)
          if (column.sortOrder === undefined) return
          if (!sorter) {
            column.sortOrder = false
            return
          }
          if (column.key === sorter.columnKey) column.sortOrder = sorter.order
          else column.sortOrder = false
        })
      }
    


</script>

<style scoped>

:deep(th) {
  color: rgba(0, 0, 128, 0.75) !important;
  font-size:medium;
  font-weight:bolder;
}
</style>
<template>
  <div class="container_dashboard">
    <div class="h_table">
      <div class="header_dashboard">
     {{ t('re.research') }}
      </div>
      <NButton
        @click="show = true"
        type="primary"
        class="text-xl text-white  font-semibold bg-primary px-2 w-44 rounded-full"
      >
        {{ t('re.addResearch') }}
      </NButton>

    </div>
    <div class="">

      <NSpace
        vertical
        :size="12"
      >
        <NSpace>
        </NSpace>
        <!-- <NDataTable
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
        /> -->
        <CardResearch/>
      </NSpace>
    </div>
  </div>

  <div>
 
  </div>
</template>
  
