<script setup lang="ts">
import { ref, computed, onMounted } from 'vue';
import { NForm, NInput, NButton, FormInst, FormRules, NSwitch, NGrid, NFormItemGi, NSelect, NInputNumber, useMessage } from 'naive-ui';
import { t } from '@/locales';
import { useModelStore, useCompanyStore } from '@/store';
import { useBasicLayout } from '@/hooks/useBasicLayout';
import { getImageUrl } from '@/utils/supabasehelper';

const { isMobile } = useBasicLayout();
const span = computed(() => (isMobile ? 24 : 12));

const modelStore = useModelStore();
const companyStore = useCompanyStore();
const message = useMessage();
const formRef = ref<FormInst | null>(null);
const loading = ref(false);
const model = ref<APIAI.ModelAI>(modelStore.initState());

// Validation rules
const rules: FormRules = {
  name: [{ required: true, message: t('common.nameRequired'), trigger: ['input', 'blur'] }],
  modelCode: [{ required: true, message: t('common.modelCodeRequired'), trigger: ['input', 'blur'] }],
  companyId: [{ required: true, message: t('common.companyIdRequired'), trigger: ['input', 'blur'] }],
};

// Options for select fields
const dataOptions = [
  { label: t('common.text'), value: 'Text' },
  { label: t('common.image'), value: 'Image' },
  { label: t('common.audio'), value: 'Audio' },
  { label: t('common.video'), value: 'Video' },
  { label: t('common.documents'), value: 'Documents' }
];

const companies = ref<any[]>([]);

async function fetchData(): Promise<void> {
  try {
    await companyStore.fetchDataAction({ limit: 1000, offset: 0 });

    companyStore.listCompanies = await Promise.all(companyStore.listCompanies.map(async (company) => {
      if (company.logoUrl) {
        try {
          company.logoUrl = await getImageUrl(companyStore.bucket, company.logoUrl);
        } catch (error) {
          console.error(`Failed to fetch image for company ${company.name}:`, error);
        }
      }
      return { ...company };
    }));

    companies.value = companyStore.listCompanies.map(company => ({
      label: company.name,
      value: company.id,
      logoUrl: company.logoUrl // Optionally include the logo URL for display
    }));
  } catch (error: any) {
    console.error(t('chat.dataFetchError'), error.message);
  }
}

onMounted(fetchData);

async function handleAddData() {
  try {
    loading.value = true;
    await modelStore.insertDataAction(model.value);
    loading.value = false;
    modelStore.showModelAdd = false;
    message.success(t('common.addSuccess'));
  } catch (error: any) {
    loading.value = false;
    console.error(t('common.addFailed'), error.message);
    message.error(t('common.addFailed'));
  }
}

function isButtonDisabled() {
  return !model.value.name || !model.value.modelCode || !model.value.companyId || loading.value;
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
    <NForm
      ref="formRef"
      :model="model"
      :rules="rules"
      size="large"
    >
      <div>
        <NGrid :span="span" :x-gap="24">
          <NFormItemGi :span="span" path="companyId" :label="t('common.company')">
            <NSelect
              v-model:value="model.companyId"
              :options="companies"
              :placeholder="t('common.selectCompany')"
              clearable
            />
          </NFormItemGi>
          <NFormItemGi :span="span" path="name" :label="t('common.name')">
            <NInput
              v-model:value="model.name"
              @keyup.enter="handleValidateButtonClick"
              :placeholder="t('common.name')"
              clearable
              @keydown.enter.prevent
            />
          </NFormItemGi>
          <NFormItemGi :span="span" path="modelCode" :label="t('common.modelCode')">
            <NInput
              v-model:value="model.modelCode"
              @keyup.enter="handleValidateButtonClick"
              :placeholder="t('common.modelCode')"
              clearable
              @keydown.enter.prevent
            />
          </NFormItemGi>
          <NFormItemGi :span="span" path="description" :label="t('common.description')">
            <NInput
              v-model:value="model.description"
              @keyup.enter="handleValidateButtonClick"
              :placeholder="t('common.description')"
              clearable
              @keydown.enter.prevent
            />
          </NFormItemGi>
          <NFormItemGi :span="span" path="version" :label="t('common.version')">
            <NInput
              v-model:value="model.version"
              @keyup.enter="handleValidateButtonClick"
              :placeholder="t('common.version')"
              clearable
              @keydown.enter.prevent
            />
          </NFormItemGi>
          <NFormItemGi :span="span" path="inputData" :label="t('common.inputData')">
            <NSelect
              v-model:value="model.inputData"
              :options="dataOptions"
              multiple
              :placeholder="t('common.selectInputData')"
              clearable
            />
          </NFormItemGi>
          <NFormItemGi :span="span" path="outputData" :label="t('common.outputData')">
            <NSelect
              v-model:value="model.outputData"
              :options="dataOptions"
              multiple
              :placeholder="t('common.selectOutputData')"
              clearable
            />
          </NFormItemGi>
          <NFormItemGi :span="12" path="maxTokens" :label="t('common.maxTokens')">
            <NInputNumber
              v-model:value="model.maxTokens"
              :placeholder="t('common.maxTokens')"
              min="0"
            />
          </NFormItemGi>
          <NFormItemGi :span="12" path="temperature" :label="t('common.temperature')">
            <NInputNumber
              v-model:value="model.temperature"
              :placeholder="t('common.temperature')"
              step="0.01"
              min="0"
            />
          </NFormItemGi>
          <NFormItemGi :span="12" path="topP" :label="t('common.topP')">
            <NInputNumber
              v-model:value="model.topP"
              :placeholder="t('common.topP')"
              step="0.01"
              min="0"
              max="1"
            />
          </NFormItemGi>
          <NFormItemGi :span="12" path="topK" :label="t('common.topK')">
            <NInputNumber
              v-model:value="model.topK"
              :placeholder="t('common.topK')"
              min="0"
            />
          </NFormItemGi>
          <NFormItemGi :span="12" path="repetitionPenalty" :label="t('common.repetitionPenalty')">
            <NInputNumber
              v-model:value="model.repetitionPenalty"
              :placeholder="t('common.repetitionPenalty')"
              step="0.01"
              min="0"
            />
          </NFormItemGi>
          <NFormItemGi :span="span" path="stop" :label="t('common.stop')">
            <NInput
              v-model:value="model.stop"
              :placeholder="t('common.stopPlaceholder')"
              type="textarea"
              :autosize="{ minRows: 2, maxRows: 4 }"
            />
          </NFormItemGi>
          <NFormItemGi :span="span" path="stream" :label="t('common.stream')">
            <NSwitch
              v-model:value="model.stream"
              size="large"
            />
          </NFormItemGi>
          <NFormItemGi :span="span" path="isActivate" :label="t('common.isActivate')">
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
          @click="handleValidateButtonClick"
        >
          {{ t('common.addNew') }}
        </NButton>
      </div>
    </NForm>
  </div>
</template>
