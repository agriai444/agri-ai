import { PostgrestResponse } from '@supabase/supabase-js';
import { supabase } from '@/utils/supabase';
// import {fetchAllUniversities} from '@/utils/drizzle/index';
export const fetchTotalCount = async (): Promise<number> => {
  try {
    const { count, error } = await supabase
      .from('users')
      .select('*', { count: 'exact', head: true })

    if (error) {
      throw error;
    }
    // const allUniversities = await fetchAllUniversities();
    // console.log(allUniversities);
    // console.log('allUniversities:', yy);
    return count ? count[0] : 0;
  } catch (error: any) {
    console.error('Error fetching total count from Supabase:', error.message);
    throw error;
  }
};


export const fetchData = async ({ limit, offset }: { limit: number; offset: number }): Promise<User.UserData[]> => {
  try {
    const { data, error }: PostgrestResponse<User.UserData> = await supabase
    .from('users')
    .select('*')
    .order('updated_at')
    .range(offset, offset + limit - 1); 

    if (error) {
      throw error;
    }

    return data || [];
  } catch (error: any) {
    console.error('Error fetching users from Supabase:', error.message);
    throw error;
  }
};


export const insertData = async (university: User.UserData): Promise<User.UserData> => {
  try {
    const { data, error } = await supabase
      .from('users')
      .insert([university])
      .select();

    if (error) {
      throw error;
    }
    const insertedUniversity = data ? data[0] : null;

    if (!insertedUniversity) {
      throw new Error('No data returned after insertion');
    }

    return insertedUniversity

  } catch (error: any) {
    throw error;
  }
};

export const deleteData = async (id:  number): Promise<void> => {
  try {
    const { error } = await supabase
      .from('users')
      .delete()
      .eq('id', id);

    if (error) {
      throw error;
    }
  } catch (error: any) {
    throw error;
  }
};

export const updateData = async (id: number, updates: Partial<User.UserData>): Promise<void> => {
  try {
    const { error } = await supabase
      .from('users')
      .update(updates)
      .eq('id', id);

    if (error) {
      throw error;
    }
  } catch (error: any) {
    throw error;
  }
};
