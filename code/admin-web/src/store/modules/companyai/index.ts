import { defineStore } from 'pinia';
import {
  fetchData, deleteData, updateData, insertData,
  fetchTotalCount
} from './helper';

export function initState(): APIAI.CompanyAI {
  return {
    name: '',
    companyUrl: '',
    logoUrl: '',
    apiUrl: '',
    isActivate: true,
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString()
  }
}

export const useCompanyStore = defineStore('company-store', {
  state: () => ({
    listCompanies: [] as APIAI.CompanyAI[],
    companyInfo: initState(),
    loadingInit: false,
    showModelAdd: false,
    showModelUpdate: false,
    countTotalData: null
  }),
  actions: {
    initState(): APIAI.CompanyAI {
      return {
     
        name: '',
        companyUrl: '',
        logoUrl: '',
        apiUrl: '',
        isActivate: true,
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString()
      }
    },
    async countTotalDataAction(): Promise<void> {
      try {
        // this.countTotalData = await fetchTotalCount();
      } catch (error: any) {
        throw error;
      }
    },
    async fetchDataAction({ limit, offset }: { limit: number; offset: number }): Promise<void> {
      try {
        const result = await fetchData({ limit, offset });
        const uniqueCompanies = result.filter(newCompany => !this.listCompanies.some(existingCompany => existingCompany.id === newCompany.id));

        this.listCompanies = [...this.listCompanies, ...uniqueCompanies];
      } catch (error: any) {
        throw error;
      }
    },
    async insertDataAction(newCompany: APIAI.CompanyAI): Promise<void> {
      try {
        const insertedData = await insertData(newCompany);

        this.listCompanies = [insertedData, ...this.listCompanies];
      } catch (error: any) {
        throw error;
      }
    },
    async deleteDataAction(id: string): Promise<void> {
      try {
        await deleteData(id);
        const index = this.listCompanies.findIndex((company) => company.id === id);
        if (index !== -1) {
          this.listCompanies.splice(index, 1);
        }
      } catch (error: any) {
        throw error;
      }
    },
    async updateDataAction(payload: { id: string; updates: Partial<APIAI.CompanyAI> }): Promise<void> {
      try {
        await updateData(payload.id, payload.updates);
        this.listCompanies = this.listCompanies.map((company) =>
          company.id === payload.id ? { ...company, ...payload.updates } : company
        );
      } catch (error: any) {
        throw error;
      }
    },
  },
});
