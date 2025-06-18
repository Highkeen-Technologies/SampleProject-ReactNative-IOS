/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */
 import React, { useEffect, useState } from 'react';
import { SafeAreaView, StyleSheet, Text, View , NativeModules,Alert} from 'react-native';
import { startFridaMonitoring } from './src/security';
const { HelloMessage,SecurityCheck} = NativeModules;
import { APP_VERSION, AccessToken, BASE_URL, OS_TYPE, hashKey, secretKey } from './auth_provider/Config';
import apiClient from './api/apiClient';
function App() {
  const [name, setName] = useState(null);
  const [jailbreak, setJailbreak] = useState(null);
  const [emulator, setEmulator] = useState(null);
  useEffect(() => {
    HelloMessage.sayHello("Samik").then(setName);
    try{
      SecurityCheck.isJailBroken().then(setJailbreak);
      checkApi();
    }
    catch(e){

    }
   
    SecurityCheck.isEmulator().then(setEmulator);
    const monitor = startFridaMonitoring(5000); 
    return () => clearInterval(monitor); 
  }, []);
  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.row}>
        <Text> {name}</Text>
      </View>
      <View style={styles.row}>
        <Text>Jailbroken:</Text>
        <Text>{String(jailbreak)}</Text>
      </View>
      <View style={styles.row}>
        <Text>Emulator:</Text>
        <Text>{String(emulator)}</Text>
      </View>
    </SafeAreaView>
   
  );
}

function checkApi(){
  let formdata = new FormData();
      formdata.append('lang_code', 'Eng');
      formdata.append('app_ver', `${APP_VERSION}`);
      formdata.append('os_type', `${OS_TYPE}`);
      apiClient
        .post(`${BASE_URL}/app-version-check`, formdata, {
          headers: {
            'Content-Type': 'multipart/form-data',
            accesstoken: `${AccessToken}`,
          },
        })
        .then((response:any) => {
          return response;
        })
        .catch((error:any) => {
          //console.log('INSIDE CATCH', error);
          if (error.toString().includes('Network request failed')) {
            Alert.alert(
              'Secure connection error or network issue! Please try again later.',
            );
          } else {
            console.log('Error:', error);
          }
        });
}


const styles = StyleSheet.create({
  container: { flex: 1, justifyContent: 'center', alignItems: 'center' },
  header: { fontSize: 22, marginBottom: 20 },
  row: { flexDirection: 'row', marginVertical: 8, gap: 10 },
});

export default App;