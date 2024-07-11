<script setup lang='ts'>
import type { CSSProperties } from 'vue'
import { computed, ref, watch } from 'vue'
import { NButton, NLayoutSider } from 'naive-ui'
import MainList from './MainList.vue'
import Footer from './Footer.vue'
import { useAppStore, useChatStore } from '@/store'
import { useBasicLayout } from '@/hooks/useBasicLayout'
import { PromptStore } from '@/components/common'
import { SvgIcon } from '@/components/common'
import { LogoApp } from '@/components/common';
const appStore = useAppStore()
const chatStore = useChatStore()
const { isMobile } = useBasicLayout()
const show = ref(false)
const collapsed = computed(() => appStore.siderCollapsed)
const loadingMessage = computed(() =>  chatStore.loadingMessage);

function handleAdd() {
  chatStore.resetChatState()
  if (isMobile.value)
    appStore.setSiderCollapsed(true)
}

function handleUpdateCollapsed() {
  appStore.setSiderCollapsed(!collapsed.value)
}

const getMobileClass = computed<CSSProperties>(() => {
  if (isMobile.value) {
    return {
      position: 'fixed',
      zIndex: 50,
    }
  }
  return {}
})

const mobileSafeArea = computed(() => {
  if (isMobile.value) {
    return {
      paddingBottom: 'env(safe-area-inset-bottom)',
    }
  }
  return {}
})

watch(
  isMobile,
  (val) => {
    appStore.setSiderCollapsed(val)
  },
  {
    immediate: true,
    flush: 'post',
  },
)
</script>

<template>
  <NLayoutSider   

  :collapsed="collapsed"
    :collapsed-width="0"
    :width="260"
    :show-trigger="isMobile ? false : 'arrow-circle'"
    collapse-mode="transform"
    position="absolute"
    bordered
    :style="getMobileClass"
    @update-collapsed="handleUpdateCollapsed">
    <div  class="flex flex-col h-full" :style="mobileSafeArea">
      <main class="flex flex-col  flex-1 min-h-0">

        <div class="flex flex-col px-4 py-2  justify-center items-center ">
          <NButton class="btn btn-outline btn-primary dark:text-white " dashed block @click="handleAdd" :disabled="loadingMessage" >
            <div class="flex flex-row  justify-start  items-center gap-2 w-full">
              <LogoApp :size="35" />
              <div class=""> {{ $t('chat.newChatButton') }}</div>
              <SvgIcon icon="ri:chat-new-fill" />
            </div>
          </NButton>
        </div>


        <div class="flex-1 min-h-0 pb-4 overflow-hidden">
          <MainList/>
          <!-- <List /> -->
        </div>

        <!-- <div class="p-4">
          <NButton block @click="show = true">
            {{ $t('store.siderButton') }}
          </NButton>
        </div> -->

      </main>
      <div class="">
        <Footer />
      </div>
    </div>
  </NLayoutSider>
  <template v-if="isMobile">
    <div v-show="!collapsed" class="fixed inset-0 z-40 w-full h-full bg-black/40" @click="handleUpdateCollapsed" />
  </template>
  <PromptStore v-model:visible="show" />
</template>
