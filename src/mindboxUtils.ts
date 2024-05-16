import {Alert, Platform} from 'react-native';
import MindboxSdk from 'mindbox-sdk';

const configuration = {
  domain: 'api.mindbox.ru',
  endpointId: Platform.OS === 'ios' ? 'IOS_ENDPOINT' : 'ANDROID_ENDPOINT',
  subscribeCustomerIfCreated: true,
  shouldCreateCustomer: true,
};

export const initializeMindbox = async (
  setDeviceUUID: (uuid: string) => void,
) => {
  try {
    await MindboxSdk.initialize(configuration);

    MindboxSdk.getToken(token => {
      console.log('getToken', token);
    });

    MindboxSdk.getDeviceUUID(uuid => {
      console.log('getDeviceUUID', uuid);
      setDeviceUUID(uuid);
    });

    MindboxSdk.onPushClickReceived(
      (pushUrl: string | null, pushPayload: string | null) => {
        const data = `pushUrl: ${pushUrl}, pushPayload: ${pushPayload}`;
        Alert.alert('onPushClickReceived', data);
      },
    );
  } catch (error) {
    console.log(error);
  }
};
