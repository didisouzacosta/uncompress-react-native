import { NativeModules } from 'react-native';

const { Uncompress } = NativeModules;

const extract = async ({
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
  await Uncompress.extract(filePath, destination, overwrite, password);
};

export default {
  extract,
};
