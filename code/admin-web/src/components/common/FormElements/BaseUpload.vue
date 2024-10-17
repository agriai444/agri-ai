<script setup lang="ts">
import { supabase } from '@/utils/supabase';
import { NUpload, UploadCustomRequestOptions } from 'naive-ui';
import { useMessage } from 'naive-ui';
import { defineEmits, defineProps } from 'vue';

const message = useMessage();

const props = defineProps<{
  accept: string;
  bucket: string;
}>();

const emit = defineEmits(['upload-success']); // Define an event to notify the parent on success

const customRequest = async ({ file, data: dataParams, onFinish, onError, onProgress }: UploadCustomRequestOptions) => {
  try {
    const progressEvent = { loaded: 20, total: 100 };
    const percentCompleted = Math.round((progressEvent.loaded * 100) / progressEvent.total);
    onProgress({ percent: percentCompleted });

    const { data, error } = await supabase.storage.from(dataParams.bucket).upload(`${file.name}`, file.file!, {
      cacheControl: '3600',
      upsert: false
    });

    if (error) {
      if (error.statusCode === '409' && error.error === 'Duplicate') {
        onFinish();
        emit('upload-success', file.name); // Emit the success event with file name
      } else {
        throw error;
      }
    }

    if (data) {
      onFinish();
      emit('upload-success', file.name); // Emit the success event with file name
    }
  } catch (error: any) {
    message.error(error.message);
    onError();
  }
};
</script>

<template>
  <NUpload
    :accept="accept"
    list-type="image-card"
    :max="1"
    :data="{ bucket: bucket }"
    :custom-request="customRequest"
  />
</template>
