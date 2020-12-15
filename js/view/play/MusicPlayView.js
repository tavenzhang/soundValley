import React from 'react';
import {StyleSheet, Text, View} from 'react-native';
import LottieView from 'lottie-react-native';
import {common, LottieAnimate, musicAsset} from '../asset/images';
import TNImage from '../../common/component/TNImage';

import {observer} from 'mobx-react';
//import {withMappedNavigationParams} from 'react-navigation-props-mapper';
import TNHeadBar from '../../common/component/TNHeadBar';
import {TNButtonImg} from '../../common/component/TNButtonView';
import TNWheelPicker from '../scene/TNWheelPicker';
import Video from "react-native-video";
import TimeView from './TimeView';
@observer
class MusicPlayView extends React.Component {



    constructor(props) {
        super(props);
        this.state = {
            isPlayMusic: true,
            isShowPickTimer:false,
            timeNum:20
        };
    }


    render() {
        let {music} = this.props.navigation.state.params;
        TN_Log('-----------music====' + SCREEN_H, music);
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

                <View style={{width: lottieWidth, height: lottieWidth, alignSelf: 'center',justifyContent:"center"}}>
                    <TimeView     ref='timeView'  style={{alignSelf:"center"}} onTimeStop={this.onMusicPlay} timeNum={this.state.timeNum}/>
                    <LottieView ref={animation => {
                        this.animation = animation;
                    }} source={LottieAnimate.shenggu4s} autoPlay={true} loop={true} speed={1}
                                resizeMode="contain"/>

                </View>

            </View>
            {this.state.isShowPickTimer ? <View style={{position: 'absolute',bottom:0}}>
                <TNWheelPicker onSelect={this.onSelect} />
            </View>:null}
            <Video
                source={{uri:music.voice}} // 视频的URL地址，或者本地地址
                //source={musicAsset.testMusic} // 视频的URL地址，或者本地地址
                audioOnly={true}
                ref='player'
             //   rate={1}
                rate={this.state.isPlayMusic ?1:0}                   // 控制暂停/播放，0 代表暂停paused, 1代表播放normal.
                volume={1.0}
                // 声音的放声音的放大倍数大倍数，0 为静音  ，1 为正常音量 ，更大的数字表示放大的倍数
                muted={false}                  // true代表静音，默认为false.
                paused={false}                 // true代表暂停，默认为false
                resizeMode="contain"           // 视频的自适应伸缩铺放行为，contain、stretch、cover
                repeat={true}                 // 是否重复播放
                playInBackground={true}       // 当app转到后台运行的时候，播放是否暂停
                playWhenInactive={true}       // [iOS] Video continues to play when control or notification center are shown. 仅适用于IOS
                onLoadStart={this.loadStart}   // 当视频开始加载时的回调函数
                onLoad={this.setDuration}      // 当视频加载完毕时的回调函数
                onProgress={this.onProgress}      //  进度控制，每250ms调用一次，以获取视频播放的进度
                onEnd={this.onEnd}             // 当视频播放完毕后的回调函数
                onError={this.videoError}      // 当视频不能加载，或出错后的回调函数
                style={{}}
            />
        </View>);
    }

    //当视频开始加载时的回调函数
    loadStart=(data)=>{
        TN_Log("music======loadStart",data)
    }
    //当视频加载完毕时的回调函数
    setDuration=(data)=>{
        TN_Log("music======setDuration",data)
    }

    videoError=(data)=>{
        TN_Log("music======videoError",data)
    }

    onProgress=(data)=>{
      //  TN_Log("music======onProgress",data)
    }



    onMusicPlay=()=>{
        if(this.animation){
            !this.state.isPlayMusic ? this.animation.play():this.animation.pause();
        }
        let newState=!this.state.isPlayMusic
        this.setState({isPlayMusic:newState});
        if(newState){
            this.refs.timeView.onTimeOperate(false)
        }else{
            this.refs.timeView.onTimeOperate(true)
        }


    }

    onChooseTime=(data)=>{
        this.setState({isShowPickTimer:true});
    }

    onSelect=(data)=>{
        this.setState({isShowPickTimer:false,timeNum:data}) ;
        if(this.refs.timeView){
            this.refs.timeView.onResetTime(parseInt(data))
        }
        TN_Log("onSelect---data=="+data)
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
