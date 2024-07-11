<script setup lang="ts">
import { ref, h,  VNodeChild , computed} from 'vue';
import { NForm, NInput, NButton, FormInst, UploadFileInfo, UploadCustomRequestOptions,  SelectOption } from 'naive-ui';
import { t } from '@/locales';
import { useMessage, NSelect, NGrid, NFormItemGi, NUpload, NSwitch } from 'naive-ui';
import countryList, { Country } from 'country-list';
import { useUniversityStore } from '@/store'
import { supabase, supabaseUrlImage } from '@/utils/supabase';
import { SvgIcon } from '@/components/common';
const path = 'University';
const bucket = 'research';
const universityStore = useUniversityStore()
interface Props {
    row: Research.University
}
const props = defineProps<Props>()
const message = useMessage();
const allCountries: Country[] = countryList.getData();
const countriesOptions = allCountries.map(country => ({
    label: country.name,
    value: country.code,
    disabled: false,
}));

const formRef = ref<FormInst | null>(null);
const loading = ref(false);
const initialModelRef = ref<Research.University>({
    id:props.row.id,
    name: props.row.name,
    country_code: props.row.country_code,
    is_active: props.row.is_active,
    user_id:props.row.user_id,
    type_added:props.row.type_added,
    image_url: props.row.image_url,
    created_at: props.row.created_at,
    updated_at: props.row.updated_at,
});

const model = ref<Research.University>({
    id:props.row.id,
    name: props.row.name,
    country_code: props.row.country_code,
    is_active: props.row.is_active,
    user_id:props.row.user_id,
    type_added:props.row.type_added,
    image_url: props.row.image_url,
    created_at: props.row.created_at,
    updated_at: props.row.updated_at,
});
const rules = {
    name: [{ required: true, message: t('university.nameRequired'), trigger: ['input', 'blur'] }],
    country: [{ required: true, message: t('university.countryRequired')}],
    image: [{ required: true, message: t('university.imageRequired'), trigger: ['input', 'blur'] }],
};
async function handleUpdateUniversity() {
    try {
        loading.value = true;
        await universityStore.updateUniversityAction({id:props.row.id!, updates:model.value});
        loading.value = false;
        universityStore.showModelUpdate = false;
        message.success(t('commn.updateSuccess'));
    } catch (error: any) {
      
        console.error(t('common.updateFailed'), error.message);
        message.error(t('common.updateFailed'));
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
                model.value.image_url = `${path}/${file.name}`
                console.log("Resource already exists. Skipping upload.");
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
const previewFileList = ref<UploadFileInfo[]>([
    {
        id: 'pp',
        name: model.value.image_url || '',
        status: 'finished',
        url: `${supabaseUrlImage}/${bucket}/${model.value.image_url}`
    },
])

function isButtonDisabled() {
    return (
        !model.value.name ||
        !model.value.country_code ||
        !model.value.image_url ||
        (model.value.name === initialModelRef.value.name &&
         model.value.country_code === initialModelRef.value.country_code &&
         model.value.is_active=== initialModelRef.value.is_active &&
         model.value.image_url === initialModelRef.value.image_url)
    );
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
                <div class="gtext text-2xl font-bold underlined">{{ t('university.editUniversity') }}</div>
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
                                :min=1
                                :max=1
                                path="image"
                                :default-file-list="previewFileList"
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
                                v-model:value="model.country_code"
                                :options="countriesOptions"
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
                        @click="handleUpdateUniversity"
                    >
                        {{ t('university.editUniversity') }}
                    </NButton>
                </div>
            </NForm>
        </div>
</template>
  
