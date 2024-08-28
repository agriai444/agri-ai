<script setup lang="ts">
import { onMounted, ref } from 'vue'
import { NCard, NGrid, NGridItem, NNumberAnimation, NSkeleton } from 'naive-ui'
import { useDashboardStore } from '@/store'
import { SvgIcon } from '@/components/common'
import { t } from '@/locales';
const dashboardStore = useDashboardStore()
const isLoading = ref(true)

onMounted(async () => {
  await dashboardStore.fetchDashboardData()
  isLoading.value = false
})

const cardItems = [
  { title: t('common.Clients'), count: () => dashboardStore.clientCount, icon: 'mdi:account-group' },
  { title: t('common.AgriExperts'), count: () => dashboardStore.expertCount, icon: 'mdi:account-tie' },
  { title: t('common.Admins'), count: () => dashboardStore.adminCount, icon: 'mdi:account-cog' },
  { title: t('common.AICompanies'), count: () => dashboardStore.aiCompanyCount, icon: 'mdi:domain' },
  { title: t('common.AIModels'), count: () => dashboardStore.aiModelCount, icon: 'mdi:robot' },
  { title: t('common.Questions'), count: () => dashboardStore.questionCount, icon: 'mdi:help-circle' },
  { title: t('common.convAI'), count: () => dashboardStore.convAICount, icon: 'hugeicons:ai-chat-02' }, 
  { title: t('common.convExperts'), count: () => dashboardStore.convExpertCount, icon: 'mdi:chat-processing' }, 
];
</script>

<template>
  <div class="p-4 mx-12 ">
    <h1 class="text-2xl font-bold mb-4 gtext">{{ t('common.Dashboard') }}</h1>
    <NGrid :x-gap="12" :y-gap="12" :cols="2">
      <NGridItem v-for="item in cardItems" :key="item.title">
        <NCard>
          <div class="flex  items-center justify-between">
            <div>
              <h3 class="text-2xl font-bold mb-2 gtext">{{ item.title }}</h3>
              <NSkeleton v-if="isLoading" text :repeat="1" :width="60" />
              <div v-else class=" font-bold text-4xl gtext">{{ item.count() }}</div>
              <!-- <NNumberAnimation
           style="font-weight: bold; font-size: 2rem;"
                v-else
                :from="0"
                :to="item.count()"
                :duration="3000"
              /> -->
            </div>
            <NSkeleton v-if="isLoading" circle :width="48" :height="48" />
            <SvgIcon :icon="item.icon" :width="38" :height="38" style=" color: blue;"/>
        
          </div>
        </NCard>
      </NGridItem>
    </NGrid>
  </div>
</template>