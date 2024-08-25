// src/composables/useCompanyForm.ts
import { ref, computed, Ref } from 'vue';
import { FormInst, FormRules, UploadCustomRequestOptions, useMessage } from 'naive-ui';
import { t } from '@/locales';
import { useCompanyStore } from '@/store';
import { supabase } from '@/utils/supabase';
import { useBasicLayout } from '@/hooks/useBasicLayout';

export function useCompanyForm(model: Ref<APIAI.CompanyAI>) {
  const { isMobile } = useBasicLayout();
  const span = computed(() => (isMobile ? 24 : 12));

  const companyStore = useCompanyStore();
  const message = useMessage();
  const formRef = ref<FormInst | null>(null);
  const loading = ref(false);

  const rules: FormRules = {
    name: [{ required: true, message: t('common.nameRequired'), trigger: ['input', 'blur'] }],
    apiUrl: [{ required: true, message: t('common.apiUrlRequired'), trigger: ['input', 'blur'] }],
    apiKey: [{ required: true, message: t('common.apiKeyRequired'), trigger: ['input', 'blur'] }]
  };

  const customRequest = async ({ file, data: dataParams, onFinish, onError, onProgress }: UploadCustomRequestOptions) => {
    try {
      if (!dataParams) {
        throw new Error('dataParams is undefined');
      }

      const progressEvent = { loaded: 20, total: 100 };
      const percentCompleted = Math.round((progressEvent.loaded * 100) / progressEvent.total);
      onProgress({ percent: percentCompleted });

      const { data, error } = await supabase.storage.from(dataParams.bucket).upload(`${file.name}`, file.file!, {
        cacheControl: '3600',
        upsert: false
      });

      if (error) {
        if (error.statusCode === "409" && error.error === "Duplicate") {
          model.value.logoUrl = file.name;
          onFinish()
        } else {
          throw error;
        }
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
    return !model.value.name || !model.value.apiUrl || !model.value.apiKey || loading.value;
  }

  function handleValidateButtonClick(e: MouseEvent, handleSubmit: () => Promise<void>) {
    e.preventDefault();
    formRef.value?.validate((errors) => {
      if (!errors) {
        handleSubmit();
      } else {
        message.error(t('auth.fillAllField'));
      }
    });
  }

  return {
    span,
    formRef,
    loading,
    rules,
    customRequest,
    isButtonDisabled,
    handleValidateButtonClick
  };
}
