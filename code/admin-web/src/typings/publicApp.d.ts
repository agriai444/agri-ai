declare namespace PublicApp {

    type TypeService = "text" | "image" | "research" | "video" | "audio";
    type TypeServiceText = "research" | "present" | "cv";
    type TypeAdded = 'default' | 'personal';
    type STATE = 'Running' | 'Busy' | 'Stopped' | 'Unknown';



    type PublicAttribute = {
        id?: number
        createdAt: Date
        updatedAt: Date
    }


    type Provider = PublicAttribute & {
        name: string;
        description: string;
        providerType: string;
        isActive: boolean;
        state: "Pending" | "Stop" | "Running";
        priority: number;
        isMessageSystem: boolean;
        isArabic: boolean;
        isAuth: boolean;
        isCookies: boolean;
        isStream: boolean;
        isParameter: boolean;
    };

    type CompanyAI = PublicAttribute & {
        name: string;
        label: string;
        isActive: boolean;

        description: string;
        url: string;
    };

    type Character = PublicAttribute & {
        userId: string;
        name: string;
        isActive: boolean;
        typeAdded: TypeAdded;
    };

    type Prompt = PublicAttribute & {
        characterId: number;
        userId: string;
        text: string;
        isActive: boolean;

    };

    type MessageUser = PublicAttribute & {
        text: string
        convId?: string
        inversion?: boolean
    }

    type ReplyMessage = PublicAttribute & {
        text: string
        error: boolean
        loading: boolean
        isLike: null | boolean
        conversationOptions?: Chat.ChatTextRequest | null
        requestOptions: { prompt: string; options?: Chat.ChatTextRequest | null }
        inversion?: boolean
    }

    type ReplyImage = PublicAttribute & {
        images: [string]
        error: boolean
        loading: boolean
        isLike: null | boolean
        inversion?: boolean
    }

    type Chat = {
        messageUser: MessageUser
        replyAi: ReplyMessage[] | ReplyImage[]
    }

    type Conversation = {
        id?: string
        title: string
        model?: Model
        listChat: Chat[]
        isEdit: boolean
        isPin: boolean
        isFavorite: boolean
        isLike: null | boolean
        createdAt: Date
        updatedAt: Date
        userId?: string
    }

    type resConversation = {
        id: string
        title: string
        model: Model
        listChat: Chat[]
        isEdit: boolean
        isPin: boolean
        isFavorite: boolean
        isLike: null | boolean
        createdAt: Date
        updatedAt: Date
        userId?: string
    }
}

declare namespace companyAi {
    type companyAi = PublicApp.PublicAttribute & {
        providerId: number;
        companyAiId: number;
        name: string;
        label: string;
        type: TypeService;
        isActive: boolean;
        state: "Pending" | "Stop" | "Running";
        description: string;
    }

}


declare namespace Model {
    type Model = PublicApp.PublicAttribute & {
        providerId?: number;
        companyAiLabel: string;
        name: string;
        label: string;
        type: TypeService;
        isActive: boolean;
        state: "Pending" | "Stop" | "Running";
        description: string;
    }

    type ResModel = {
        companyAiLabel: string;
        name: string;
        label: string;
        type: TypeService;
        isActive: boolean;
        state: "Pending" | "Stop" | "Running";
    }


}
declare namespace Conv {

    type reqConv = {
        id: string
        userId: string
    }
 
    type resConv = {
        id: string //uuid example (dcb2d2ae-4039-4172-a347-7d324337eca8)
        title: string
        isEdit: boolean
        isPin: boolean
        isFavorite: boolean
        isLike: null | boolean
        createdAt: Date
        updatedAt: Date
        userId: string  //uuid example (dcb2d2ae-4039-4172-a347-7d324337eca8)
        type: "text" | "image";
        model: {
            id: number
            name: string;
            label: string;
            type: "text" | "image";
            isActive: boolean;
            state: "Pending" | "Stop" | "Running";
            provider?: {
                id: number
                name: string;
                providerType: string;
                isActive: boolean;
                state: "Pending" | "Stop" | "Running";
                isMessageSystem: boolean;
                isArabic: boolean;
                isAuth: boolean;
                isCookies: boolean;
                isStream: boolean;
                isParameter: boolean;
            }
            companyAi?: {
                id: number;
                name: string;
                label: string;
                isActive: boolean;
            }
        }
        chat: {
            textChat: [
                messageUser: {
                    id: number
                    text: string
                    createdAt: Date
                    updatedAt: Date
                    inversion: boolean
                },
                messageAI: [{
                    id: number
                    text: string
                    inversion: boolean
                    error: boolean
                    loading: boolean
                    isLike: null | boolean
                    conversationOptions?: {
                        conversationId?: string
                        parentMessageId?: string
                    } | null
                    requestOptions: {
                        prompt: string; options?: {
                            conversationId?: string
                            parentMessageId?: string
                        } | null
                    }

                    createdAt: Date
                    updatedAt: Date
                }]

            ] | null,
            imageChat: [
                messageUser: {
                    id: number
                    text: string
                    inversion: boolean
                    createdAt: Date
                    updatedAt: Date
                },
                messageAI: [{
                    id: number
                    images: [string]
                    inversion: boolean
                    error: boolean
                    loading: boolean
                    isLike: null | boolean
                    createdAt: Date
                    updatedAt: Date
                }
                ]
            ] | null
        }
    }
}