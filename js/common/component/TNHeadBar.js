/**
 * Created by Sam on 2016/11/11.
 */

/*
 ** use for import **
 import TopNavigationBar from '../../Common/View/TCNavigationBar'
 */

import React, {Component} from 'react';
import {
    StyleSheet,
    Text,
    View,
    Platform,
    Image,
    ImageBackground,
    TouchableOpacity
} from 'react-native';


import _ from 'lodash';

import PropTypes from 'prop-types';
import {NavBarHeaderHeight, NavBarHeight, StatusBarHeight} from './screen';
import {common} from '../../view/asset/images';
import TNImage from './TNImage';

const NavIconSize = 44;
const width=SCREEN_W

export default class TNHeadBar extends Component {

    constructor(state) {
        super(state);
        this.state = {
            showBackButton: (this.props.needBackButton),
        };
    }

    static propTypes = {
        title: PropTypes.any,
        needBackButton: PropTypes.any,
        rightTitle: PropTypes.any,
        rightImage: PropTypes.any,
        leftTitle: PropTypes.any,
        leftImage: PropTypes.any,
        rightButtonCall: PropTypes.any,
        closeButtonCall: PropTypes.any,
        titleStyle: PropTypes.object,
        centerViewShowStyleImage: PropTypes.any,
        backButtonCall: PropTypes.any
    }

    static defaultProps = {
        title: '',
        needBackButton: true,
        rightTitle: '',
        rightImage: null,
        leftTitle: null,
        leftImage: null,
        rightButtonCall: null,
        closeButtonCall: null,
        titleStyle: null,
        centerViewShowStyleImage: false,
        renderCenter:null
    }

    render() {
        return (
            <View style={styles.navBar} >
                <View style={styles.navBarLeftItem}>{this.renderLeftItem()}</View>
                <View style={styles.navBarCenterItem}>
                    <TouchableOpacity disabled={!this.props.midCall} onPress={()=>this.props.midCall()}>
                        {this.renderCenterItem()}
                    </TouchableOpacity>
                </View>
                <View style={styles.navBarRightItem}>{this.renderRightItem()}</View>
            </View>
        );
    }

    renderCenterItem() {
        if (this.props.renderCenter) {
            return (this.props.renderCenter())
        }
        if (this.props.centerViewShowStyleImage && common.topTitleIndex) {
            return (
                <Image source={common.topTitleIndex} resizeMode={'contain'}
                       style={{width: width - 180, height: NavIconSize,}}/>
            )
        }
        return (<Text style={[styles.titleStyle,this.props.titleStyle]} ellipsizeMode='tail' numberOfLines={1}> {this.props.title} </Text>)
    }

    renderLeftItem() {
        if (this.props.needBackButton) {
            return (
                <TouchableOpacity
                    onPress={this.backButtonCall}>
                    <View>
                        {this.getBackImage()}
                    </View>

                </TouchableOpacity>
            )
        }

        if (this.props.leftTitle) {
            return (
                <TouchableOpacity
                    onPress={this.backButtonCall}
                    underlayColor='#DEDEDE'>
                    <View style={{justifyContent: 'center', alignItems: 'center', paddingLeft: 20}}>
                        <Text style={styles.leftTitleStyle}>{this.props.leftTitle}</Text>
                    </View>
                </TouchableOpacity>
            )
        }
    }

    getBackImage() {
        if (_.startsWith(this.props.leftImage, 'index_personal')) {
            return <Image source={common.topPersonal} style={styles.navIcon} resizeMode={'cover'}/>
        } else if (this.props.leftImage) {
            return <Image source={this.props.leftImage} resizeMode={'cover'}/>
        } else {
            return <Image source={common.back} style={{marginLeft: 20}} />
        }
    }

    backButtonCall = () => {
        TN_Log('TNHeadBar---backButtonCall');
        if (this.props.backButtonCall == null) return;
        this.props.backButtonCall();
    }

    renderRightItem() {
        if (this.props.rightTitle) {
            return (
                <TouchableOpacity underlayColor='#DEDEDE' onPress={this.rightButtonCall}>
                    <View style={{justifyContent: 'center', alignItems: 'center', paddingRight: 10}}>
                        <Text
                            style={this.props.rightTitle.length === 2 ? styles.rightBoldTitleStyle : styles.rightTitleStyle}>
                            {this.props.rightTitle}
                        </Text>
                    </View>
                </TouchableOpacity>
            )
        } else if (this.props.rightImage) {
            return (
                <TouchableOpacity underlayColor='#DEDEDE' onPress={this.rightButtonCall}>
                    <View style={{justifyContent: 'center', alignItems: 'center'}}>
                        <Image source={this.props.rightImage} />
                    </View>
                </TouchableOpacity>
            )
        }
    }

    closeButtonCall() {
        if (this.props.closeButtonCall == null) return;
        this.props.closeButtonCall();
    }

    rightButtonCall=()=> {
        if (this.props.rightButtonCall == null) return;
        this.props.rightButtonCall();
    }
}

const styles = StyleSheet.create({
    navBar: {
        width: width,
        height: NavBarHeight,
        paddingTop: StatusBarHeight,
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'space-between',
        paddingHorizontal:20

    },
    navBarHeader: {
        width: width,
        height: NavBarHeaderHeight,
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'space-between',
        marginTop: StatusBarHeight
    },
    navIcon: {
        width: NavIconSize,
        height: NavIconSize,

    },
    titleStyle: {
        fontSize: 20,
        color: "white",
        fontWeight: 'bold',
        textAlign: 'center',
        textAlignVertical: 'center',
    },
    leftTitleStyle: {
        fontSize: 18,
        color:  "white",
        fontWeight: 'bold',
        textAlign: 'center',
        textAlignVertical: 'center',
    },
    rightTitleStyle: {
        fontSize: 15,
        color:  "white",
        textAlign: 'center',
        textAlignVertical: 'center',
    },
    rightBoldTitleStyle: {
        fontSize: 18,
        color:  "white",
        fontWeight: 'bold',
        textAlign: 'center',
        textAlignVertical: 'center',
    },
    navBarLeftItem: {
        flex: 1,
        alignItems: 'flex-start',
        justifyContent: 'center',
        height: NavBarHeaderHeight,
    },
    navBarCenterItem: {
        flex: 2,
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'center',
        height: NavBarHeaderHeight,
    },
    navBarRightItem: {
        flex: 1,
        alignItems: 'flex-end',
        justifyContent: 'center',
        height: NavBarHeaderHeight,
    },
});
