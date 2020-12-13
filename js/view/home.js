/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React, {Component, useEffect} from 'react';
import {
    SafeAreaView,
    StyleSheet,
    View,
    Text,
    StatusBar, TouchableWithoutFeedback,
} from 'react-native';

import {
    Header,
    LearnMoreLinks,
    Colors,
    DebugInstructions,
    ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';
import NetUitls from '../common/net/TCRequestUitls';
import {netConfig} from '../common/net/TCRequestConfig';
import Swiper from 'react-native-swiper';
import TNImage from '../common/component/TNImage';
import {observer} from 'mobx-react';
import {TNButtonImg} from '../common/component/TNButtonView';
import {musicAsset} from './asset/images';

@observer
export default class Home extends Component {

    // static navigationOptions = {
    //     headerTitle: 'test661',
    //
    //     //headerStyle:{ backgroundColor: 'white', borderBottomWidth:0}
    //     headerColor: '#ddd',
    //     headerStyle:{ backgroundColor: 'transparent', borderBottomWidth:0,position: 'absolute',
    //         top: 0,
    //         left: 0},
    //     headerBackTitleStyle: {
    //         opacity: 0,
    //     },
    //     headerTintColor: '#fff'
    //
    // }

    constructor(pro) {
        super(pro);
        this.state = {
            musicList: [],
        };
    }

    componentWillMount() {
        NetUitls.getUrlAndParamsAndCallback(netConfig.api.musicJson.url, null, res => {
            let listData=res.content;
            let retList=[];
            for (let data of listData){
                let imgBig = `${netConfig.appDomain}/${data.name}/${data.name}-big.png`;
                let imgSmall = `${netConfig.appDomain}/${data.name}/${data.name}-small.png`;
                let voice=`${netConfig.appDomain}/${data.name}/${data.title}.mp3`;
                retList.push({imgBig,imgSmall,voice,title:data.title,name:data.name})
            }
            this.setState({musicList: retList});
            TN_Log('home----', retList);
        });
    }

    render() {
        let latMusicArr = [];
        if (this.state.musicList.length > 0) {
            latMusicArr = this.state.musicList.slice(0, 5);
        }

        return (<View style={{backgroundColor: 'white', paddingBottom: 100, flex: 1}}>
            {
                latMusicArr.length > 0 ? this.rendSwiperView(latMusicArr) : null
                // this.rendGalleryView(latMusicArr)
            }
            <View style={{flexDirection:"row", backgroundColor:"red", alignSelf:"center",justifyContent:"center",alignItems:"center", position: 'absolute',bottom:100}}>
                <TNButtonImg imgSource={musicAsset.mainMusic} onClick={this.onMoreMusic}/>
            </View>
        </View>);
    }

    onMoreMusic=()=>{
        TN_NavHelp.pushView(TN_NavigateViews.SceneListView,{musicList:this.state.musicList});
    }


    rendSwiperView = (latMusicArr) => {
        return (<Swiper style={[styles.wrapper]}
                        removeClippedSubviews={true}
                        showsButtons={false}         //显示控制按钮
                        loop={true}                    //如果设置为false，那么滑动到最后一张时，再次滑动将不会滑到第一张图片。
                        autoplay={true}                //自动轮播
                        autoplayTimeout={3}          //每隔3秒切换
                        index={0}
                        dot={<View style={{           //未选中的圆点样式
                            backgroundColor: 'rgba(0,0,0,0.2)',
                            width: 10,
                            height: 10,
                            borderRadius: 10,
                            marginLeft: 10,
                            marginRight: 9,
                            marginTop: 9,
                            marginBottom: 9,
                        }}/>}
                        activeDot={<View style={{    //选中的圆点样式
                            backgroundColor: '#83ffcf',
                            width: 12,
                            height: 12,
                            borderRadius: 10,
                            marginLeft: 10,
                            marginRight: 9,
                            marginTop: 9,
                            marginBottom: 9,
                        }}/>}
        >{
            latMusicArr.map(this.addItemVIew)
        }
        </Swiper>);
    };

    addItemVIew=(data)=> {
        TN_Log('---addItemVIew---', data);
        return (<TouchableWithoutFeedback onPress={() => {
            TN_NavHelp.pushView(TN_NavigateViews.MusicPlayView, {music: data,musicList:this.state.musicList});
        }}><View style={styles.body}>
            <Text style={styles.text}>{data.title}</Text>
            <TNImage source={{uri: data.imgBig}} style={{height: 400}}/>
        </View>
        </TouchableWithoutFeedback>);
    }
}

const styles = StyleSheet.create({
    wrapper: {
        //backgroundColor:"yellow",
        paddingVertical: 100,
    },
    text: {
        color: 'gray',
        textAlign: 'center',
        fontSize: 30,
        //backgroundColor:"yellow",

    },

    scrollView: {
        backgroundColor: Colors.lighter,
    },
    body: {
        backgroundColor: Colors.blue,
    },
    sectionContainer: {
        marginTop: 32,
        paddingHorizontal: 24,
    },
    sectionTitle: {
        fontSize: 24,
        fontWeight: '600',
        color: Colors.black,
    },
    sectionDescription: {
        marginTop: 8,
        fontSize: 18,
        fontWeight: '400',
        color: Colors.dark,
    },
    highlight: {
        fontWeight: '700',
    },
    footer: {
        color: Colors.dark,
        fontSize: 12,
        fontWeight: '600',
        padding: 4,
        paddingRight: 12,
        textAlign: 'right',
    },
});

//export default Home;
