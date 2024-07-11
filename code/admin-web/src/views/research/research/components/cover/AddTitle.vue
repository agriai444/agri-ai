<script setup lang='ts'>
import { ref, computed } from 'vue'
import { NInput, NButton, NGrid, NCheckbox, useDialog, useMessage, NCollapse, NCollapseItem, DataTableColumns } from 'naive-ui'
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

const re_info = computed(() => researchStore.$state.re_info)
const public_setting = computed(() => researchStore.$state.public_setting)
</script>

<template>
  <div class="flex flex-col gap-2">
    <NInput
      :maxlength="public_setting.max_title_char"
      type="textarea" 
      show-count
      :clearable="public_setting.clearable"
      v-model:value="re_info.title"
      placeholder="Title Research"
      @keydown.enter.prevent
    />
  </div></template>
