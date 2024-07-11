// helper.ts

import { PostgrestResponse } from '@supabase/supabase-js';
import { supabase } from '@/utils/supabase';

export const fetchMajors = async (): Promise<Research.Major[]> => {
  try {
    const { data, error }: PostgrestResponse<Research.Major> = await supabase
      .from('majors')
      .select('*')
      .order('updated_at');

    if (error) {
      throw error;
    }

    return data || [];
  } catch (error: any) {
    console.error('Error fetching majors from Supabase:', error.message);
    throw error;
  }
};

export const insertMajor = async (major: Research.Major): Promise<Research.Major> => {
  try {
    const { data, error } = await supabase
      .from('majors')
      .insert([major])
      .select();

    if (error) {
      throw error;
    }

    const insertedMajor = data ? data[0] : null;

    if (!insertedMajor) {
      throw new Error('No data returned after insertion');
    }

    return insertedMajor;

  } catch (error: any) {
    console.error('Error inserting major into Supabase:', error.message);
    throw error;
  }
};

export const deleteMajor = async (id: string): Promise<void> => {
  try {
    const { error } = await supabase
      .from('majors')
      .delete()
      .eq('id', id);

    if (error) {
      throw error;
    }
  } catch (error: any) {
    console.error('Error deleting major from Supabase:', error.message);
    throw error;
  }
};

export const updateMajor = async (id: string, updates: Partial<Research.Major>): Promise<void> => {
  try {
    const { error } = await supabase
      .from('majors')
      .update(updates)
      .eq('id', id);

    if (error) {
      throw error;
    }
  } catch (error: any) {
    console.error('Error updating major in Supabase:', error.message);
    throw error;
  }
};
