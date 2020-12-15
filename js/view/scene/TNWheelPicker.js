import React from 'react';
import {Text, View} from 'react-native';
import {
    WheelPicker,
} from "react-native-wheel-picker-android";
import TNButtonView from '../../common/component/TNButtonView';

class TNWheelPicker extends React.Component {
    static navigationOptions = {title: null};

    constructor(props) {
        super(props);
       // let {dataList}=this.props
        let tempList=[]
        for(let i=5;i<=120;i+=5){
            tempList.push(i.toString())
        }

        this.state = {
            selectedItem:3,
            dataList:tempList
        };
    }


    onItemSelected = selectedItem => {
        TN_Log("onItemSelected==="+selectedItem)
        this.setState({ selectedItem });
    };


    render() {
        return (<View style={{backgroundColor:"white",borderRadius:10,height:300}}>
            <WheelPicker
                selectedItemTextColor={"blue"}
                itemStyle={{backgroundColor:"white",fontSize:22,color: 'black',}}
                style={{backgroundColor: 'red',fontSize:20,height:100,width:SCREEN_W}}
                selectedItem={this.state.selectedItem}
                data={this.state.dataList}
                onItemSelected={this.onItemSelected}
            />
            <View style={{flexDirection:"row",justifyContent:"space-between",paddingHorizontal:30}}>
                <Text style={{color:"gray"}}>定时</Text>
                <Text style={{color:"gray"}}>分钟</Text>
            </View>
            <TNButtonView onClick={this.onConfirm} text={"确定"} txtstyle={{fontSize:22}} btnStyle={{backgroundColor:"#aaa",width:300,alignSelf:"center",borderRadius:10,position: 'absolute',bottom:25}}/>
        </View>);
    }

    onItemSelected=(index)=>{
         this.setState({selectedItem:index})
    }

    onConfirm=()=>{
        let {onSelect}=this.props
        if(onSelect){
            onSelect(this.state.dataList[this.state.selectedItem]);
        }
    }


}

export default TNWheelPicker;
