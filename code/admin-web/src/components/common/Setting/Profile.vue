<script lang="ts" setup>
import { computed, ref } from 'vue'
import { NButton, NInput, NAvatar, useMessage } from 'naive-ui'
import {  useUserStore } from '@/store'
import type { UserInfo } from '@/store/modules/user/helper'
import { useBasicLayout } from '@/hooks/useBasicLayout'
import { t } from '@/locales'
import  LogoUser  from '../LogoUser/index.vue';
import signOut from '@/views/auth/signOut.vue'
const userStore = useUserStore()

const ms = useMessage()

const userInfo = computed(() => userStore.userInfo)

const avatar = ref(userInfo.value.avatar ?? '')

const email = userInfo.value.user?.email ?? '';
const atIndex = email.indexOf('@');

const name = ref(atIndex !== -1 ? email.slice(0, atIndex) : email);

const description = ref(userInfo.value.description ?? '')

function updateUserInfo(options: Partial<UserInfo>) {
  userStore.updateUserInfo(options)
  ms.success(t('common.success'))
}

function handleReset() {
  userStore.resetUserInfo()
  ms.success(t('common.success'))
  window.location.reload()
}






</script>

<template>
  <div class="p-4 space-y-5 min-h-[200px]">
    <div class="space-y-2">
   <!-- <LogoUser/> -->
      <div class="flex flex-col gap-2">
        <span class="flex-shrink-0 w-[100px]">{{ $t('setting.name') }}</span>
        <div class="w-full">
          <NInput v-model:value="name" placeholder="" />
        </div>
      </div>


      <div class="flex flex-col gap-2">
        <span class="flex-shrink-0 w-[100px]">{{ $t('setting.description') }}</span>
        <div class="flex-1">
          <NInput v-model:value="description" placeholder=""   type="textarea" />
        </div>
     
      </div>

   

      <div class="flex items-center space-x-4">
        <NButton   type="primary" strong secondary round @click="updateUserInfo({ description })">
          {{ $t('common.save') }}
        </NButton>
        <signOut/>
      </div>
    </div>
  </div>
</template>
