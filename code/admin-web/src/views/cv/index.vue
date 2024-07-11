<script setup lang="ts">
import { Ref, computed, ref } from 'vue';
import { NForm,  NInput, NButton, FormInst, UploadCustomRequestOptions } from 'naive-ui';
import { t } from '@/locales';
import { useMessage, NSelect, NModal, NGrid, NFormItemGi, NUpload, NSwitch } from 'naive-ui';
import countryList, { Country } from 'country-list';
const message = useMessage();
const allCountries: Country[] = countryList.getData();
const formRef = ref<FormInst | null>(null);
const loading = ref(false);
interface CVModel {
  personal_info: {
    first_name: string;
    last_name: string;
    email: string;
    phone: string;
    address: string;
  };
  education: [
    {
      degree: string;
      school: string;
      graduation_year: number;
    }
  ];
  experience: [
    {
      position: string;
      company: string;
      start_date: string;
      end_date: string;
      responsibilities: string[];
    }
  ];
  skills: string[];
  certifications: [
    {
      title: string;
      issuing_organization: string;
      issue_date: string;
    }
  ];
}

const model: Ref<CVModel> = ref({
  personal_info: {
    first_name: '',
    last_name: '',
    email: '',
    phone: '',
    address: '',
  },
  education: [
    {
      degree: '',
      school: '',
      graduation_year: 0,
    },
  ],
  experience: [
    {
      position: '',
      company: '',
      start_date: '',
      end_date: '',
      responsibilities: [],
    },
  ],
  skills: [],
  certifications: [
    {
      title: '',
      issuing_organization: '',
      issue_date: '',
    },
  ],
});


const rules = {
  name: [{ required: true, message: t('cv.nameRequired'), trigger: ['input', 'blur'] }],
  // Add rules for other fields as needed
};

async function handleSubmitCV() {
  try {
    loading.value = true;
    // Send the CV data to your backend or process it as needed
    console.log('Submitted CV:', model.value);
    loading.value = false;
 
    message.success('CV Submitted Successfully');
  } catch (error: any) {
    loading.value = false;
    console.error('Error submitting CV:', error.message);
    message.error('Failed to submit CV');
  }
}
</script>

<template>
  <div class=" flex justify-center items-center">
  <div class="border-none shadow-none flex flex-col gap-2 p-2 rounded-lg w-96 bg-red-200 my-2">
    <div class="post-heading mb-1">
      <div class="gtext text-2xl font-bold underlined">{{ t('cv.submitCV') }}</div>
    </div>
    <NForm ref="formRef" :model="model" :rules="rules" size="large">
      <!-- Personal Information Section -->
      <div>
        <NGrid :cols="4" :span="24" :x-gap="24">
          <NFormItemGi :span="12" path="first_name" :label="t('cv.firstName')">
            <NInput v-model:value="model.personal_info.first_name" placeholder="First Name" clearable @keydown.enter.prevent />
          </NFormItemGi>
          <NFormItemGi :span="12" path="last_name" :label="t('cv.lastName')">
            <NInput v-model:value="model.personal_info.last_name" placeholder="Last Name" clearable @keydown.enter.prevent />
          </NFormItemGi>
          <NFormItemGi :span="12" path="email" :label="t('cv.email')">
            <NInput v-model:value="model.personal_info.email" placeholder="Email" clearable @keydown.enter.prevent />
          </NFormItemGi>
          <NFormItemGi :span="12" path="phone" :label="t('cv.phone')">
            <NInput v-model:value="model.personal_info.phone" placeholder="Phone" clearable @keydown.enter.prevent />
          </NFormItemGi>
          <NFormItemGi :span="24" path="address" :label="t('cv.address')">
            <NInput v-model:value="model.personal_info.address" placeholder="Address" clearable @keydown.enter.prevent />
          </NFormItemGi>
        </NGrid>
      </div>

      <!-- Education Section -->
      <div>
        <NGrid :cols="4" :span="24" :x-gap="24">
          <NFormItemGi :span="12" path="degree" :label="t('cv.degree')">
            <NInput v-model:value="model.education[0].degree" placeholder="Degree" clearable @keydown.enter.prevent />
          </NFormItemGi>
          <NFormItemGi :span="12" path="school" :label="t('cv.school')">
            <NInput v-model:value="model.education[0].school" placeholder="School" clearable @keydown.enter.prevent />
          </NFormItemGi>
          <NFormItemGi :span="12" path="graduation_year" :label="t('cv.graduationYear')">
            <NInput v-model:value="model.education[0].graduation_year" type="number" placeholder="Graduation Year" clearable @keydown.enter.prevent />
          </NFormItemGi>
        </NGrid>
      </div>


      <div style="display: flex; justify-content: flex-end">
        <NButton
          type="primary"
          style="width:100%;"
          size="large"
          :loading="loading"
      
          @click="handleSubmitCV"
        >
          {{ t('cv.submitCV') }}
        </NButton>
      </div>
    </NForm>
  </div>
</div>
</template>