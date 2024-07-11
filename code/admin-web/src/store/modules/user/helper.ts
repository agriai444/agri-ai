import { ss } from '@/utils/storage'
import { Session, User } from '@supabase/supabase-js'

const LOCAL_NAME = 'userStorage'
export interface UserInfo {
    user: User | null
    session: Session | null
    avatar: string
    name: string
    description: string
}

export interface UserState {
  userInfo: UserInfo
}



export function defaultSetting(): UserState {
  const defaultUserInfo: UserInfo = {
    session: null,
    user: null,
    avatar: '',
    name: 'Demo User',
    description: 'Your Freedom',
  }
  return {
    userInfo: defaultUserInfo,
  }
}

export function getLocalState(): UserState {
  const localSetting: UserState | undefined = ss.get(LOCAL_NAME)
  return { ...defaultSetting(), ...localSetting }
}

export function setLocalState(setting: UserState): void {
  ss.set(LOCAL_NAME, setting)
}
