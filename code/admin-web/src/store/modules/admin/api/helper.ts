import { ss } from '@/utils/storage'
const LOCAL_NAME = 'chatStorage'
import { useUserStore } from '@/store';
export function defaultCurrentConversation(): Chat.CompanyAI {
    const userStore = useUserStore();
    const userId: string = userStore.userInfo!.user!.id!;
    const localState: Chat.CompanyAI | undefined = getLocalState();
    console.log("localState", localState)
    const init: Chat.ResConv = {
      id: "",
      title: "",
      lang: localState?.currentConversation?.lang ?? 'en',
      isEdit: false,
      isPin: false,
      isFavorite: false,
      isLike: null,
      type: localState?.currentConversation?.type ?? 'text',
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
      userId: userId,
      modelInfo: null,
      isOptionSelectEnable: false,
      chat: [],
    };

    return init;

}


export function defaultState(): Chat.CompanyAI {

  return {
    listConversation: [],
    currentConversation: defaultCurrentConversation(),
    listModel: [],
    isShowSelect: true,
    loadingConversations: false,
    loadingChat: false,
    loadingMessage: false,
    isErrorResponse: false,
    currentPromptUser:''
  }
}


export function getLocalState(): Chat.CompanyAI | undefined {
  const localState:Chat.CompanyAI | undefined  = ss.get(LOCAL_NAME)
 
  return   localState 

}


export function setLocalState(state: Chat.CompanyAI) {

  ss.set(LOCAL_NAME, state)

}

