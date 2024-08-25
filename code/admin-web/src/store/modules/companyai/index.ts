import { deleteDataFromTable, fetchDataFromTable, getImageUrl, insertDataIntoTable, updateDataInTable } from '@/utils/supabasehelper';
import { defineStore } from 'pinia';



export function initState(): APIAI.CompanyAI {
  return {
    name: '',
    companyUrl: '',
    logoUrl: '',
    apiKey:'',
    apiUrl: '',
    isActivate: true,
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString()
  }
}
const tableName = 'ai_company';

export const useCompanyStore = defineStore('company-store', {
  state: () => ({
    listCompanies: [] as APIAI.CompanyAI[],
    companyInfo: initState(),
    loadingInit: false,
    showModelAdd: false,
    showModelUpdate: false,
    countTotalData: 0,
    bucket: 'company'
  }),
  actions: {
    initState(): APIAI.CompanyAI {
      return initState()
    },
    async fetchDataAction({ limit, offset }: { limit: number; offset: number }): Promise<void> {
      try {
        const { data, totalCount } = await fetchDataFromTable<APIAI.CompanyAI>(tableName, limit, offset);
        this.listCompanies = data;
        this.countTotalData = totalCount; 
      } catch (error: any) {
        console.error('Error fetching companies:', error.message);
        throw error;
      }
    },

    async insertDataAction(newCompany: APIAI.CompanyAI): Promise<void> {
      try {
        let insertedData = await insertDataIntoTable<APIAI.CompanyAI>(tableName, newCompany);
        if (insertedData.logoUrl) {
          insertedData.logoUrl = await getImageUrl(this.bucket, insertedData.logoUrl);
        }
        this.listCompanies = [insertedData, ...this.listCompanies];
        this.countTotalData += 1;
      } catch (error: any) {
        throw error;
      }
    },

    async deleteDataAction(id: string): Promise<void> {
      try {
        await deleteDataFromTable(tableName, id);
        this.listCompanies = this.listCompanies.filter(company => company.id !== id);
        this.countTotalData -= 1;
      } catch (error: any) {
        throw error;
      }
    },

    async updateDataAction(data: APIAI.CompanyAI): Promise<void> {
      try {
        await updateDataInTable<APIAI.CompanyAI>(tableName, data);
        if (data.logoUrl) {
          data.logoUrl = await getImageUrl(this.bucket, data.logoUrl);
        }
        this.listCompanies = this.listCompanies.map(company =>
          company.id === data.id ? { ...company, ...data } : company
        );
      } catch (error: any) {
        throw error;
      }
    }
  }
});
