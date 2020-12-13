import {Provider} from 'mobx-react';
import {observer} from 'mobx-react';
import React, {Component} from 'react';
import {
    StyleSheet,
    View,
    StatusBar, SafeAreaView,
} from 'react-native';
import Storage from './js/common/global/TCStorage';
import G_Config from './js/common/global/G_Config';
import {TNStackNavigator} from './js/common/navigator/NavigatorView';
import NavigationService from './js/common/navigator/NavigationService';
import rootStore from './js/model/store/RootStore';
import SplashScreen from "react-native-splash-screen";

@observer
export default class App extends Component {

    componentWillMount() {
        SplashScreen.hide();
    }

    render() {
        return (
            <Provider  {...rootStore} >
                <View style={{flex: 1, backgroundColor: 'black'}}>
                    {this.addStatusBar()}
                        <TNStackNavigator
                            ref={navigatorRef => {
                                NavigationService.setTopLevelNavigator(navigatorRef);
                                this.navigator = navigatorRef;
                            }}
                        />
                </View>
            </Provider>
        );
    }


    addStatusBar = () => {
        if (!G_IS_IOS) {
            return (
                <StatusBar
                    hidden={true}
                    animated={true}
                    translucent={true}
                    backgroundColor={'transparent'}
                    barStyle="light-content"/>
            );
        }else{
            return (<StatusBar
                hidden={false}
                animated={true}
                translucent={false}
                backgroundColor={'transparent'}
                barStyle="dark-content"/>)
        }
    };
};

const styles = StyleSheet.create({
    body: {
        backgroundColor: 'transparent',
    },
});

