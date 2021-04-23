jest.mock('react-native', () => {
  return {
    NativeModules: {
      Uncompress: {
        extract: jest.fn(),
        isProtected: jest.fn(),
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

  describe('Extract', () => {
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

  describe('IsProtected', () => {
    it('Return true if the file is protected', async () => {
      const isProtectedMock = jest.spyOn(
        NativeModules.Uncompress,
        'isProtected'
      );
      isProtectedMock.mockResolvedValueOnce(true);

      const isProtected = await Uncompress.isProtected({
        filePath: 'teste_file.cbz',
      });

      expect(isProtected).toBe(true);
    });

    it('Return false if the file is not protected', async () => {
      const isProtectedMock = jest.spyOn(
        NativeModules.Uncompress,
        'isProtected'
      );
      isProtectedMock.mockResolvedValueOnce(false);

      const isProtected = await Uncompress.isProtected({
        filePath: 'teste_file.cbz',
      });

      expect(isProtected).toBe(false);
    });

    it('Throw error if isProtected fails', async () => {
      const isProtectedMock = jest.spyOn(
        NativeModules.Uncompress,
        'isProtected'
      );
      isProtectedMock.mockRejectedValueOnce('Simulation Error');

      await expect(
        Uncompress.isProtected({ filePath: 'test_file.cbz' })
      ).rejects.toEqual('Simulation Error');
    });
  });
});
