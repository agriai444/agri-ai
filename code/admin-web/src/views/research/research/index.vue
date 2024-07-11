<script setup lang='ts'>
import { ref, h, onMounted, computed, defineAsyncComponent, reactive, defineComponent, render } from 'vue'
import { NCollapse, NButton, NCollapseItem, NAvatar, useDialog, useMessage, NBadge, NTooltip, DataTableColumns } from 'naive-ui'
import { useUniversityStore } from '@/store'
import { t } from '@/locales';
import { useIconRender } from '@/hooks/useIconRender'
import { TableColumns } from 'naive-ui/es/data-table/src/interface';
import { supabaseUrl } from '@/utils/supabase';
import { useBasicLayout } from '@/hooks/useBasicLayout';
import { SvgIcon } from '@/components/common';
import Row from 'naive-ui/es/legacy-grid/src/Row';

import DoucementOption from './DoucementOption.vue'
import CoverOptions from './CoverOptions.vue'
import AddResearch from './AddResearch.vue'
import ListResearch from './ListResearch.vue'
const { iconRender } = useIconRender()
const loadingActionDelete = ref(false)
const loadingActionEdit = ref(false)
const loading = ref(true)
const universityStore = useUniversityStore()
const checkedRowKeysRef = ref<Array<string | number>>([])
const { isMobile } = useBasicLayout()
const show = ref(false)
const showEdit = ref(false)

const dialog = useDialog()
const message = useMessage();

</script>

<template>







  <!-- <ListResearch/> -->
  <!-- <div class="container_dashboard  relative h-[85%]">
    <div class="font-bold text-2xl text-primary my-4">Generation research</div>
    <div class=" bg-green-100 p-4  rounded-lg shadow-sm">
      <NCollapse>
        <NCollapseItem
          :title="t('re.docOptions')"
          name="1"
        >
          <div class="pl-8">
            <DoucementOption />
          </div>
        </NCollapseItem>

        <NCollapseItem
          :title="t('re.coverOptions')"
          name="2"
        >
          <div class="pl-8">
            <CoverOptions />
          </div>

        </NCollapseItem>
      </NCollapse>

    </div>
    <div class=" rounded-full bg-blue-900 w-14 h-14 flex justify-center items-center  absolute bottom-0 right-0">
      <SvgIcon
        icon="mdi:printer-preview"
        class="text-3xl text-white"
    />
  </div>


  <AddResearch/> 
</div>
-->
</template>
  
