import React, { useMemo, useState } from 'react';
import { StyleSheet, View, Button, ActivityIndicator } from 'react-native';
import { decompress } from 'uncompress';
import RNFS from 'react-native-fs';

const tempDir = RNFS.TemporaryDirectoryPath;
const documentDir = RNFS.DocumentDirectoryPath;
const zipFileUrl =
  'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-zip-file.zip';

export default function App() {
  const [filePath, setFilePath] = useState<string>();
  const [isLoading, setIsLoading] = useState(false);

  const disabled = useMemo(() => {
    if (!filePath) return true;
    return false;
  }, [filePath]);

  const downloadSample = async () => {
    setIsLoading(true);

    RNFS.downloadFile({
      fromUrl: zipFileUrl,
      toFile: `${tempDir}.sample-zip-file.zip`,
    })
      .promise.then(() => readFiles(tempDir))
      .then((files) => {
        if (files[0]) {
          setFilePath(files[0]);
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

  const extract = async () => {
    const destination = `${documentDir}/comic`;

    if (!filePath) {
      return;
    }

    try {
      await decompress({
        filePath,
        destination,
      });

      const sampleFiles = await readFiles(destination);

      console.log(sampleFiles);
    } catch (e) {
      console.log(e);
    }
  };

  return (
    <View style={styles.container}>
      <Button title="Download exemplo" onPress={() => downloadSample()} />
      {isLoading && <ActivityIndicator color="black" />}
      <Button
        title="Extrair arquivo"
        disabled={disabled}
        onPress={() => extract()}
      />
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
