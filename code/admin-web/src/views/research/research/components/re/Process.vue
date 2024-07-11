<script setup lang='ts'>
import { ref, computed } from 'vue'
import { useResearchStore } from '@/store'
import { useBasicLayout } from '@/hooks/useBasicLayout';
import { NProgress } from 'naive-ui'
const researchStore = useResearchStore()
const re_info = computed(() => researchStore.$state.current_re_state.re_info)
</script>

<template>
    <div class="flex flex-col gap-2">
        <NProgress type="dashboard" class="w-12 h-12" gap-position="bottom" :percentage="80" />
    </div>
</template>
