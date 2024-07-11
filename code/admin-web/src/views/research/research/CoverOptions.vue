<script setup lang='ts'>
import { ref, h, onMounted, computed, defineAsyncComponent, reactive, defineComponent, render } from 'vue'
import { NGi, NButton, NGrid, NCheckbox, useDialog, useMessage, NCollapse, NCollapseItem, DataTableColumns } from 'naive-ui'
import { useResearchStore } from '@/store'
import { t } from '@/locales';
import { useIconRender } from '@/hooks/useIconRender'
import { useBasicLayout } from '@/hooks/useBasicLayout';
import { SvgIcon } from '@/components/common';
import {AddTitle} from './components/index'
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

const cover_options = computed(() => researchStore.$state.current_re_state.cover_options)
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
          v-model:checked="cover_options.is_name"
          :label="t('re.isName')"
        />
      </NGi>
      <NGi>
        <NCheckbox
          v-model:checked="cover_options.is_title"
          :label="t('re.isTitle')"
        />
        <NCollapse :class="cover_options.is_title ? '' : 'hidden'">
    <NCollapseItem  :title="t('re.docOptions')" name="1">
      <div class="pl-8">
  <AddTitle/>
      </div>
      </NCollapseItem>
      </NCollapse>
      </NGi>
      <NGi>
        <NCheckbox
          v-model:checked="cover_options.is_doctor_name"
          :label="t('re.isDoctorName')"
        />
      </NGi>
      <NGi>
        <NCheckbox
          v-model:checked="cover_options.is_image"
          :label="t('re.isImage')"
        />
      </NGi>
      <NGi>
        <NCheckbox
          v-model:checked="cover_options.is_years"
          :label="t('re.isYears')"
        />
      </NGi>
      <NGi>
        <NCheckbox
          v-model:checked="cover_options.is_header"
          :label="t('re.isHeader')"
        />
      </NGi>
      <NGi>
        <NCheckbox
          v-model:checked="cover_options.is_footer"
          :label="t('re.isFooter')"
        />
      </NGi>
    </NGrid>

  </div>
</template>
