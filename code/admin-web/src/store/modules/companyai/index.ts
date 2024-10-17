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
    listData: [] as APIAI.CompanyAI[],
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
        this.listData = data;

        this.countTotalData = totalCount; 
            // Resolve image URLs for each company
    this.listData = await Promise.all(this.listData.map(async (company) => {
      // Check if logoUrl is present
      if (company.logoUrl) {
        try {
          company.logoUrl = await getImageUrl(this.bucket ,company.logoUrl);
        } catch (error) {
          console.error(`Failed to fetch image for company ${company.name}:`, error);

        }
      }

      return {
        ...company
      };
    }));
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
        this.listData = [insertedData, ...this.listData];
        this.countTotalData += 1;
      } catch (error: any) {
        throw error;
      }
    },

    async deleteDataAction(id: string): Promise<void> {
      try {
        await deleteDataFromTable(tableName, id);
        this.listData = this.listData.filter(company => company.id !== id);
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
        this.listData = this.listData.map(company =>
          company.id === data.id ? { ...company, ...data } : company
        );
      } catch (error: any) {
        throw error;
      }
    }
  }
});
