import React, {
    Component,
} from 'react'
import {netConfig, baseUrl} from './TCRequestConfig';
import queryString from 'query-string';
import _ from 'lodash';


const defaultTimeout = 10000;
import Moment from 'moment';


export default class NetUitls extends Component {
    /**
     *url :请求地址
     *params:参数(Json对象)
     *callback:回调函数
     */
    static getUrlAndParamsAndCallback(url, params, callback, timeout, dontAddHeadersAuthorization,loadingState,isWebHttp=false,header=null) {
        this.getUrlAndParamsAndPlatformAndCallback(url, params, null, callback, timeout, dontAddHeadersAuthorization,loadingState,isWebHttp,header)
    }

    /**
     * 获取平台相关数据
     * @param url
     * @param params
     * @param callback
     * @param timeout
     * @param dontAddHeadersAuthorization
     */
    static getUrlAndParamsAndPlatformAndCallback(url, params, platform, callback, timeout, dontAddHeadersAuthorization,loadingState,isWebHttp=false,header=null) {
        url = this.getServerUrl(url)
        if (typeof params === 'string') {
            url += '/' + params
        } else if (params) {
            url += '?' + queryString.stringify(params)
        }
        let map = {...netConfig.mapGet,headers:{...netConfig.mapGet.headers}}; //必须把header 覆写了 否则会重复修改一个header
        if (timeout > 0) {
            map.timeout = timeout
        } else {
            map.timeout = defaultTimeout
        }
        map.headers.gamePlatform = platform ? platform : '';
        if(header){
            map.headers={...map.headers,...header}
        }

        this.fetchAsync(url, map, callback, dontAddHeadersAuthorization,loadingState,isWebHttp)
    }



    static postUrlAndParamsAndCallback(url, params, callback, timeout, dontAddHeadersAuthorization, dontStringfyBody,loadingState,isWebHttp=false,header=null) {
        url = this.getServerUrl(url)
        //TN_Log(JSON.stringify(netConfig.map))
        let map = _.assignIn(netConfig.map, {
            body: dontStringfyBody ? params : JSON.stringify(params),
        });
        let myMap = {...map,headers:{...map.headers}}
        if (timeout > 0) {
            myMap.timeout = timeout
        } else {
            myMap.timeout = defaultTimeout
        }
        if(header){
            myMap.headers={...myMap.headers,...header}
        }
        //TN_Log("---home--http-message-postUrlAndParamsAnd--postUrlAndParamsAndCallback", myMap.headers);
       // TN_Log("---home--postUrlAndParamsAndCallbackmapPost==",netConfig.map);
        this.fetchAsync(url, myMap, callback, dontAddHeadersAuthorization,loadingState,isWebHttp)
    }

    static putUrlAndParamsAndCallback(url, params, callback, timeout, loadingState, isWebHttp=false,header=null) {
        url = this.getServerUrl(url)
        let map = _.assignIn(netConfig.mapPut, {
            body: JSON.stringify(params)
        })
        let myMap = {...map,headers:{...map.headers}}
        if (timeout > 0) {
            myMap.timeout = timeout
        } else {
            myMap.timeout = defaultTimeout
        }
        if(header){
            myMap.headers={...myMap.headers,...header}
        }
      //  TN_Log("---home--http-message-put--putUrlAndParamsAndCallback", myMap.headers);
        //TN_Log("---home--http-message-put--mapPut",netConfig.mapPut);
        this.fetchAsync(url, myMap, callback,false,loadingState,isWebHttp)
    }




    static deleteUrlAndParamsAndCallback(url, params, callback, timeout,loadingState,isWebHttp=false,header=null) {
        url = this.getServerUrl(url)
        let map = _.assignIn(netConfig.mapDelete, {
            body: JSON.stringify(params)
        })
        let myMap = {...map,headers:{...map.headers}}
        if (timeout > 0) {
            myMap.timeout = timeout
        } else {
            myMap.timeout = defaultTimeout
        }
        if(header){
            myMap.headers={...myMap.headers,...header}
        }
        this.fetchAsync(url, myMap, callback,loadingState,isWebHttp)
    }


    //loadingState = {isModal: false, overStyle: {}, style: {}, margeTop: 0}
    static async fetchAsync(url, map, callback, dontAddHeadersAuthorization,loadingState,isWebHttp=true) {
        if (!dontAddHeadersAuthorization) {
            map = addHeadersAuthorization(map,isWebHttp)
        } else {
            delete map.headers.Authorization
        }
        // if (initAppStore.deviceToken.length) {
        //     map.headers.device_token = initAppStore.deviceToken;
        // }
        //记录请求开始时间
        let startTime = Moment();
        TN_Log('http------------------------->' , {url,map})
        let response = {}
        try {
            //如果需要全局 londing 提示 进行显示 通过 loadingState 可以设置具体样式
            // if(loadingState!=null){
            //     rootStore.commonBoxStore.showSpinWithState(loadingState)
            // }
            if(!isWebHttp){
               // TW_Store.gameUIStroe.isShowResLoading=true;
            }
            response = await fetch(url, map)
        } catch (e) {

        } finally {
            if(loadingState!=null){
               // rootStore.commonBoxStore.hideSpin()
            }
        }

        // 计算请求响应时间
        let endTime = Moment();
        let duration = endTime.diff(startTime) / 1000;

        let responseJson = {}
        let result = {}

        try {
            responseJson = await response.json()
        } catch (e) {
            responseJson = null
        } finally {
            // if(!isWebHttp){
            //     TW_Store.gameUIStroe.isShowResLoading=false;
            // }
            if (response.status >= 200 && response.status < 305) {
                if (response.status === 204) {
                    result = {"rs": true, duration: duration,"message": response.message}
                } else {
                    result = {
                        "content": responseJson,
                        "rs": true,
                        duration: duration,
                        serverDate: response.headers.map.date,
                        "message": response.message
                    }
                }
            } else if (response.status >= 400) {
                if (response.status === 401) {
                   // userStore.isLogin = false
                    result = {"rs": false, "error": '无效token', "status": response.status, duration: duration, "message": response.message}
                    //NavigationService.tokenIsError();
                    result.rs = false;
                    callback(result);
                } else if (response.status === 422) {
                    if (url.match(/refreshToken/)) {
                     //   userStore.isLogin = false
                        //NavigationService.tokenIsError();
                    } else {
                        result = _.assignIn(responseJson, {"rs": false, "status": response.status, duration: duration, "message": response.message});
                    }
                } else if (responseJson) {
                    TN_Log('responseJson:', JSON.stringify(responseJson))
                    result = _.assignIn(responseJson, {
                        "rs": false,
                        "status": response.status,
                        "massage": response.message,
                        duration: duration
                    })
                } else {
                    result = {"rs": false, "status": response.status, duration: duration,"message": response.message}
                }
            } else {
                result = {"rs": false, "status": response.status, "message": response.message, duration: duration}
            }
        }
        result.status = response.status;
        callback(result);
        TN_Log('\n\n*******   ' + map.method + '请求 url:\n' + url + '\nrequestMap = ' + JSON.stringify(map) + '\n\n*******   状态码:' + response.status + '  *******返回结果：  \n' + JSON.stringify(result) + '\n')
        if(!result.rs){

           // let access_token =TW_GetQueryString("access_token",url);
           // TN_Log("无效token====TW_Store.userStore.access_token=="+TW_Store.userStore.access_token,access_token);

        }
    }

    static getServerUrl(url) {
        if (url && (_.startsWith(url, 'http://') || _.startsWith(url, 'https://'))) {
            return url
        }
        else if(url&&_.startsWith(url,"localhost://")){
            url = url.replace("localhost://","");
            return url;
        }
        return netConfig.appDomain+url;
    }

    /**
     * 请求其他服务器数据
     * @param url
     * @param callback
     * @param timeout
     * @param header
     */
    static getOtherServerUrlAndCallback(url,timeout,header,callback){
        let map = netConfig.mapGet
        if(header){
            map.headers = header
        }
        if(timeout>0){
            map.timeout = timeout
        }

        this.fetchAsync(url,map,callback)
    }
}

function addHeadersAuthorization(map,isWebHttp=false) {
    if(!isWebHttp){
        if (false) {
            map.headers.Authorization = 'bearer ' +"";
        }
        else {
            map.headers.Authorization = '';
        }
    }else{
        if(!map.headers.Authorization){
            map.headers.Authorization = '';
        }
    }
    return map
}

