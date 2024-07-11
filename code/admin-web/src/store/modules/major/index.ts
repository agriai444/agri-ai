// index.ts

import { defineStore } from 'pinia';
import { fetchMajors, deleteMajor, updateMajor, insertMajor } from './helper';

export const useMajorStore = defineStore('major-store', {
  state: (): Research.Major[] => ([]),

  actions: {
    async fetchMajorsAction(): Promise<Research.Major[]> {
      try {
        const result = await fetchMajors();
        this.$state = result;
        return result;
      } catch (error: any) {
        console.error('Error fetching data:', error.message);
        throw error;
      }
    },

    async insertMajorAction(newMajor: Research.Major): Promise<void> {
      try {
        const insertedMajor = await insertMajor(newMajor);
        this.$state = [...this.$state, insertedMajor];
      } catch (error: any) {
        console.error('Error inserting major:', error.message);
        throw error;
      }
    },

    async deleteMajorAction(id: string): Promise<void> {
      try {
        await deleteMajor(id);
        const index = this.$state.findIndex((major) => major.id === id);
        if (index !== -1) {
          this.$state.splice(index, 1);
        }
      } catch (error: any) {
        console.error('Error deleting major:', error.message);
        throw error;
      }
    },

    async updateMajorAction(payload: { id: string; updates: Partial<Research.Major> }): Promise<void> {
      try {
        await updateMajor(payload.id, payload.updates);
        this.$state = this.$state.map((major) =>
          major.id === payload.id ? { ...major, ...payload.updates } : major
        );
      } catch (error: any) {
        console.error('Error updating major:', error.message);
        throw error;
      }
    },
  },
});
