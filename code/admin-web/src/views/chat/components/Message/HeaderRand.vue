<script setup lang='ts'>
import { LogoApp } from '@/components/common';
import { useChatStore } from '@/store';
import { computed} from 'vue'
import { t } from '@/locales'
interface Props {
 date : string
}
const chatStore = useChatStore()
const currentChatHistory = computed(() => chatStore.currentConversation)

const props = defineProps<Props>()
</script>
<template>
    <div class="flex   items-center gap-1  justify-start  flex-shrink-0  overflow-hidden rounded-full basis-8">
      <LogoApp :size="38"/>
      <div class="">
        <div class="text-base font-bold">
          <div>
            <span class="gtext">{{ t('common.nameApp') }}</span> 
            <span v-if="currentChatHistory.type === 'text' && currentChatHistory.modelInfo?.label === ''" class="text-xs">({{ currentChatHistory.modelInfo?.label.toUpperCase()  }})</span>
          </div>
        </div>
        <p class="text-[0.6rem] md:text-[0.7rem]">
          {{ new Date(date).toLocaleString() }}
        </p>
      </div>
    </div>
</template>