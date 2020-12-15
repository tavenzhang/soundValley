import React from 'react';
import {Text, View} from 'react-native';

class TimeView extends React.Component {
    static navigationOptions = {title: null};

    constructor(props) {
        super(props);
        let {timeNum} = this.props;
        TN_Log("onCheckTime--timeNum==-"+timeNum)
        this.state = {
            timeHint:this.onFormatTimeStr(timeNum*60),
            timeNum:timeNum*60
        };
    }

    componentDidMount() {
      this.timeId=setInterval(this.onCheckTime,1000);
    }


    render() {
        let {style} = this.props;
        return (<View style={style}>
            <Text style={{color: 'white', fontWeight: 'bold', fontSize: 30}}>{this.state.timeHint}</Text>
        </View>);
    }

    onCheckTime=()=>{
       let {onTimeStop}=this.props;
        let curTime=this.state.timeNum;
        TN_Log("onCheckTime---"+curTime)
        if(curTime>0){
            curTime--;
            this.setState({timeHint:this.onFormatTimeStr(curTime),timeNum:curTime});
        }else{
            this.setState({timeHint:this.onFormatTimeStr(curTime),timeNum:curTime});
            clearInterval(this.timeId);
            if(onTimeStop){
                onTimeStop();
            }
        }
    }

    //单位秒
    onFormatTimeStr = (timeNum) => {
        let ret = '';
        let hour = parseInt(timeNum / (60 * 60));
        if (hour > 0) {
            ret = (hour < 9 ? `0${hour}` : `${hour}`) + ' : ';
        }
        let mins = timeNum % (60 * 60);
        mins = parseInt(mins / 60);
        ret += (mins <= 9 ? `0${mins}` : `${mins}`) + ' : ';
        let second = timeNum % 60;
        ret += second <= 9 ? `0${second}` : `${second}`;
        return ret;
    };

    onTimeOperate=(isStop=true)=>{
        if(isStop){
            clearInterval(this.timeId);
        }else{
            clearInterval(this.timeId);
            this.timeId=setInterval(this.onCheckTime,1000);
        }
    }

    onResetTime=(dataNum)=> {
        this.setState({timeHint: this.onFormatTimeStr(dataNum * 60),timeNum:dataNum*60});
        clearInterval(this.timeId);
        this.timeId=setInterval(this.onCheckTime,1000);
    }
}

export default TimeView;
