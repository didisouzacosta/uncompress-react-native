import React, { useState } from 'react';
import { StyleSheet, View, Button, ActivityIndicator } from 'react-native';
import { decompress } from 'uncompress';
import RNFS from 'react-native-fs';

const tempDir = RNFS.TemporaryDirectoryPath;
const documentDir = RNFS.DocumentDirectoryPath;
const fileUrl =
  'https://github.com/Free-Comic-Reader/Landing-Page-Free-Comic-Reader/raw/main/assets/sample_comic.cbr';

export default function App() {
  const [isLoading, setIsLoading] = useState(false);

  const clearTempAndDocumentDir = async () => {
    const tempFiles = await RNFS.readDir(tempDir);
    const documentFiles = await RNFS.readDir(documentDir);

    const files = tempFiles.concat(documentFiles);

    files.forEach(async (file) => {
      await RNFS.unlink(file.path);
    });
  };

  const downloadSample = async () => {
    setIsLoading(true);

    await clearTempAndDocumentDir();

    const fromUrl = fileUrl;
    const toFile = `${tempDir}/sample_comic.cbr`;

    RNFS.downloadFile({
      fromUrl,
      toFile,
    })
      .promise.then((infos) => {
        if (infos.statusCode === 200) {
          extract(toFile);
        } else {
          console.log(
            `Não foi possível fazer o download do arquivo ${fileUrl}`
          );
        }
        setIsLoading(false);
      })
      .catch((e) => {
        console.log(e);
        setIsLoading(false);
      });
  };

  const readFiles = async (path: string): Promise<string[]> => {
    const files = await RNFS.readDir(path);
    return files.map((file) => file.path);
  };

  const extract = async (filePath: string) => {
    const destination = `${documentDir}/comic`;

    try {
      await decompress({
        filePath,
        destination,
      });

      const extractedFiles = await readFiles(destination);

      console.log(extractedFiles);

      const comicDir = extractedFiles[0];

      if (!comicDir) {
        return;
      }

      const comicFiles = await readFiles(comicDir);

      console.log(comicFiles);
    } catch (e) {
      console.log(e);
    }
  };

  return (
    <View style={styles.container}>
      <Button
        title="Download e extração do exemplo"
        onPress={() => downloadSample()}
      />
      {isLoading && <ActivityIndicator color="black" />}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
