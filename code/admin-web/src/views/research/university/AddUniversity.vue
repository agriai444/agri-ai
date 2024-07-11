<script setup lang="ts">
import { ref, h, VNodeChild } from 'vue';
import { NForm, NInput, NButton, FormInst, UploadCustomRequestOptions, SelectOption } from 'naive-ui';
import { t } from '@/locales';
import { useMessage, NSelect, NGrid, NFormItemGi, NUpload, NSwitch } from 'naive-ui';
import { useUniversityStore, useUtilStore} from '@/store'
import { supabase } from '@/utils/supabase';
import { SvgIcon } from '@/components/common';
const folder: string = 'University';
const bucket: string = 'research';

const universityStore = useUniversityStore()
const utilStore = useUtilStore()
const message = useMessage();
const formRef = ref<FormInst | null>(null);
const loading = ref(false);
const model = ref<Research.University>(universityStore.initState());
const rules = {
  name: [{ required: true, message: t('university.nameRequired'), trigger: ['input', 'blur'] }],
  country: [{ required: true, message: t('university.countryRequired') }],
  image: [{ required: true, message: t('university.imageRequired'), trigger: ['input', 'blur'] }],
};
async function handleAddUniversity() {
  try {
    loading.value = true;
    await universityStore.insertUniversityAction(model.value);
    loading.value = false;
    universityStore.showModelAdd = false
    message.success(t('common.addSuccess'));
  } catch (error: any) {
    loading.value = false;
    console.error(t('common.addFailed'), error.message);
    message.error(t('common.addFailed'), error.message);
  }
}

const customRequest = async ({
  file,
  data: dataParams,
  headers,
  withCredentials,
  action,
  onFinish,
  onError,
  onProgress,
}: UploadCustomRequestOptions) => {
  try {
    if (!dataParams) {
  
      throw new Error('dataParams is undefined');
    }
    
    const progressEvent = { loaded: 20, total: 100 };
    const percentCompleted = Math.round((progressEvent.loaded * 100) / progressEvent.total);
    onProgress({ percent: percentCompleted });
    const { data, error } = await supabase
      .storage
      .from(dataParams.bucket)
      .upload(`${dataParams.folder}/${file.name}`, file.file!, {
        cacheControl: '3600',
        upsert: false,
      })
    let percent = 10;
    onProgress({ percent: Math.ceil(percent) })
    if (error) {
      if (error.statusCode === "409" && error.error === "Duplicate") {
        model.value.image_url = `${dataParams.folder}/${file.name}`
        onFinish()
      } else {
        throw error;
      }
    }
    if (data) {
      model.value.image_url = data.path
      onFinish()
    }

  }
  catch (error: any) {
    console.log(error)
    message.error(error.message);
    onError();
  }

}

function isButtonDisabled() {
  return (
    !model.value.name ||
    !model.value.country_code ||
    !model.value.image_url)
}
const renderLabel: (option: SelectOption) => VNodeChild = (option) => {
  return h(
    'div',
    {
      style: {
        display: 'flex',
        alignItems: 'center',
      },
    },
    [
      h(SvgIcon, {
        icon: 'flagpack:' + (typeof option.value === 'string' ? option.value.toLowerCase() : option.value),
        class: 'w-6 h-6',
      }),
      h(
        'span',
        {
          style: {
            marginLeft: '8px',
          },
        },
        option.label as string,
      ),
    ],
  );
};

</script>

<template>
  <div class="border-none shadow-none flex flex-col gap-2 p-2 rounded-lg">

    <div class="post-heading mb-1">
      <div class="gtext text-2xl font-bold underlined">{{ t('university.addUniversity') }}</div>
    </div>
    <NForm
      ref="formRef"
      :model="model"
      :rules="rules"
      size="large"
   
    >
      <div>
        <NGrid
          :cols="4"
          :span="24"
          :x-gap="24"
        >
          <NFormItemGi
            :span="12"
            path="image"
            :label="t('university.image')"
          >
            <NUpload
              accept="image/*"
              list-type="image-card"
              :max=1
              path="image"
              :data="{
                'folder': folder,
                'bucket': bucket
              }"
              :custom-request="customRequest"
            >
            </NUpload>
          </NFormItemGi>
          <NFormItemGi
            :span="12"
            path="name"
            :label="t('university.universityName')"
          >
            <NInput
              v-model:value="model.name"
              :placeholder="t('university.universityName')"
              clearable
              @keydown.enter.prevent
            />
          </NFormItemGi>
          <NFormItemGi
            :span="12"
            path="country"
            :label="t('university.country')"
          >
            <NSelect
              filterable
              trigger="hover"
              v-model:value="model.country_code"
              :options="utilStore.getCountryOption()"
              :render-label="renderLabel"
            >
              <NButton>{{ t('university.country') }}</NButton>
            </NSelect>
          </NFormItemGi>

          <NFormItemGi
            :span="12"
            path="state"
            :label="t('university.state')"
          >
            <NSwitch
              v-model:value="model.is_active"
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
          @click="handleAddUniversity"
        >
          {{ t('university.addUniversity') }}
        </NButton>
      </div>

    </NForm>
  </div>
</template>
  
