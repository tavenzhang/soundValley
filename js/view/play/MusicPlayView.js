import React from 'react';
import {StyleSheet, Text, View} from 'react-native';
import LottieView from 'lottie-react-native';
import {common, LottieAnimate, musicAsset} from '../asset/images';
import TNImage from '../../common/component/TNImage';

import {observer} from 'mobx-react';
import {withMappedNavigationParams} from 'react-navigation-props-mapper';
import TNHeadBar from '../../common/component/TNHeadBar';
import {TNButtonImg} from '../../common/component/TNButtonView';

@observer
class MusicPlayView extends React.Component {



    constructor(props) {
        super(props);
        this.state = {
            isPlayMusic: false,
        };
    }

    componentWillMount() {

    }

    render() {
        let {music} = this.props.navigation.state.params;
        TN_Log('---------------this.props===SCREEN_H==' + SCREEN_H, this.props.navigation.state.params);
        let lottieWidth = SCREEN_W - 80;
        return (<View style={{width: SCREEN_W, height: SCREEN_H}}>
            <TNImage source={{uri:music.imgBig}} style={{width: SCREEN_W, height: SCREEN_H, position: 'absolute'}}
                     resizeMode={'cover'}/>
            <TNHeadBar needBackButton={true} backButtonCall={TN_NavHelp.popToBack} rightImage={common.share}/>
            <Text style={{color: '#ddd', fontSize: 30, textAlign: 'center',marginTop:30}}>{music.title}</Text>
            <View style={{flexDirection:"row", alignSelf:"center",justifyContent:"center",alignItems:"center", position: 'absolute',bottom:100}}>
                <TNButtonImg imgSource={musicAsset.mainTime} onClick={this.onChooseTime} imgStyle={{width:20,height:20}} />
                <TNButtonImg imgSource={this.state.isPlayMusic ? musicAsset.mainPause: musicAsset.mainPlay} onClick={this.onMusicPlay} btnStyle={{marginHorizontal:25}}/>
                <TNButtonImg imgSource={musicAsset.mainMusic} onClick={this.onMoreMusic}/>
            </View>
            <View style={{width: SCREEN_W, height: SCREEN_H, justifyContent: 'center',position: 'absolute' }} pointerEvents={"none"}>
                <View style={{width: lottieWidth, height: lottieWidth, alignSelf: 'center'}}>
                    <LottieView source={LottieAnimate.shenggu4s} autoPlay={true} loop={true} speed={1}
                                resizeMode="contain"/>
                </View>
            </View>
        </View>);
    }

    onMusicPlay=()=>{
        //if(this.state.isPlayMusic){
            this.setState({isPlayMusic:!this.state.isPlayMusic})
       // }
    }

    onChooseTime=()=>{

    }

    onMoreMusic=()=>{
        let {musicList} = this.props.navigation.state.params;
        TN_NavHelp.pushView(TN_NavigateViews.SceneListView,{musicList});
    }
}

const styles = StyleSheet.create({
    body: {
        width: SCREEN_W,
        height: SCREEN_H,
    },
});


export default MusicPlayView;
