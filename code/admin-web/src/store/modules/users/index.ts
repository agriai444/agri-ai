// index.ts

import { defineStore } from 'pinia';
import {
  fetchData, deleteData, updateData, insertData
} from './helper';
import { useUserStore } from '@/store';
import { fetchDataFromTable } from '@/utils/supabasehelper';
export function initState(): User.UserData {
  const userStore = useUserStore()
  const user_id: string = userStore.userInfo!.user!.id!;
  return {
    id: '',
    firstName: "",
    lastName: "",
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
    listUsers: [],
    usersInfo: initState(),
    loadingInit: false,
    showModelAdd: false,
    showModelUpdate: false,
    countTotalData: 0,
  }),
  actions: {
    initState(): User.UserData {
      const userStore = useUserStore()
      const user_id: string = userStore.userInfo!.user!.id!;
      return {

        id: '',
        firstName: '',
        lastName: '',
        email: '',
        password: '',
        avatarUrl: "",
        dateOfBirth: "",
        state: true,
        gender: "Male",
        userType: "Client",
        country: "USA",
        createdAt: "2024-01-01T00:00:00Z",
        updatedAt: "2024-01-01T00:00:00Z"
      }
    },
 
    async fetchDataAction({ limit, offset, userType }: { limit: number; offset: number, userType: string }): Promise<void> {
      try {
        // const userStore = useUserStore()
        // const user_id: string = userStore.userInfo!.user!.id!;
        // console.log(userStore.userInfo!.user)
        // const { data, totalCount } = await fetchDataFromTable<APIAI.CompanyAI>('users', limit, offset);
        // this.listCompanies = data;
       

        const { data, totalCount } = await fetchData({ limit: limit, offset: offset,userType: userType });
       
        const uniqueUsers = data.filter(newUser => !this.listUsers.some(existingUser => existingUser.id === newUser.id));
        this.countTotalData = totalCount; 
        this.listUsers = [...this.listUsers, ...uniqueUsers];
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
    async deleteDataAction(id: string): Promise<void> {
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

    async updateDataAction(payload: { id: string; updates: Partial<User.UserData> }): Promise<void> {
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
