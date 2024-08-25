<!-- src/views/Add.vue -->
<script setup lang="ts">
import { ref } from 'vue';
import { NForm, NInput, NButton, NUpload, NSwitch, NGrid, NFormItemGi, useMessage } from 'naive-ui';
import { t } from '@/locales';
import { useCompanyStore } from '@/store';
import { useCompanyForm } from './useCompanyForm';

const companyStore = useCompanyStore();
const model = ref<APIAI.CompanyAI>(companyStore.initState());
const { span, formRef, loading, rules, customRequest, isButtonDisabled, handleValidateButtonClick } = useCompanyForm(model);
const message = useMessage();
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

</script>

<template>
  <div class="border-none shadow-none flex flex-col gap-2 p-2 rounded-lg">
    <div class="post-heading mb-1">
      <div class="gtext text-2xl font-bold underlined">{{ t('common.addNew') }}</div>
    </div>
    <NForm
      ref="formRef"
      :model="model"
      :rules="rules"
      size="large"
    >
      <div>
        <NGrid
          :span="span"
          :x-gap="24"
        >
          <NFormItemGi
            :span="span"
            path="logoUrl"
            :label="t('common.logoUrl')"
          >
            <NUpload
              accept="image/*"
              list-type="image-card"
              :max="1"
              :data="{ 'bucket': 'company' }"
              path="logoUrl"
              :custom-request="customRequest"
            />
          </NFormItemGi>
          <NFormItemGi
            :span="span"
            path="name"
            :label="t('common.name')"
          >
            <NInput
              v-model:value="model.name"
              @keyup.enter="handleValidateButtonClick($event, handleAddData)"
              :placeholder="t('common.name')"
              clearable
              @keydown.enter.prevent
            />
          </NFormItemGi>
          <NFormItemGi
            :span="span"
            path="companyUrl"
            :label="t('common.companyUrl')"
          >
            <NInput
              v-model:value="model.companyUrl"
              @keyup.enter="handleValidateButtonClick($event, handleAddData)"
              :placeholder="t('common.companyUrl')"
              clearable
              @keydown.enter.prevent
            />
          </NFormItemGi>
          <NFormItemGi
            :span="span"
            path="apiUrl"
            :label="t('common.apiUrl')"
          >
            <NInput
              v-model:value="model.apiUrl"
              @keyup.enter="handleValidateButtonClick($event, handleAddData)"
              :placeholder="t('common.apiUrl')"
              clearable
              @keydown.enter.prevent
            />
          </NFormItemGi>
          <NFormItemGi
            :span="span"
            path="apiKey"
            :label="t('common.apiKey')"
          >
            <NInput
              v-model:value="model.apiKey"
              @keyup.enter="handleValidateButtonClick($event, handleAddData)"
              :placeholder="t('common.apiKey')"
              clearable
              @keydown.enter.prevent
            />
          </NFormItemGi>
          <NFormItemGi
            :span="span"
            path="isActivate"
            :label="t('common.isActivate')"
          >
            <NSwitch
              v-model:value="model.isActivate"
              size="large"
            />
          </NFormItemGi>
        </NGrid>
      </div>
      <div style="display: flex; justify-content: flex-end">
        <NButton
          type="primary"
          style="width:100%;"
          size="large"
          :loading="loading"
          :disabled="isButtonDisabled()"
          @click="handleValidateButtonClick($event, handleAddData)"
        >
          {{ t('common.addNew') }}
        </NButton>
      </div>
    </NForm>
  </div>
</template>
