import { createClient } from '@supabase/supabase-js'
// import { Database } from './database.types'
// export const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
// export const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY

export const supabaseUrl = "https://fvpmikdmeystnnxnloqe.supabase.co" //import.meta.env.VITE_SUPABASE_URL
export const supabaseAnonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ2cG1pa2RtZXlzdG5ueG5sb3FlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTY5NDQ1OTYsImV4cCI6MjAxMjUyMDU5Nn0.2M-NejfxfGlU1guyRIfNKL7kE94WysWj_T-NmFXypSg"//import.meta.env.VITE_SUPABASE_ANON_KEY

//<Database>
export const supabase = createClient(supabaseUrl, supabaseAnonKey)
export const supabaseUrlImage = `${supabaseUrl}/storage/v1/object/public`

import axios from "axios";
import type { AxiosRequestConfig } from "axios";

export async function uploadFile(file: File, bucket: string,path:string, name: string, config?: AxiosRequestConfig) {
  // Create form data
  const blob = new Blob([file], { type: null });
  const formData = new FormData();
  formData.append('cacheControl', '3600');
//   formData.append('', blob);
  formData.append('file', blob, name);
  const url = `${supabaseUrl}/storage/v1/object/${bucket}/${path}/${encodeURIComponent(name)}`;
  return axios.post(
    url,
    formData,
    {
      headers: {
        "Content-Type": "multipart/form-data",
        // @ts-ignore
        ...supabase.headers,
      },
      onUploadProgress: config?.onUploadProgress,
      onDownloadProgress: config?.onDownloadProgress,
    }
  );
}


// import axios, { AxiosRequestConfig } from "axios";

// const customRequest = async ({
//   file,
//   data,
//   headers,
//   withCredentials,
//   action,
//   onFinish,
//   onError,
//   onProgress,
// }: UploadCustomRequestOptions) => {
//   const formData = new FormData();
//   if (data) {
//     Object.keys(data).forEach((key) => {
//       formData.append(
//         key,
//         data[key as keyof UploadCustomRequestOptions['data']]
//       );
//     });
//   }
//   formData.append(file.name, file.file as File)

//   try {
//     const path = 'University';
//     const bucket = 'research';

//     const url = `${supabaseUrl}/storage/v1/object/${bucket}/${path}`;
//     const config: AxiosRequestConfig = {
//       headers: {
//         ...supabase.headers,
//         "Content-Type": "multipart/form-data",
//       },
//       onUploadProgress: (progressEvent) => {
//         const percent = Math.round((progressEvent.loaded / progressEvent.total) * 100);
//         onProgress({ percent });
//       },
//     };

//     const response = await axios.post(url, file.file, config);

//     console.log("Upload complete");
//     console.log(response.data); // Assuming the server responds with data

//     onFinish();
//   } catch (error) {
//     console.error("File upload failed", error);
//     message.error(error.message);
//     onError();
//   }
// };


// const customRequest = async ({
//   file,
//   data,
//   headers,
//   withCredentials,
//   action,
//   onFinish,
//   onError,
//   onProgress,
// }: UploadCustomRequestOptions) => {
//   const formData = new FormData();
//   if (data) {
//     Object.keys(data).forEach((key) => {
//       formData.append(
//         key,
//         data[key as keyof UploadCustomRequestOptions['data']]
//       );
//     });
//   }
//   formData.append(file.name, file.file as File)

//   try {
//     const path = 'University';
//   const bucket = 'research';

//   const data = await uploadFile(
//   file.file,
//   bucket,
//   path,
// file.name,
//   {
//     onUploadProgress: (evt) => {
//       const _progress = (evt.loaded / (evt.total || Infinity)) * 100;
//       console.log(_progress)
//       setProgress(_progress)
//     }
//   }
// );

//   catch (error) {
//     console.log(error)
//     message.error(error.message);
//     onError();
//   }

// }




// const customRequest = async ({
//   file,
//   data,
//   headers,
//   withCredentials,
//   action,
//   onFinish,
//   onError,
//   onProgress,
// }: UploadCustomRequestOptions) => {

//   const blob = new Blob([file.file!], { type: "image/*" }); // Assuming 'file' contains image data
// const formData = new FormData();
// formData.append('cacheControl', '3600');
// formData.append('image', blob, file.name); // Adjust the field name and file name as needed


//   try {
//     console.log( "formData",  formData)
//     const path = 'University';
//     const bucket = 'research';
//     const uploadUrl = `${supabaseUrl}/storage/v1/object/${bucket}/${path}/${file.name}`;

//     const response = await axios.post(uploadUrl, formData, {
//       headers: {
//         'Content-Type': 'multipart/form-data',
//         'Authorization': supabaseAnonKey,
//         ...headers,
//       },
//       onUploadProgress: (progressEvent) => {
//         const percentCompleted = Math.round((progressEvent.loaded * 100) / progressEvent.total);
//         onProgress({ percent: percentCompleted });
//       },
//     });

//     console.log(response.data);
//     message.success("Done");
//     model.value.image = response.data.path;
//     console.log(model.value.image);
//     onFinish();
//   } catch (error: any) {
//     console.error(error);
//     message.error(error.message);
//     onError();
//   }
// }
