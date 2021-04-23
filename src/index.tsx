import { NativeModules } from 'react-native';

const { Uncompress } = NativeModules;

type ExtractParams = {
  filePath: string;
  destination: string;
  overwrite?: boolean;
  password?: string;
};

type IsProtectedParams = Pick<ExtractParams, 'filePath'>;

const extract = async ({
  filePath,
  destination,
  overwrite = true,
  password = undefined,
}: ExtractParams) => {
  await Uncompress.extract(filePath, destination, overwrite, password);
};

const isProtected = async ({
  filePath,
}: IsProtectedParams): Promise<boolean> => {
  return await Uncompress.isProtected(filePath);
};

export default {
  extract,
  isProtected,
};
