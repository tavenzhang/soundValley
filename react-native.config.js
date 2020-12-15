module.exports = {
    dependencies: {
        'react-native-code-push': {
            platforms: {
                android:null,
            },
        },
        'jshare-react-native' : {
            platforms: {
                android: {
                    packageInstance: 'new JSharePackage(false, false)'
                }
            }
        },
        'jpush-react-native': {
            platforms: {
                android:null,
            },
        },


    },
};
