import React, { useState } from 'react';
import { StyleSheet, View, Button, ActivityIndicator } from 'react-native';
import Uncompress from 'uncompress';
import ComicPreviewModal from './components/comic-preview-modal';
import { Paths, readFilesIn, downloadFile, unlink } from './utils/file-manager';

export default function App() {
  const [isLoading, setIsLoading] = useState(false);
  const [visibleModal, setVisibleModal] = useState(false);
  const [comics, setComic] = useState<string[]>([]);

  const clearTempAndDocumentDir = async () => {
    const tempFiles = await readFilesIn(Paths.temp);
    const documentFiles = await readFilesIn(Paths.document);

    const files = tempFiles.concat(documentFiles);

    files.forEach(async (file) => {
      await unlink(file.path);
    });
  };

  const downloadRarSample = async (): Promise<void> => {
    const fileName = 'sample_comic.cbz';
    const fileUrl =
      'https://github.com/Free-Comic-Reader/Landing-Page-Free-Comic-Reader/raw/main/assets/' +
      fileName;
    const destinationPath = Paths.temp + fileName;

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
    const destination = Paths.temp + 'comic';

    try {
      await Uncompress.extract({
        filePath,
        destination,
      });

      const extractedFiles = await readFiles(destination);
      const comicDir = extractedFiles[0];

      if (!comicDir) {
        return;
      }

      const files = await readFiles(comicDir);
      const sortedFiles = files.sort((a, b) => (a < b ? -1 : 1));

      setComic(sortedFiles);
      setVisibleModal(true);
    } catch (e) {
      console.log(e);
    }
  };

  return (
    <>
      <ComicPreviewModal
        visible={visibleModal}
        files={comics}
        close={() => setVisibleModal(false)}
      />
      <View style={styles.container}>
        <Button
          title="Extrair e visualizar"
          onPress={() => downloadRarSample()}
        />
        {isLoading && <ActivityIndicator color="black" />}
      </View>
    </>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
