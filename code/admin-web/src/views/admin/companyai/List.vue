<script setup lang='ts'>
import { ref, h,  reactive } from 'vue'
import {DataTableBaseColumn,

 DataTableColumns,
  NA,
  NText,
  NSwitch,
  NAvatar,
} from 'naive-ui'
import { DataTableBase} from '@/components/common';
import { useCompanyStore } from '@/store'
import { t } from '@/locales';
import { SvgIcon } from '@/components/common';
import Add from './Add.vue'
import Update from './Update.vue'
const modelStore = useCompanyStore()
const columns = reactive<DataTableColumns<APIAI.CompanyAI>>([
  {
    title: t('common.name'),
    key: 'name',
    align: 'center',
    render(row: APIAI.CompanyAI) {
      return h(NText, { strong: true }, { default: () => row.name });
    },
  
  },
  {
    title: t('common.companyUrl'),
    key: 'companyUrl',
    align: 'center',
    render(row: APIAI.CompanyAI) {
      return row.companyUrl ? h(NA, { href: row.companyUrl, target: '_blank' }, { default: () => row.companyUrl }) : null;
    },
    ellipsis: true,
     
  },
  {
    title: t('common.logoUrl'),
    key: 'logoUrl',
    align: 'center',
    render(row: APIAI.CompanyAI) {
      const hasLogoUrl = row.logoUrl !== null && row.logoUrl !== undefined && row.logoUrl.trim() !== '';

      const defaultIcon = h(SvgIcon, {
        icon: "mdi:company",
        class: "text-lg text-primary"
      });

      return hasLogoUrl
        ? h(NAvatar, {
          round: true,
          src: row.logoUrl,
          size: "large"
        })
        : defaultIcon;
    },
    ellipsis: true,
      
  },
  {
    title: t('common.apiUrl'),
    key: 'apiUrl',
    align: 'center',
    render(row: APIAI.CompanyAI) {
      return h(NText, { type: 'info' }, { default: () => row.apiUrl });
    },
    ellipsis: true,
       
  },
  {
    title: t('common.apiKey'),
    key: 'apiKey',
    align: 'center',
    render(row: APIAI.CompanyAI) {
      return h(NText, { type: 'info' }, { default: () => row.apiKey });
    },
    ellipsis: true,
      
  },
  {
    title: t('common.isActivate'),
    key: 'isActivate',
    align: 'center',
    render(row: APIAI.CompanyAI) {
      return h(NSwitch, { value: row.isActivate, disabled: true });
    },
      
  },
  {
    title: t('common.createdAt'),
    key: 'createdAt',
    align: 'center',
    render(row: APIAI.CompanyAI) {
      return h(NText, {}, { default: () => new Date(row.createdAt).toLocaleString() });
    },
       
  },
  {
    title: t('common.updatedAt'),
    key: 'updatedAt',
    align: 'center',
    render(row: APIAI.CompanyAI) {
      return h(NText, {}, { default: () => new Date(row.updatedAt).toLocaleString() });
    },
      
  }
]);

</script>
<template>
  <DataTableBase
    :title="t('common.company')"
    :modelStore="modelStore"
    :columns="columns"
    :Add="Add"
    :Update="Update"
  />
</template>
