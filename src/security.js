import { NativeModules, Alert } from 'react-native';

const { FridaDetector } = NativeModules;

export async function checkSecurityStatusOnce() {
  try {
   // console.log("Checking frida detection");
    const isFridaDetected = await FridaDetector.isFridaDetected();
    if (isFridaDetected) {
      Alert.alert("Security Alert", "Frida or suspicious debugger detected!");
    }
  } catch (e) {
    console.error("Frida check failed:", e);
  }
}

export function startFridaMonitoring(intervalMs = 5000) {
  checkSecurityStatusOnce(); // Initial check
  return setInterval(checkSecurityStatusOnce, intervalMs);
}
