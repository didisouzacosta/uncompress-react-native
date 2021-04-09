import { Platform } from 'react-native';
import RNFS from 'react-native-fs';

type File = Pick<RNFS.ReadDirItem, 'name' | 'path' | 'isDirectory'>;

export const Paths = {
  temp: RNFS.TemporaryDirectoryPath,
  document: RNFS.DocumentDirectoryPath,
};

export const readFilesIn = async (directory: string): Promise<File[]> => {
  const files = await RNFS.readDir(directory);
  return files.map(({ name, path, isDirectory }) => {
    let prefix = Platform.OS === 'ios' ? '' : 'file://';
    let finalPath = `${prefix}${path}`;
    return { name, path: finalPath, isDirectory };
  });
};

export const downloadFile = async ({
  fileUrl,
  destinationPath,
}: {
  fileUrl: string;
  destinationPath: string;
}): Promise<void> => {
  const result = await RNFS.downloadFile({
    fromUrl: fileUrl,
    toFile: destinationPath,
  }).promise;

  if (result.statusCode === 200) {
    return Promise.resolve();
  }

  return Promise.reject(new Error('Não foi possível baixar o arquivo'));
};

export const unlink = async (filePath: string): Promise<void> => {
  return RNFS.unlink(filePath);
};

export const exists = async (filePath: string): Promise<Boolean> => {
  return RNFS.exists(filePath);
};
