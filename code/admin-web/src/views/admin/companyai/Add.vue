<script setup lang="ts">
import { ref, computed, h } from 'vue';
import { NForm, NInput, NButton, FormInst, FormRules, NUpload, NSwitch, useMessage, NGrid, NFormItemGi, UploadCustomRequestOptions } from 'naive-ui';
import { t } from '@/locales';
import { useCompanyStore } from '@/store';
import { supabase } from '@/utils/supabase';
import { useBasicLayout } from '@/hooks/useBasicLayout';
const { isMobile } = useBasicLayout()
  const span = computed(() => {
  return isMobile ? 24 : 12
})
const companyStore = useCompanyStore();
const message = useMessage();
const formRef = ref<FormInst | null>(null);
const loading = ref(false);
const model = ref<APIAI.CompanyAI>(companyStore.initState());

const rules: FormRules = {
  name: [{ required: true, message: t('common.nameRequired'), trigger: ['input', 'blur'] }],
  apiUrl: [{ required: true, message: t('common.apiUrlRequired'), trigger: ['input', 'blur'] }]
};

async function handleAddData() {
  try {
    loading.value = true;
    await companyStore.insertDataAction(model.value);
    loading.value = false;
    companyStore.showModelAdd = false;
    message.success(t('common.addSuccess'));
  } catch (error: any) {
    loading.value = false;
    console.error(t('common.addFailed'), error.message);
    message.error(t('common.addFailed'), error.message);
  }
}

const customRequest = async ({ file, data: dataParams, onFinish, onError, onProgress }: UploadCustomRequestOptions) => {
  try {
    if (!dataParams) {
      throw new Error('dataParams is undefined');
    }

    const progressEvent = { loaded: 20, total: 100 };
    const percentCompleted = Math.round((progressEvent.loaded * 100) / progressEvent.total);
    onProgress({ percent: percentCompleted });

    const { data, error } = await supabase.storage.from(dataParams.bucket).upload(`${dataParams.folder}/${file.name}`, file.file!, {
      cacheControl: '3600',
      upsert: false
    });

    if (error) {
      throw error;
    }

    if (data) {
      model.value.logoUrl = data.path;
      onFinish();
    }
  } catch (error: any) {
    console.log(error);
    message.error(error.message);
    onError();
  }
};

function isButtonDisabled() {
  return !model.value.name || !model.value.apiUrl;
}

function handleValidateButtonClick(e: MouseEvent) {
  e.preventDefault();
  formRef.value?.validate((errors) => {
    if (!errors) {
      handleAddData();
    } else {
      message.error(t('auth.fillAllField'));
    }
  });
}
</script>

<template>
    <div class="border-none shadow-none flex flex-col gap-2 p-2 rounded-lg">
      <div class="post-heading mb-1">
        <div class="gtext text-2xl font-bold underlined">{{ t('common.addNew') }}</div>
      </div>
      <NForm ref="formRef" :model="model" :rules="rules" size="large">
        <div>
          <NGrid :span="span" :x-gap="24">
            <NFormItemGi :span="span" path="logoUrl" :label="t('common.logoUrl')">
              <NUpload accept="image/*" list-type="image-card" :max="1" path="logoUrl" :custom-request="customRequest">
              </NUpload>
            </NFormItemGi>
            <NFormItemGi :span="span" path="name" :label="t('common.name')">
              <NInput v-model:value="model.name" :placeholder="t('common.name')" clearable @keydown.enter.prevent />
            </NFormItemGi>
            <NFormItemGi :span="span" path="companyUrl" :label="t('common.companyUrl')">
              <NInput v-model:value="model.companyUrl" :placeholder="t('common.companyUrl')" clearable @keydown.enter.prevent />
            </NFormItemGi>
         
            <NFormItemGi :span="span" path="apiUrl" :label="t('common.apiUrl')">
              <NInput v-model:value="model.apiUrl" :placeholder="t('common.apiUrl')" clearable @keydown.enter.prevent />
            </NFormItemGi>
            <NFormItemGi :span="span" path="isActivate" :label="t('common.isActivate')">
              <NSwitch v-model:value="model.isActivate" size="large" />
            </NFormItemGi>
          </NGrid>
        </div>
        <div style="display: flex; justify-content: flex-end">
          <NButton type="primary" style="width:100%;" size="large" :loading="loading" :disabled="isButtonDisabled()" @click="handleValidateButtonClick">
            {{ t('common.addNew') }}
          </NButton>
        </div>
      </NForm>
    </div>
  </template>
  

  