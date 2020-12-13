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

export default class Home extends Component {

    constructor(pro) {
        super(pro);
        this.state = {
            dataList: [],
        };
    }

    componentWillMount() {
        NetUitls.getUrlAndParamsAndCallback(netConfig.api.musicJson.url, null, res => {
            this.setState({dataList: res.content});
            TN_Log('home----', res);
        });
    }

    render() {
        let latMusicArr = [];
        if (this.state.dataList.length > 0) {
            latMusicArr = this.state.dataList.splice(0, 5);
        }

        return (<View style={{backgroundColor: 'white', paddingBottom: 100, flex: 1}}>
            {
                latMusicArr.length > 0 ? this.rendSwiperView(latMusicArr) : null
                // this.rendGalleryView(latMusicArr)
            }
        </View>);
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

    addItemVIew(data) {
        let imageUrl = `${netConfig.appDomain}/${data.name}/${data.name}-big.png`;
        TN_Log('---addItemVIew---', imageUrl);
        return (<TouchableWithoutFeedback onPress={() => {
            TN_NavHelp.pushView(TN_NavigateViews.MusicPlayView, {imageUrl: imageUrl, title: data.title});
        }}><View style={styles.body}>
            <Text style={styles.text}>{data.title}</Text>
            <TNImage source={{uri: imageUrl}} style={{height: 400}}/>
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
