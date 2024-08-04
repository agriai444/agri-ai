import { supabase } from '@/utils/supabase';
import { camelToSnake, snakeToCamel } from '@/utils/functions';

export const fetchTotalCount = async (): Promise<number> => {
  try {
    const { count, error } = await supabase
      .from('ai_company')
      .select('*', { count: 'exact', head: true });

    if (error) {
      throw error;
    }
    return count ? count[0] : 0;
  } catch (error: any) {
    console.error('Error fetching total count from Supabase:', error.message);
    throw error;
  }
};

export const fetchData = async ({ limit, offset }: { limit: number; offset: number }): Promise<APIAI.CompanyAI[]> => {
  try {
    const { data, error } = await supabase
      .from('ai_company')
      .select('*')
      .order('updated_at')
      .range(offset, offset + limit - 1);

    if (error) {
      throw error;
    }

    const camelData = data?.map(snakeToCamel) || [];
    return camelData;
  } catch (error: any) {
    console.error('Error fetching companies from Supabase:', error.message);
    throw error;
  }
};

export const insertData = async (dataInserted: APIAI.CompanyAI): Promise<APIAI.CompanyAI> => {
  try {
 
    const snakeData =[dataInserted].map(camelToSnake);
        console.log(snakeData)
    const { data, error } = await supabase
      .from('ai_company')
      .insert(snakeData)
      .select();

    if (error) {
      throw error;
    }

    const inserted = data ? data[0] : null;

    if (!inserted) {
      throw new Error('No data returned after insertion');
    }

    return inserted;
  } catch (error: any) {
    throw error;
  }
};

export const deleteData = async (id: string): Promise<void> => {
  try {
    const { error } = await supabase
      .from('ai_company')
      .delete()
      .eq('id', id);

    if (error) {
      throw error;
    }
  } catch (error: any) {
    throw error;
  }
};

export const updateData = async (id: string, updates: Partial<APIAI.CompanyAI>): Promise<void> => {
  try {
    const { error } = await supabase
      .from('ai_company')
      .update(updates)
      .eq('id', id);

    if (error) {
      throw error;
    }
  } catch (error: any) {
    throw error;
  }
};
