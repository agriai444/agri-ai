
<!-- BaseInput.vue -->
<template>
  <NInput
    :value="modelValue"
    @update:value="$emit('update:modelValue', $event)"
    @keyup.enter="$emit('enter')"
    :placeholder="placeholder"
    clearable
    @keydown.enter.prevent
  />
</template>

<script setup lang="ts">
import { NInput } from 'naive-ui';

const props = defineProps<{
  modelValue: string;
  placeholder: string;
}>();

const emit = defineEmits(['update:modelValue', 'enter']);
</script>