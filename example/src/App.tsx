import React from 'react';
import { StyleSheet, View, Button, Alert } from 'react-native';
import { decompress } from 'uncompress';

export default function App() {
  const extract = async () => {
    try {
      await decompress({
        filePath: 'teste.zip',
        destination: '',
      });
      Alert.alert('O arquivo foi descomprimido com sucesso');
    } catch (e) {
      Alert.alert(e.message);
    }
  };

  return (
    <View style={styles.container}>
      <Button title="Extrair arquivos" onPress={() => extract()} />
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
