import React from 'react';
import {Text, View} from 'react-native';
import {common} from './asset/images';
import TNHeadBar from '../common/component/TNHeadBar';
import TNFLatList from '../common/component/TNFLatList';
import TNImage from '../common/component/TNImage';
import {TNButtonImg} from '../common/component/TNButtonView';

class SceneListView extends React.Component {

    constructor(props) {
        super(props);
        this.state = {};
    }

    componentWillMount() {

    }


    render() {
        //{imgBig,imgSmall,voice,title:data.title,name:data.name})
        let {musicList} = this.props.navigation.state.params;
        TN_Log("musicList---",this.props.navigation.state.params)
        return (<View style={{flex:1,backgroundColor:"white",alignItems:"center"}}>
            <TNHeadBar leftImage={common.blackBack} needBackButton={true} title={"场景音效"} titleStyle={{color:"black",fontSize:18}} backButtonCall={TN_NavHelp.popToBack} rightImage={common.share}/>
            <TNFLatList
                // renderHeader={this.rendHeader}
                style={{flex:1,paddingTop:20}}
                dataS={musicList}
                numColumns={3}
                renderRow={this.rendrow}
            />
        </View>);
    }
   rendHeader=()=>{
       return (<Text style={{marginBottom:20,fontSize:15,marginLeft:20,fontWeight:"bold"}}>全部场景</Text>)
   }

    rendrow=(data)=>{
        TN_Log("rendrow---"+data.imgSmall,data)
        return (<View style={{width:118,height:140,alignItems:"center"}}>
            <TNButtonImg imgSource={{uri:data.imgSmall}} imgStyle={{width:80,height:80,borderRadius:20}} onClick={()=>this.onChooseClick(data)}/>
            <Text style={{fontSize:15,color:"rgb(139, 139, 139)",marginTop:15}}>{data.title}</Text>
        </View>)
    }

    onChooseClick=(data)=>{
        let {musicList} = this.props.navigation.state.params;
        TN_NavHelp.pushView(TN_NavigateViews.MusicPlayView,{musicList:musicList,music:data});
    }
}

export default SceneListView;
