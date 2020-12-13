import {TabNavigator, StackNavigator} from 'react-navigation';
import Home from '../../view/home';
import MusicPlayView from '../../view/play/MusicPlayView';

export const NavigateViews = {
    Home:viewRoutHelp(Home),
    MusicPlayView:viewRoutHelp(MusicPlayView)
}

//用于增加通用navigator view 属性 特殊 处理
function viewRoutHelp(component) {
    return {screen: component}
}

//为所有组件增加增加routName 配合 JX_Compones  用于 通用 pushtoView 跳转 避免使用纯string
for (let key in NavigateViews) {
    if (NavigateViews[key]) {
        NavigateViews[key].routName = key;
    }
}


export const TNStackNavigator = StackNavigator({
    ...NavigateViews
}, {
    navigationOptions: {
        header: null,
        swipeEnabled: false,
        gesturesEnabled: false
    }
})




