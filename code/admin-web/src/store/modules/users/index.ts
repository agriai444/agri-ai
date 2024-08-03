// index.ts

import { defineStore } from 'pinia';
import { fetchData, deleteData, updateData, insertData ,
  fetchTotalCount} from './helper';
import { useUserStore } from '@/store';
export function  initState(): User.UserData {
  const userStore = useUserStore()
  const user_id: string = userStore.userInfo!.user!.id!;
  return {
    id: 1,
    firstName: "John",
    lastName: "Doe",
    email: null,
    password: null,
    avatarUrl: "https://example.com/avatar.jpg",
    dateOfBirth: "1990-01-01",
    state: true,
    gender: "Male",
    userType: "Client",
    country: "USA",
    createdAt: "2024-01-01T00:00:00Z",
    updatedAt: "2024-01-01T00:00:00Z"

  }
}


export const useUsersStore = defineStore('users-store', {
  state: (): ResearchState.Users => ({
    listUsers:[],
    usersInfo:initState(),
    loadingInit:false,
    showModelAdd:false,
    showModelUpdate:false,
    countTotalData:null
  }),
  actions: {
    initState(): User.UserData {
      const userStore = useUserStore()
      const user_id: string = userStore.userInfo!.user!.id!;
      return {
      
        id: 1,
    firstName: "John",
    lastName: "Doe",
    email: null,
    password: null,
    avatarUrl: "https://example.com/avatar.jpg",
    dateOfBirth: "1990-01-01",
    state: true,
    gender: "Male",
    userType: "Client",
    country: "USA",
    createdAt: "2024-01-01T00:00:00Z",
    updatedAt: "2024-01-01T00:00:00Z"
      }
    },
    async countTotalDataAction(): Promise<void> {
      try {
        this.countTotalData = await fetchTotalCount();
    
      } catch (error: any) {
        throw error;
      }
    },
    async fetchDataAction({ limit, offset }: { limit: number; offset: number }): Promise<void> {
      try {
        const userStore = useUserStore()
        const user_id: string = userStore.userInfo!.user!.id!;
        console.log(userStore.userInfo!.user)
        const result = await fetchData({ limit: limit, offset: offset } );
        this.listUsers = [...this.listUsers, ...result];
      } catch (error: any) {
        throw error;
      }
    },

    async insertDataAction(newUniversity: User.UserData): Promise<void> {
      try {
        const insertedData = await insertData(newUniversity);

        this.listUsers = [insertedData, ...this.listUsers];
      } catch (error: any) {
        throw error;
      }
    },
    async deleteDataityAction(id: number): Promise<void> {
      try {
        await deleteData(id);
        const index = this.listUsers.findIndex((university) => university.id === id);
        if (index !== -1) {
          this.listUsers.splice(index, 1);
        }
      } catch (error: any) {
        throw error;
      }
    },

    async updateDataAction(payload: { id: number; updates: Partial<User.UserData> }): Promise<void> {
      try {
        await updateData(payload.id, payload.updates);
        this.listUsers = this.listUsers.map((university) =>
          university.id === payload.id ? { ...university, ...payload.updates } : university
        );
      } catch (error: any) {
        throw error;
      }
    },
  },
});
