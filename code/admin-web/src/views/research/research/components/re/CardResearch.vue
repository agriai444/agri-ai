<script setup lang='ts'>
import { ref, computed } from 'vue'
import { useResearchStore } from '@/store'
import { useBasicLayout } from '@/hooks/useBasicLayout';
import { NCard } from 'naive-ui'
import { t } from '@/locales';
const researchStore = useResearchStore()
import { SvgIcon } from '@/components/common';
const re_info = computed(() => researchStore.$state.current_re_state.re_info)
</script>

<template>
    <div class="flex flex-col gap-2 w-72">
        <NCard :title="re_info.fake_title">

            <div class="">
                <h2 class="card-title">
                    Shoes!
                    <div class="badge badge-secondary">{{ re_info.state }}</div>
                </h2>
                <div class="text-xs flex gap-1 items-center">
                    <SvgIcon
                            icon="mingcute:time-line"
                          
                        />
                        <div class="text-xs">

                            {{ new Date(re_info.created_at as unknown as string).toLocaleString() }}
                        </div>
                   

                
                </div>
                <p>If a dog chews shoes whose shoes does he choose?</p>

            </div>
            <template #footer>
                <div class="card-actions justify-start">
                    <div class="badge badge-outline">Fashion</div>
                    <div class="badge badge-outline">Products</div>
                </div>
            </template>
            <template #action>
                <div class="flex gap-1">
                    <NButton
                        type="primary"
                        style="width:100%;"
                        size="large"
                    >
                        <SvgIcon
                            icon="fluent:edit-32-regular"
                            color="blue"
                        />
                    </NButton>

                    <NButton
                        type="primary"
                        style="width:100%;"
                        size="large"
                    >
                        <SvgIcon icon="fluent:delete-32-regular" />
                    </NButton>
                </div>
            </template>
        </NCard>
    </div>
</template>
