import DeviceInfo from 'react-native-device-info';

export const appVersion = '2.2.2';

export const baseUrl = {
    baseUrl: '/api/v1/'
};

export let headers = {
    Accept: 'application/json',
    'Content-Type': 'application/json',
   // 'User-Agent': G_IS_IOS ? 'iphone' : 'android',
     "deviceModel": DeviceInfo.getModel(),
     "deviceName":DeviceInfo.getDeviceName(),
     "userAgent":DeviceInfo.getUserAgent(),
     "brand":DeviceInfo.getBrand()
};

export const netConfig = {
    appDomain:"https://download.528768.com/ios/game/valley",
    api: {
        musicJson: {url:"/music.json"}, //获取用户信息
    },
    map: {
        method: 'POST',
        headers: headers,
        follow: 20,
        timeout: 10000,
        size: 0
    },
    mapGet: {
        method: 'GET',
        headers: headers,
        follow: 20,
        timeout: 10000,
        size: 0
    },
    mapPut: {
        method: 'PUT',
        headers: headers,
        follow: 20,
        timeout: 10000,
        size: 0
    },
    mapDelete: {
        method: 'DELETE',
        headers: headers,
        follow: 20,
        timeout: 10000,
        size: 0
    }
};


export const UpDateHeadAppId =(newId)=> {
    headers.ClientId=newId;
    netConfig.map.headers.ClientId=newId;
    netConfig.mapGet.headers.ClientId=newId;
    netConfig.mapPut.headers.ClientId=newId;
    netConfig.mapDelete.headers.ClientId=newId;

};
