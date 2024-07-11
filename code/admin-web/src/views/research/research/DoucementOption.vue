<script setup lang='ts'>
import { ref, h, onMounted, computed, defineAsyncComponent, reactive, defineComponent, render } from 'vue'
import { NGi, NButton, NGrid, NCheckbox, useDialog, useMessage, NCheckboxGroup, NTooltip, DataTableColumns } from 'naive-ui'
import { useResearchStore } from '@/store'
import { t } from '@/locales';
import { useIconRender } from '@/hooks/useIconRender'
import { useBasicLayout } from '@/hooks/useBasicLayout';
import { SvgIcon } from '@/components/common';
const { iconRender } = useIconRender()
const loadingActionDelete = ref(false)
const loadingActionEdit = ref(false)
const loading = ref(true)
const researchStore = useResearchStore()
const checkedRowKeysRef = ref<Array<string | number>>([])
const { isMobile } = useBasicLayout()
const show = ref(false)
const showEdit = ref(false)

const dialog = useDialog()
const message = useMessage();

const doc_options = computed(() => researchStore.$state.current_re_state.doc_options)
</script>

<template>
    <div class="flex flex-col gap-2">
        <!-- <div class="font-bold text-lg">{{ t('re.docOptions') }}</div> -->

        <NGrid
            :y-gap="8"
            :cols="isMobile ? 1 : 2"
        >
            <NGi>
                <NCheckbox
                    v-model:checked="doc_options.is_border"
                    :label="t('re.border')"
                  
                />
            </NGi>
            <NGi>
        <NCheckbox
          v-model:checked="doc_options.is_cover"
          :label="t('re.isCover')"
        
        />
      </NGi>
      <NGi>
        <NCheckbox
          v-model:checked="doc_options.is_page_number"
          :label="t('re.isPageNumber')"
        
        />
      </NGi>
      <NGi>
        <NCheckbox
          v-model:checked="doc_options.is_index"
          :label="t('re.isIndex')"
        
        />
      </NGi>
        </NGrid>

</div></template>
  

