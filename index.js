import * as BaseConfig from './js/common/global/BaseConfig'
import Storage from './js/common/global/TCStorage';
import {AppRegistry} from 'react-native';
import App from './App';
import {name as appName} from './app.json';

;


AppRegistry.registerComponent(appName, () => App);
