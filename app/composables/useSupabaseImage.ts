export function useSupabaseImage() {
  // TODO: Descomentar cuando Supabase esté habilitado
  // const supabase = useSupabaseClient()

  function getPublicUrl(bucket: string, path: string) {
    // const { data } = supabase.storage.from(bucket).getPublicUrl(path)
    // return data.publicUrl
    return `https://placeholder.com/${bucket}/${path}`; // Mock temporal
  }

  async function getSignedUrl(bucket: string, path: string, expiresIn = 3600) {
    // const { data, error } = await supabase.storage
    //   .from(bucket)
    //   .createSignedUrl(path, expiresIn)
    // if (error) throw error
    // return data.signedUrl
    return `https://placeholder.com/${bucket}/${path}?expires=${expiresIn}`; // Mock
  }

  async function upload(bucket: string, path: string, file: File) {
    // const { error } = await supabase.storage
    //   .from(bucket)
    //   .upload(path, file, { upsert: true })
    // if (error) throw error
    console.log("upload mocked", bucket, path, file.name);
    return getPublicUrl(bucket, path);
  }

  return { getPublicUrl, getSignedUrl, upload };
}
