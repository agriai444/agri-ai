<script setup lang="ts">
import { computed, ref } from 'vue';
import { NForm,  NInput, NButton, FormInst, UploadCustomRequestOptions } from 'naive-ui';
import { t } from '@/locales';
import { useMessage, NSelect, NModal, NGrid, NFormItemGi, NUpload, NSwitch } from 'naive-ui';
import countryList, { Country } from 'country-list';
import { useUniversityStore } from '@/store'
import { supabase} from '@/utils/supabase';
const universityStore = useUniversityStore()
interface Props {
  visible: boolean
}

interface Emit {
  (e: 'update:visible', visible: boolean): void
}

const props = defineProps<Props>()

const emit = defineEmits<Emit>()

const message = useMessage();
const allCountries: Country[] = countryList.getData();
const formRef = ref<FormInst | null>(null);
const loading = ref(false);
const model = ref<Research.University>({
  name: '',
  country: 'SA',
  state: true,
  image: '',
});
const rules = {
  name: [{ required: true, message: t('university.nameRequired'), trigger: ['input', 'blur'] }],
  country: [{ required: true, message: t('university.countryRequired'), trigger: ['input', 'blur'] }],
  image: [{ required: true, message: t('university.imageRequired'), trigger: ['input', 'blur'] }],
};

const countriesOptions = allCountries.map(country => ({
  label: country.name,
  value: country.code,
  disabled: false,
}));

const path:string = 'University';
const bucket:string = 'research';
async function handleAddUniversity() {
  try {
    loading.value = true;
    const insertedUniversity = await universityStore.insertUniversityAction(model.value);
    loading.value = false;
    show.value = false;
    message.success('Done Inserted');
    console.log('Inserted University:', insertedUniversity);
  } catch (error: any) {
    loading.value = false;
    console.error('Error inserting university:', error.message);
    message.error('Failed to insert university');
  }
}
const customRequest = async ({
  file,
  data,
  headers,
  withCredentials,
  action,
  onFinish,
  onError,
  onProgress,
}: UploadCustomRequestOptions) => {
  try {
    const progressEvent = { loaded: 20, total: 100 };
    const percentCompleted = Math.round((progressEvent.loaded * 100) / progressEvent.total);
    onProgress({ percent: percentCompleted });
    const { data, error } = await supabase
      .storage
      .from(bucket)
      .upload(`${path}/${file.name}`, file.file!, {
        cacheControl: '3600',
        upsert: false,
      })
    let percent = 10;
    onProgress({ percent: Math.ceil(percent) })
    if (error) {
      if (error.statusCode === "409" && error.error === "Duplicate") {
        // Handle the specific conflict error
        console.log("Resource already exists. Skipping upload.");

        model.value.image = `${path}/${file.name}`
        console.log("model.value.image.", model.value.image);
        message.success("Done");
        onFinish()
      } else {
        throw error;
      }
    }
    if (data) {
      console.log(data)
      message.success("Done");
      model.value.image = data.path
      onFinish()
    }

  }
  catch (error: any) {
    console.log(error)
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
        !model.value.country ||
        !model.value.image )
}
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
                placeholder="University Name"
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
                v-model:value="model.country"
                :options="countriesOptions"
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
                v-model:value="model.state"
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
  
