//
//  SVNetWork.m
//  SoundValley
//
//  Created by apple on 2020/5/12.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SVNetWork.h"

@implementation SVNetWork

static SVNetWork *network = nil;
static dispatch_once_t onceToken;

+ (instancetype)sharedManager {
    dispatch_once(&onceToken, ^{
        network = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.haotingwangluo.com"]];
    });
    return network;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        self.securityPolicy.allowInvalidCertificates = YES;
        self.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [self.securityPolicy setValidatesDomainName:NO];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 599)];
        self.responseSerializer.acceptableContentTypes = nil;
        self.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
    }
    return self;
}

-(void)postJsonDataWithPath:(NSString *)path parameters:(id)parameters block:(void (^)(id _Nonnull, NSError * _Nonnull))block
{
    [self POST:path parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil, error);
    }];
}



@end
