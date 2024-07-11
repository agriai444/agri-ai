<script setup lang='ts'>
import { ref, computed } from 'vue'
import { NAvatarGroup, NTooltip, NDropdown, NAvatar, useDialog, useMessage, NCollapse, NCollapseItem, DataTableColumns } from 'naive-ui'
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
const options = [
    {
        name: 'Leonardo DiCaprio',
        src: 'https://gw.alipayobjects.com/zos/antfincdn/aPkFc8Sj7n/method-draw-image.svg'
    },
    {
        name: 'Jennifer Lawrence',
        src: 'https://07akioni.oss-cn-beijing.aliyuncs.com/07akioni.jpeg'
    },
    {
        name: 'Audrey Hepburn',
        src: 'https://gw.alipayobjects.com/zos/antfincdn/aPkFc8Sj7n/method-draw-image.svg'
    },
    {
        name: 'Anne Hathaway',
        src: 'https://07akioni.oss-cn-beijing.aliyuncs.com/07akioni.jpeg'
    },
    {
        name: 'Taylor Swift',
        src: 'https://gw.alipayobjects.com/zos/antfincdn/aPkFc8Sj7n/method-draw-image.svg'
    }
]

const createDropdownOptions: (options: Array<{ name: string; src: string }>) => Array<{ key: string; label: string }> = (options) =>
  options.map((option) => ({
    key: option.name,
    label: option.name,
  }));



</script>
<template>
    <NAvatarGroup
        :options="options"
        :size="40"
        :max="3"
    >
        <template #avatar="{ option: { name, src } }">
            <NTooltip>
                <template #trigger>
                    <NAvatar :src="src" />
                </template>
                {{ name }}
            </NTooltip>
        </template>
        <template #rest="{ options: restOptions, rest }">
            <NDropdown
                :options="createDropdownOptions(restOptions)"
                placement="top"
            >
                <NAvatar>+{{ rest }}</NAvatar>
            </NDropdown>
        </template>
    </NAvatarGroup>
</template>