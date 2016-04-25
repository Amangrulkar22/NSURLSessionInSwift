//
//  BaseNSURLConnection.h
//  Sample
//
//  Created by Ashwinkumar Mangrulkar on 27/11/14.
//  Copyright (c) 2014 smartdata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunicationManager : NSObject

-(void)initConnection:(NSMutableURLRequest *)urlString;

-(NSMutableURLRequest *)request:(NSString *)urlString;

-(BOOL)isNetworkAvailable;

//define for POST method
-(NSDictionary *)sendSynchronousRequestForPostMethod:(NSMutableURLRequest *)request withResponseCallback:(void (^)(NSDictionary *responseDictionary, NSError *error))callback;
-(NSDictionary *)sendASynchronousRequestForPostMethod:(NSMutableURLRequest *)request requestBody:(NSDictionary *)body withResponseCallback:(void (^)(NSDictionary *responseDictionary, NSError *error))callback;

//define for GET method
-(NSDictionary *)sendSynchronousRequestForGetMethod:(NSMutableURLRequest *)request withResponseCallback:(void (^)(NSDictionary *responseDictionary, NSError *error))callback;
-(NSDictionary *)sendASynchronousRequestForGetMethod:(NSMutableURLRequest *)request withResponseCallback:(void (^)(NSDictionary *responseDictionary, NSError *error))callback;

@end
