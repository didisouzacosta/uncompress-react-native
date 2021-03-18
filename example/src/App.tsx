import React from 'react';
import { StyleSheet, View, Button, Alert } from 'react-native';
import { decompress } from 'uncompress';

export default function App() {
  const extract = () => {
    decompress({
      filePath: 'teste.zip',
      destination: '',
    })
      .then(() => Alert.alert('deu certo'))
      .catch((e) => Alert.alert(e.message));
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
