import { defineStore } from 'pinia'
import { supabase } from '@/utils/supabase'

interface DashboardState {
  clientCount: number
  expertCount: number
  adminCount: number
  aiCompanyCount: number
  aiModelCount: number
  questionCount: number
  convAICount: number
  convExpertCount: number
}

export const useDashboardStore = defineStore('dashboard', {
  state: (): DashboardState => ({
    clientCount: 0,
    expertCount: 0,
    adminCount: 0,
    aiCompanyCount: 0,
    aiModelCount: 0,
    questionCount: 0,
    convAICount: 0,
    convExpertCount:0
  }),
  actions: {
    async fetchDashboardData() {
      try {
        const [
          { count: clientCount },
          { count: expertCount },
          { count: adminCount },
          { count: aiCompanyCount },
          { count: aiModelCount },
          { count: questionCount },
          { count: convClientCount },
          { count: convExpertCount },
        ] = await Promise.all([
          supabase.from('users').select('*', { count: 'exact', head: true }).eq('user_type', 'Client'),
          supabase.from('users').select('*', { count: 'exact', head: true }).eq('user_type', 'Agri-Expert'),
          supabase.from('users').select('*', { count: 'exact', head: true }).eq('user_type', 'Admin'),
          supabase.from('ai_company').select('*', { count: 'exact', head: true }),
          supabase.from('ai_model').select('*', { count: 'exact', head: true }),
          supabase.from('question').select('*', { count: 'exact', head: true }),
          supabase.from('conversation').select('*', { count: 'exact', head: true }).eq('type', 'AI'),
          supabase.from('conversation_with_questions').select('*', { count: 'exact', head: true }),
        ])

        this.clientCount = clientCount || 0
        this.expertCount = expertCount || 0
        this.adminCount = adminCount || 0
        this.aiCompanyCount = aiCompanyCount || 0
        this.aiModelCount = aiModelCount || 0
        this.questionCount = questionCount || 0
        this.convAICount = convClientCount || 0
        this.convExpertCount = convExpertCount || 0
      } catch (error) {
        console.error('Error fetching dashboard data:', error)
      }
    },
  },
})