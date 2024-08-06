import { supabase } from '@/utils/supabase';
import { camelToSnake, snakeToCamel } from '@/utils/functions';

export const fetchData = async ({ limit, offset }: { limit: number; offset: number }): Promise<{ data: APIAI.CompanyAI[], totalCount: number }> => {
  try {
    const { data, count, error } = await supabase
      .from('ai_company')
      .select('*', { count: 'exact' }) // Include count option
      .order('updated_at')
      .range(offset, offset + limit - 1);

    if (error) {
      throw error;
    }

    const camelData = data?.map(snakeToCamel) || [];
    return { data: camelData as APIAI.CompanyAI[], totalCount: count || 0 };
  } catch (error: any) {
    console.error('Error fetching companies from Supabase:', error.message);
    throw error;
  }
};


export const insertData = async (dataInserted: APIAI.CompanyAI): Promise<APIAI.CompanyAI> => {
  try {
 
    const snakeData =[dataInserted].map(camelToSnake);
       
    const { data, error } = await supabase
      .from('ai_company')
      .insert(snakeData)
      .select();

    if (error) {
      throw error;
    }

    const inserted = data ? data[0] : null;
    console.log("inserted", inserted)
    if (!inserted) {
      throw new Error('No data returned after insertion');
    }
    const camelData =[inserted].map(snakeToCamel);
    console.log("camelData",camelData)
    return camelData[0] as APIAI.CompanyAI;
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

export const updateData = async (data:APIAI.CompanyAI): Promise<void> => {
  try {
    const snakeData =[data].map(camelToSnake);
    console.log(snakeData)
    const { error } = await supabase
      .from('ai_company')
      .update(snakeData[0])
      .eq('id', data.id);

    if (error) {
      throw error;
    }
  } catch (error: any) {
    throw error;
  }
};
