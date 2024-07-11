import { defineStore } from 'pinia'
import { defaultState, defaultCurrentConversation , setLocalState} from './helper'
import { router } from '@/router'
import { useUserStore } from '@/store';
import { get, post, del } from '@/utils/request'
export const useApiStore = defineStore('api-store', {
  state: (): Chat.CompanyAI => defaultState(),
  actions: {

    recordState() {
      setLocalState(this.$state)
    },
  }
})