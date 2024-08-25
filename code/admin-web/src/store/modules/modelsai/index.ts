import { deleteDataFromTable, fetchDataFromTable, insertDataIntoTable, updateDataInTable } from '@/utils/supabasehelper';
import { defineStore } from 'pinia';

export function initState(): APIAI.ModelAI {
  return {
  
    companyId: '',
    name: '',
    modelCode: '',
    description: '',
    isActivate: true,
    version: '',
 
      inputData: ["Text"],
      outputData: ["Text"],
      maxTokens: 512,
      temperature: 0.7,
      topP: 0.7,
      topK: 50,
      repetitionPenalty: 1,
      stop: ["[/INST],</s>"],
      stream: true,
  
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString()
  }
}

const tableName = 'ai_model';

export const useModelStore = defineStore('model-store', {
  state: () => ({
    listModels: [] as APIAI.ModelAI[],
    modelInfo: initState(),
    loadingInit: false,
    showModelAdd: false,
    showModelUpdate: false,
    countTotalData: 0
  }),
  actions: {
    initState(): APIAI.ModelAI {
      return initState();
    },

    async fetchDataAction({ limit, offset }: { limit: number; offset: number }): Promise<void> {
      try {
        const { data, totalCount } = await fetchDataFromTable<APIAI.ModelAI>(tableName, limit, offset);
        this.listModels = data;
        this.countTotalData = totalCount;
      } catch (error: any) {
        console.error('Error fetching models:', error.message);
        throw error;
      }
    },

    async insertDataAction(newModel: APIAI.ModelAI): Promise<void> {
      try {
        let insertedData = await insertDataIntoTable<APIAI.ModelAI>(tableName, newModel);
        this.listModels = [insertedData, ...this.listModels];
        this.countTotalData += 1;
      } catch (error: any) {
        console.error('Error inserting model:', error.message);
        throw error;
      }
    },

    async deleteDataAction(id: string): Promise<void> {
      try {
        await deleteDataFromTable(tableName, id);
        this.listModels = this.listModels.filter(model => model.id !== id);
        this.countTotalData -= 1;
      } catch (error: any) {
        console.error('Error deleting model:', error.message);
        throw error;
      }
    },

    async updateDataAction(data: APIAI.ModelAI): Promise<void> {
      try {
        await updateDataInTable<APIAI.ModelAI>(tableName, data);
        this.listModels = this.listModels.map(model =>
          model.id === data.id ? { ...model, ...data } : model
        );
      } catch (error: any) {
        console.error('Error updating model:', error.message);
        throw error;
      }
    }
  }
});
