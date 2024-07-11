<script setup lang='ts'>
import { ref, computed } from 'vue'
import { useResearchStore } from '@/store'
import { useBasicLayout } from '@/hooks/useBasicLayout';
const researchStore = useResearchStore()
const re_info = computed(() => researchStore.$state.current_re_state.re_info)
</script>

<template>
    <div class="flex flex-col gap-2">
        <div class=" bg-green-500 rounded-full p-1 font-semibold">{{ re_info.state }}</div>
    </div>
</template>
