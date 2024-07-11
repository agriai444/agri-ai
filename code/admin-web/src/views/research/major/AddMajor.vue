<script setup lang="ts">
import { computed, ref } from 'vue';
import { NForm, NInput, NButton, FormInst, UploadCustomRequestOptions } from 'naive-ui';
import { t } from '@/locales';
import { useMessage, NSelect, NModal, NGrid, NFormItemGi, NUpload, NSwitch } from 'naive-ui';
import { useMajorStore } from '@/store'
import { supabase } from '@/utils/supabase';
const majorStore = useMajorStore()
interface Props {
  visible: boolean
}

interface Emit {
  (e: 'update:visible', visible: boolean): void
}

const props = defineProps<Props>()

const emit = defineEmits<Emit>()

const message = useMessage();
const formRef = ref<FormInst | null>(null);
const loading = ref(false);
const model = ref<Research.Major>({
name: '',
is_active: true,
image_url: '',
id: null,
created_at: new Date(),
updated_at: new Date()
});
const rules = {
  name: [{ required: true, message: t('major.nameRequired'), trigger: ['input', 'blur'] }],
  image: [{ required: true, message: t('major.imageRequired'), trigger: ['input', 'blur'] }],
};

async function handleAddMajor() {
  try {
    loading.value = true;
    const insertedMajor = await majorStore.insertMajorAction(model.value);
    loading.value = false;
    show.value = false;
    message.success('Done Inserted');
    console.log('Inserted Major:', insertedMajor);
  } catch (error: any) {
    loading.value = false;
    console.error('Error inserting major:', error.message);
    message.error('Failed to insert major');
  }
}

const customRequest = async ({
  file,
  onFinish,
  onError,
  onProgress,
}: UploadCustomRequestOptions) => {
  try {
    const { data, error } = await supabase
      .storage
      .from('research')
      .upload(`Major/${file.name}`, file.file!, {
        cacheControl: '3600',
        upsert: false,
      });

    if (error) {
      throw error;
    }

    if (data) {
      model.value.image_url = data.path;
      message.success('Done');
      onFinish();
    }
  } catch (error: any) {
    console.error(error);
    message.error(error.message);
    onError();
  }
}

const show = computed({
  get() {
    return props.visible
  },
  set(visible: boolean) {
    emit('update:visible', visible)
  },
})

function isButtonDisabled() {
  return (
    !model.value.name ||
    !model.value.image_url
  );
}
</script>

<template>
  <NModal
    v-model:show="show"
    :mask-closable=false
    :auto-focus="false"
    preset="card"
    style="width: 95%; max-width: 640px;"
  >

    <div class="border-none shadow-none flex flex-col gap-2 p-2 rounded-lg">

      <div class="post-heading mb-1">
        <div class="gtext text-2xl font-bold underlined">{{ t('major.addMajor') }}</div>
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
              :label="t('major.image')"
            >
              <NUpload
                accept="image/*"
                list-type="image-card"
                :max=1
                path="image"
                :custom-request="customRequest"
              >
              </NUpload>
            </NFormItemGi>
            <NFormItemGi
              :span="12"
              path="name"
              :label="t('major.majorName')"
            >
              <NInput
                v-model:value="model.name"
                placeholder="Major Name"
                clearable
                @keydown.enter.prevent
              />
            </NFormItemGi>
            <NFormItemGi
              :span="12"
              path="state"
              :label="t('major.state')"
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
            @click="handleAddMajor"
          >
            {{ t('major.addMajor') }}
          </NButton>
        </div>

      </NForm>
    </div>
  </NModal>
</template>
