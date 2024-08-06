<script setup lang="ts">
import { ref } from 'vue'
import { NMenu, NScrollbar, useLoadingBar } from 'naive-ui'
import type { MenuInst, MenuOption } from 'naive-ui'
import { useRouter } from 'vue-router'
import { useIconRender } from '@/hooks/useIconRender';
import { t } from '@/locales';
import { useBasicLayout } from '@/hooks/useBasicLayout';
import { useAppStore } from '@/store';
const router = useRouter()
const accordionRef = ref(false)
const selectedKeyRef = ref('dashboard')
const menuInstRef = ref<MenuInst | null>(null)
const { iconRender } = useIconRender()
const loadingBar = useLoadingBar()
const { isMobile } = useBasicLayout()
const appStore = useAppStore()
const disabledRef = ref(true)
function handleStart() {
  loadingBar.start()
  disabledRef.value = false
  if (isMobile.value)
    appStore.setSiderCollapsed(true)
}
function handleFinish() {
  loadingBar.finish()
  disabledRef.value = true
}

async function handleUpdateValue(key: string, item: MenuOption) {
  handleStart()


  switch (key) {
    case 'dashboard':
      await router.push({ name: '' });
      handleFinish()
      break
    case 'users':
      await router.push({ name: 'users', params: { userType: 'Client' } });
      handleFinish()
      break
    case 'Agri-Expert':
      await router.push({ name: 'users', params: { userType: 'Agri-Expert' } });
      handleFinish()
      break
    case 'admins':
      await router.push({ name: 'users', params: { userType: 'Admin' } });
      handleFinish()
      break
    case 'api':
      await router.push({ name: 'api' });
      handleFinish()
      break
    case 'companyai':
      
      await router.push({ name: 'companyai' });
      handleFinish()
      break
      case 'modelsai':
      
      await router.push({ name: 'modelsai' });
      handleFinish()
      break
    case 'profile':
      await router.push({ name: 'profile' });
      handleFinish()
      break
    case 'gen-research':
      await router.push({ name: 'gen-research' });
      handleFinish()
      break
    case 'major':
      await router.push({ name: 'major' });
      handleFinish()
      break

  }

}
const accordion = accordionRef
const selectedKey = selectedKeyRef
const menuOptions: MenuOption[] = [
  {
    type: 'group',
    label: t('common.dashboard'),
    key: 'Dashboard',

    children: [
      {
        label: t('common.dashboard'),
        key: 'dashboard',
        icon: iconRender({ icon: 'material-symbols:dashboard' }),

      },
      {
        label: t('common.users'),
        key: 'users',
        disabled: false,
        icon: iconRender({ icon: 'mdi:users' }),


      },
      {
        label: t('common.agriculturalExpert'),
        key: 'Agri-Expert',
        icon: iconRender({ icon: 'mdi:account-student' }),



      },
      {
        label: t('common.admins'),
        key: 'admins',
        icon: iconRender({ icon: 'eos-icons:admin' }),



      }

    ]
  },

  {
    type: 'group',
    label: 'AI Settings',
    key: 'public',
    children: [
    {
        label: t('common.companes'),
        key: 'companyai',
     
        icon: iconRender({ icon: 'hugeicons:ai-network' }),

      },
      {
        label: t('common.modelsai'),
        key: 'modelsai',
    
        icon: iconRender({ icon: 'arcticons:ask-ai' }),

      },

      {
        label: t('common.apiKeys'),
        key: 'major',
        disabled: false,
        icon: iconRender({ icon: 'game-icons:house-keys' }),

      },
 

    ],
  },
  {
    type: 'group',
    label: t('common.notifications'),
    key: 'notification',

    children: [
      {
        label: t('common.addNotification'),
        key: 'notification',
        icon: iconRender({ icon: 'ic:baseline-notification-add' }),
       
      },
      
 
    ],
  },

  {
    type: 'group',
    label: t('common.chatsManager'),
    key: 'chats-user-ai',

    children: [
      {
        label: t('common.chatsUserAI'),
        key: 'chats-user-ai',
        icon: iconRender({ icon: 'hugeicons:ai-chat-02' }),
       
      },
      
 
    ],
  },

  {
    type: 'group',
    label: t('common.plans'),
    key: 'plans',

    children: [
      {
        label: t('common.plans'),
        key: 'Settings',
        icon: iconRender({ icon: 'noto:package' }),
       
      },
      {
        label: t('common.plansFeather'),
        key: 'profile',
        icon: iconRender({ icon: 'mingcute:vip-2-fill' }),


      },
      {
        label: t('common.advances'),
        key: 'advances',
        icon: iconRender({ icon: 'arcticons:advancedtaskkiller' }),
        disabled: true,

      },
    ],
  },


  {
    type: 'group',
    label: t('common.settings'),
    key: 'settings',

    children: [
      {
        label: t('common.settingsAPP'),
        key: 'Settings',
        icon: iconRender({ icon: 'fmdi:settings-outline' }),
        disabled: true,

      },
      {
        label: t('common.profile'),
        key: 'profile',
        icon: iconRender({ icon: 'gg:profile' }),


      },
      {
        label: t('research.advances'),
        key: 'advances',
        icon: iconRender({ icon: 'arcticons:advancedtaskkiller' }),
     

      },
    ],
  }
];


const inverted = ref(false)
</script>

<template>
  <NScrollbar class="">
    <NMenu :inverted="inverted" ref="menuInstRef" :accordion="accordion" :collapsed-width="64" :collapsed-icon-size="22"
      :options="menuOptions" @update:value="handleUpdateValue" />
  </NScrollbar>
</template>
