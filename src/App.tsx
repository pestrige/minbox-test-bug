import React, {useEffect, useState} from 'react';
import {
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  View,
} from 'react-native';
import {Colors, Header} from 'react-native/Libraries/NewAppScreen';

import {initializeMindbox} from './mindboxUtils.ts';

function App(): React.JSX.Element {
  const [deviceUUID, setDeviceUUID] = useState('');

  useEffect(() => {
    initializeMindbox(setDeviceUUID);
  }, []);

  return (
    <SafeAreaView style={styles.background}>
      <StatusBar barStyle={'dark-content'} backgroundColor={Colors.lighter} />
      <ScrollView
        contentInsetAdjustmentBehavior="automatic"
        style={styles.background}>
        <Header />
      </ScrollView>
      <View style={styles.content}>
        <Text style={styles.title}>Device UUID:</Text>
        <Text selectable={true}>{deviceUUID}</Text>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  background: {
    backgroundColor: Colors.lighter,
  },
  content: {
    backgroundColor: Colors.white,
    padding: 16,
    gap: 8,
  },
  title: {
    fontSize: 18,
    fontWeight: 'bold',
  },
});

export default App;
