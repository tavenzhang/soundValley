import React from 'react';
import {StyleSheet, Text, View} from 'react-native';
import LottieView from 'lottie-react-native';
import {LottieAnimate} from '../asset/images';
import TNImage from '../../common/component/TNImage';

import {observer} from 'mobx-react';
import {withMappedNavigationParams} from 'react-navigation-props-mapper';

@observer
@withMappedNavigationParams()
class MusicPlayView extends React.Component {
    static navigationOptions = ({ navigation }) => {
        const { params } = navigation.state;
        // let headerRight = (
        //     <Button
        //         title="Save"
        //         onPress={params.handleSave ? params.handleSave : () => null}
        //     />
        // );
        // if (params.isSaving) {
        //     headerRight = <ActivityIndicator />;
        // }
        TN_Log("navigationOptions===params=",params)
        let title=params.title
        return { title};
    };

    constructor(props) {
        super(props);
        this.state = {
            play: false,
        };
    }

    componentWillMount() {

    }

    render() {
        let {imageUrl} = this.props;
        TN_Log('---------------this.props===SCREEN_H==' + SCREEN_H, this.props);
        let lottieWidth = SCREEN_W-80;
        return (<View style={{width: SCREEN_W, height: SCREEN_H, justifyContent: 'center'}}>
            <TNImage source={{uri: imageUrl}} style={{width: SCREEN_W, height: SCREEN_H, position: 'absolute'}}
                     resizeMode={'cover'}/>
            <View style={{width: lottieWidth, height: lottieWidth, justifyContent: 'center', alignSelf: 'center'}}>
                <LottieView source={LottieAnimate.shenggu4s} autoPlay={true} loop={true} speed={1}
                            resizeMode="contain"/>
            </View>
        </View>);
    }
}

const styles = StyleSheet.create({
    body: {
        width: SCREEN_W,
        height: SCREEN_H,
    },
});


export default MusicPlayView;
