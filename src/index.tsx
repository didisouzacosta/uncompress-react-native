import { NativeModules } from 'react-native';

type UncompressType = {
  multiply(a: number, b: number): Promise<number>;
};

const { Uncompress } = NativeModules;

export default Uncompress as UncompressType;
