<script setup lang='ts'>
import { onBeforeMount, onUnmounted, watch } from 'vue'
import { useRoute } from 'vue-router'
import { useChatStore } from '@/store'
import { useMessage } from 'naive-ui'
const chatStore = useChatStore()
const route = useRoute()
let { uuid } = route.params as { uuid: string }
const message = useMessage()
import { t } from '@/locales'

async function getChat() {
  try {
    chatStore.loadingChat = true
    await chatStore.getListChatAction()
    chatStore.loadingChat = false
  } catch (error: any) {
    console.error(error.message)
    message.error(t('chat.deleteFailed') + ' ' + uuid)
    await chatStore.resetChatState()
    chatStore.loadingChat = false
  }
}

onBeforeMount(async () => {
  chatStore.currentConversation.id = uuid
  await getChat()
})

watch(() => chatStore.currentConversation.id, async (newUuid) => {
  chatStore.handelSelectAction(newUuid)
  await getChat()
})


</script>
