declare namespace APIAI {

    type inputOutputData = 'Text' | 'Image' | 'Audio' | 'Video' | 'Documents'
    interface CompanyAI {
      id?: string; // UUID
      name: string;
      companyUrl?: string; // Optional
      logoUrl?: string; // Optional
      apiUrl: string;
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
    }
  
    interface ModelInputDataAI {
      id: string; // UUID
      modelId: string; // UUID referencing ModelAI
      inputData: inputOutputData ; // Enum
    }
  
    interface ModelOutputDataAI {
      id: string; // UUID
      modelId: string; // UUID referencing ModelAI
      outputData: inputOutputData; // Enum
    }
  
  }
  