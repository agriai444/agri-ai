<script setup lang='ts'>
import { ref, computed } from 'vue'
import { useResearchStore } from '@/store'
import { useBasicLayout } from '@/hooks/useBasicLayout';
import { NTooltip, NAvatar, NBadge, NEllipsis } from 'naive-ui'
import { t } from '@/locales';
const researchStore = useResearchStore()
import { SvgIcon } from '@/components/common';
import { supabaseUrlImage } from '@/utils/supabase';
const bucket = 'research';
interface Props {
  row: Research.University
}

const props = defineProps<Props>()
const row = computed(() => props.row)
const fullUrlImage = `${supabaseUrlImage}/${bucket}/${row.value.image_url}`


const badgeType = row.value.is_active ? 'success' : 'error';
const { isMobile } = useBasicLayout()
</script>

<template>
  <div class="flex gap-4 item-center">
    <NBadge
      dot
      :processing=false
      :type='badgeType'
    >
      <NAvatar
        round
        size="medium"
        :src="fullUrlImage"
      />
    </NBadge>

    <div class="flex flex-col">
      <div class="font-bold text-base">
        <NEllipsis :line-clamp="1">
          {{ row.name }}
          <template #tooltip>
            <div class="w-36">
              {{ row.name }}
            </div>
          </template>
        </NEllipsis>
      </div>

      <div class="flex gap-3 item-end">
        <div class="text-xs">{{ new Date(row.created_at as unknown as string).toLocaleString() }}</div>


        <NTooltip
          :style="{ maxWidth: '300px' }"
          :class="isMobile ? 'ml-36' : ''"
          trigger="hover"
          placement="bottom"
        >
          <template #trigger>
            <SvgIcon icon="ep:info-filled" />
          </template>
          <div class="">
            <div>
              <SvgIcon
                icon="ep:info-filled"
                class=" inline-flex"
              />
              information about <span class=" text-yellow-400 font-bold">{{ row.name }}</span>
            </div>
            <div class=" ml-4">
              <div class="flex gap-2 items-center">
                <SvgIcon
                  icon="lets-icons:date-today-duotone"
                  class=" inline-flex"
                />
                <div>Created At:</div>
              </div>
              <div class="ml-4">{{ new Date(row.created_at as unknown as string).toLocaleString() }}</div>

            </div>
            <div class=" ml-4">
              <div class="flex gap-2 items-center">

                <SvgIcon
                  icon="lets-icons:date-today-duotone"
                  class=" inline-flex"
                />
                <div>Updated At:</div>
              </div>
              <div class=" ml-4"> {{ new Date(row.updated_at as unknown as string).toLocaleString() }}</div>
            </div>
          </div>


        </NTooltip>

      </div>
    </div>
  </div>
</template>
