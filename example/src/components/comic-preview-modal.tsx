import React, { memo } from 'react';
import {
  SafeAreaView,
  View,
  Button,
  Image,
  FlatList,
  Modal,
  StyleSheet,
  Dimensions,
} from 'react-native';

type Props = {
  files: string[];
  visible: boolean;
  close(): void;
};

const ComicPreviewModal = ({ visible, files, close }: Props) => {
  const renderItem = (file: string) => {
    return (
      <View style={styles.page}>
        <Image
          style={styles.image}
          source={{ uri: file }}
          resizeMode="contain"
        />
      </View>
    );
  };

  return (
    <Modal visible={visible} animationType="slide">
      <SafeAreaView style={styles.container}>
        <FlatList
          horizontal
          pagingEnabled
          showsHorizontalScrollIndicator={false}
          data={files}
          keyExtractor={(_, key) => `${key}`}
          renderItem={({ item }) => renderItem(item)}
        />
        <Button title="Close" onPress={() => close()} />
      </SafeAreaView>
    </Modal>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  page: {
    width: Dimensions.get('screen').width,
  },
  image: {
    width: '100%',
    height: '100%',
  },
});

export default memo(ComicPreviewModal);
