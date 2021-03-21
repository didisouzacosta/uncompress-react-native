import React, { useState } from 'react';
import { StyleSheet, View, Button, ActivityIndicator } from 'react-native';
import { decompress } from 'uncompress';
import { Paths, readFilesIn, downloadFile, unlink } from './utils/file-manager';

const fileUrl =
  'https://github.com/Free-Comic-Reader/Landing-Page-Free-Comic-Reader/raw/main/assets/sample_comic.cbr';

export default function App() {
  const [isLoading, setIsLoading] = useState(false);

  const clearTempAndDocumentDir = async () => {
    const tempFiles = await readFilesIn(Paths.temp);
    const documentFiles = await readFilesIn(Paths.document);

    const files = tempFiles.concat(documentFiles);

    files.forEach(async (file) => {
      await unlink(file.path);
    });
  };

  const downloadSample = async (): Promise<void> => {
    const destinationPath = `${Paths.temp}/sample_comic.cbr`;

    setIsLoading(true);

    await clearTempAndDocumentDir();

    return downloadFile({
      fileUrl,
      destinationPath,
    })
      .then(() => extract(destinationPath))
      .finally(() => setIsLoading(false));
  };

  const readFiles = async (path: string): Promise<string[]> => {
    const files = await readFilesIn(path);
    return files.map((file) => file.path);
  };

  const extract = async (filePath: string) => {
    const destination = `${Paths.temp}/comic`;

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
