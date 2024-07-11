<script setup lang="ts">
import { computed, ref } from 'vue';
import { NForm, NInput, NButton, FormInst, UploadFileInfo, UploadCustomRequestOptions } from 'naive-ui';
import { t } from '@/locales';
import { useMessage, NModal, NGrid, NFormItemGi, NUpload, NSwitch } from 'naive-ui';
import { useMajorStore } from '@/store'
import { supabase, supabaseUrlImage } from '@/utils/supabase';

const majorStore = useMajorStore()

interface Props {
    visible: boolean
    row: Research.Major
}

interface Emit {
    (e: 'update:visible', visible: boolean): void
}

const props = defineProps<Props>()

const emit = defineEmits<Emit>()

const message = useMessage();
const formRef = ref<FormInst | null>(null);
const loading = ref(false);

const initialModelRef = ref<Research.Major>({
    name: props.row.name,
    state: Boolean(props.row.state),
    image: props.row.image_url,
    updated_at: props.row.updated_at,
});

const modelRef = ref<Research.Major>({
    name: props.row.name,
    state: Boolean(props.row.state),
    image: props.row.image_url,
    updated_at: props.row.updated_at,
});

const model = modelRef;

const rules = {
    name: [{ required: true, message: t('major.nameRequired'), trigger: ['input', 'blur'] }],
    image: [{ required: true, message: t('major.imageRequired'), trigger: ['input', 'blur'] }],
};

async function handleUpdateMajor() {
    try {
        loading.value = true;
        const updatedMajor = await majorStore.updateMajorAction({ id: props.row.id || '', updates: model.value });
        loading.value = false;
        show.value = false;
        message.success('Done updated');
        console.log('updated Major:', updatedMajor);
    } catch (error: any) {
        loading.value = false;
        console.error('Error updating major:', error.message);
        message.error('Failed to update major');
    }
}

const customRequest = async ({
    file,
    onFinish,
    onError,
    onProgress,
}: UploadCustomRequestOptions) => {
    try {
        const path = 'Major';
        const bucket = 'research';
        const { data, error } = await supabase
            .storage
            .from(bucket)
            .upload(`${path}/${file.name}`, file.file!, {
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

const previewFileList = ref<UploadFileInfo[]>([
    {
        id: 'react',
        name: model.value.image_url || '',
        status: 'finished',
        url: `${supabaseUrlImage}/${bucket}/${model.value.image_url}`
    },
])

function isButtonDisabled() {
    return (
        !model.value.name ||
        !model.value.image_url ||
        (model.value.name === initialModelRef.value.name &&
            model.value.state === initialModelRef.value.state &&
            model.value.image_url === initialModelRef.value.image_url)
    );
}
</script>

<template>
    <NModal
        v-model:show="show"
        :mask-closable=false
        :auto-focus="false"
        preset="card"
        style="width: 95%; max-width: 640px"
    >
        <div class="myglass flex flex-col gap-2    rounded-lg ">

            <div class="post-heading mb-1">
                <div class="gtext text-2xl font-bold underlined">{{ t('major.editMajor') }}</div>
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
                        @click="handleUpdateMajor"
                    >
                        {{ t('major.editMajor') }}
                    </NButton>
                </div>
            </NForm>
        </div>
    </NModal>
</template>
