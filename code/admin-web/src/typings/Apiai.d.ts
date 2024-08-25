declare namespace APIAI {

    type inputOutputData = 'Text' | 'Image' | 'Audio' | 'Video' | 'Documents'
    interface CompanyAI {
      id?: string; // UUID
      name: string;
      apiUrl: string;
      apiKey:string;
      companyUrl?: string; // Optional
      logoUrl?: string; // Optional
      
      isActivate: boolean;
      createdAt: string; // Timestamp
      updatedAt: string; // Timestamp
    }
  
    interface ModelAI {
      id?: string; // UUID
      companyId: string; // UUID referencing CompanyAI
      name: string;
      modelCode: string;
      description?: string; // Optional
      isActivate: boolean;
      version?: string; // Optional
      createdAt: string; // Timestamp
      updatedAt: string; // Timestamp

          // New fields
          inputData?: inputOutputData[];
          outputData?: inputOutputData[];
    maxTokens?: number;
    temperature?: number;
    topP?: number;
    topK?: number;
    repetitionPenalty?: number;
    stop?: string[];
    stream?: boolean;
    }
  
 
    interface Dashboard {
      clientCount: number;
      expertCount: number;
      adminCount: number;
      aiCompanyCount: number;
      aiModelCount: number;
      questionCount: number;
    }
  }
  