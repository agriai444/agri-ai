<script setup lang='ts'>
import { computed,  onMounted, ref, watch } from 'vue'
import { SelectOption, SelectGroupOption, NSelect } from 'naive-ui'
import { get, post, del } from '@/utils/request'
const listDataRef = ref('')
const listData =  computed(() => listDataRef.value)

async function  fetchDataAction(): Promise<void> {
      try {
        const data = {
        //   isActive: 1,
        //   state: "Running",
        };
        const response = await get({
          url: 'company-ai/',
          data,
        })
     
    listDataRef.value = response.results
    console.log("response.esults", response.results)
      } catch (error: any) {
        console.log("error", error.message)
        throw error;
      }
    }

  
onMounted(async () => {
 console.log("response.esults")
 await fetchDataAction()
});

</script>

<template>
    <div class=" rounded-lg flex justify-center p-4">
  {{listData}}
    </div>
</template>
  
