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
    case 'university':
      await router.push({ name: 'university' });
      handleFinish() 
      break
    case 'addUniversity':
      await router.push({ name: 'add-university' });
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
    label: t('research.dashboard'),
    key: 'Dashboard',

    children: [
      {
        label: t('research.dashboard'),
        key: 'dashboard',
        icon: iconRender({ icon: 'material-symbols:dashboard' }),
        disabled: true,
      },
      {
        label: t('research.researches'),
        key: 'gen-research',
        disabled: false,
        icon: iconRender({ icon: 'raphael:paper' }),
    

      },
      {
        label: t('research.students'),
        key: 'students',
        icon: iconRender({ icon: 'mdi:account-student' }),
        disabled: true,


      }
    
    ]
  },

  {
    type: 'group',
    label: 'Public',
    key: 'public',
    children: [
      {
        label: t('university.universitys'),
        key: 'university',
        disabled: false,
        icon: iconRender({ icon: 'fa-solid:university' }),

      },
      {
        label: t('research.departments'),
        key: 'departments',
        disabled: true,
        icon: iconRender({ icon: 'mingcute:department-fill' }),

      },
      {
        label: t('research.majors'),
        key: 'major',
        disabled:false,
        icon: iconRender({ icon: 'material-symbols:merge-type' }),

      },
      {
        label: t('research.courses'),
        key: 'cources',
        disabled: true,
        icon: iconRender({ icon: 'tdesign:course' }),

      },

    ],
  },

  {
    type: 'group',
    label: t('research.settings'),
    key: 'settings',

    children: [
      {
        label:  t('research.settings'),
        key: 'Settings',
        icon: iconRender({ icon: 'fluent:settings-16-filled' }),
        disabled: true,

      },
      {
        label:  t('research.profile'),
        key: 'profile',
        icon: iconRender({ icon: 'gg:profile' }),
      

      },
      {
        label: t('research.advances'),
        key: 'advances',
        icon: iconRender({ icon: 'arcticons:advancedtaskkiller' }),
        disabled: true,

      },
    ],
  }
];


const inverted = ref(false)
</script>

<template>
   <NScrollbar class="">
  <NMenu
    :inverted="inverted"
    ref="menuInstRef"
    :accordion="accordion"
    :collapsed-width="64"
    :collapsed-icon-size="22"
    :options="menuOptions"
    @update:value="handleUpdateValue"
  />
  </NScrollbar>
</template>

