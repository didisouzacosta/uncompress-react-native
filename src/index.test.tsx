jest.mock('react-native', () => {
  return {
    NativeModules: {
      Uncompress: {
        extract: jest.fn(),
      },
    },
  };
});

import { NativeModules } from 'react-native';
import Uncompress from './';

describe('Uncompress', () => {
  afterEach(() => {
    jest.resetAllMocks();
  });

  it('ensure default values', async () => {
    const extractMock = jest.spyOn(NativeModules.Uncompress, 'extract');

    await Uncompress.extract({
      filePath: 'test_file.cbz',
      destination: 'temp',
    });

    expect(extractMock).toBeCalledWith(
      'test_file.cbz',
      'temp',
      true,
      undefined
    );
  });

  it('should decompress files if extract successful', async () => {
    const extractMock = jest.spyOn(NativeModules.Uncompress, 'extract');

    await Uncompress.extract({
      filePath: 'test_file.cbz',
      destination: 'temp',
      overwrite: true,
      password: '123',
    });

    expect(extractMock).toBeCalledTimes(1);
    expect(extractMock).toBeCalledWith('test_file.cbz', 'temp', true, '123');
  });

  it('throw error if extract fails', async () => {
    const extractMock = jest.spyOn(NativeModules.Uncompress, 'extract');
    extractMock.mockRejectedValueOnce('Simulation Error');

    await expect(
      Uncompress.extract({
        filePath: 'test_file.cbz',
        destination: 'temp',
      })
    ).rejects.toEqual('Simulation Error');
  });
});
