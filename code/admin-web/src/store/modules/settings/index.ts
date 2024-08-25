import { defineStore } from 'pinia'
import type { SettingsState } from './helper'
import { defaultSetting, getLocalState, removeLocalState, setLocalState } from './helper'
import { supabase } from '@/utils/supabase'
import { camelToSnake, snakeToCamel } from '@/utils/functions'

const tableName = 'app_setting'

export const useSettingStore = defineStore('setting-store', {
  state: (): SettingsState => getLocalState(),
  actions: {
    async fetchDataAction(): Promise<void> {
      try {
        const { data, error } = await supabase
          .from(tableName)
          .select('*, defaultAiModel:ai_model(*)')
          .single()

        if (error) throw error

        if (data) {
          console.log("data")
          const camelData = snakeToCamel(data) as PublicApp.AppSetting
          this.updateSetting({ settings: camelData })
        }
      } catch (error: any) {
        console.error('Error fetching settings:', error.message)
        throw error
      }
    },
    async updateDataAction(settings: PublicApp.AppSetting): Promise<void> {
      try {
        // Create a new object with all properties except defaultAiModel
        const { defaultAiModel, ...otherSettings } = settings
        
        // Create the update object
        const updateData = {
          ...otherSettings,
          defaultAiModel: defaultAiModel?.id 
        }
        console.log(updateData)
        const snakeSettings = camelToSnake(updateData)

        const { error } = await supabase
          .from(tableName)
          .update(snakeSettings)
          .eq('id', settings.id)

        if (error) throw error

        // If the update was successful, update the local state
        this.updateSetting({ settings })
      } catch (error: any) {
        console.error('Error updating settings:', error.message)
        throw error
      }
    },
    updateSetting(settings: Partial<SettingsState>) {
      this.$state = { ...this.$state, ...settings }
      this.recordState()
    },
    resetSetting() {
      this.$state = defaultSetting()
      removeLocalState()
    },
    recordState() {
      setLocalState(this.$state)
    },
  },
})