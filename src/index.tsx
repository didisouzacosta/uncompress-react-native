import { NativeModules } from 'react-native';

const { Uncompress } = NativeModules;

export const decompress = async ({
  filePath,
  destination,
  overwrite = true,
  password = undefined,
}: {
  filePath: string;
  destination: string;
  overwrite?: boolean;
  password?: string;
}) => {
  await Uncompress.decompress(filePath, destination, overwrite, password);
};
