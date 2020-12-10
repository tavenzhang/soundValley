import {TabNavigator, StackNavigator} from 'react-navigation';
// import SubGameView from "./SubGameView";
// import GameLogView from "./GameLogView";
// import TWVerWebView from "../WebView/TWVerWebView";
const NavigatViews= {
    // SubGameView:viewRoutHelp(SubGameView),
    // WebView: viewRoutHelp(TWWebGameView),
    // TWThirdWebView:viewRoutHelp(TWVerWebView),
}

//用于增加通用navigator view 属性 特殊 处理
function viewRoutHelp(component) {
    return {screen: component}
}

//为所有组件增加增加routName 配合 JX_Compones  用于 通用 pushtoView 跳转 避免使用纯string
for (let key in Components) {
    if (NavigatViews[key]) {
        NavigatViews[key].routName = key;
    }
}

global.JX_Compones = Components



const MainStackNavigator = StackNavigator({
    ...Components
}, {
    navigationOptions: {
        header: null,
        swipeEnabled: false,
        gesturesEnabled: false
    }
})

export default {
    NavigatViews,
}


