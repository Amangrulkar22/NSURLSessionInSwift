//
//  BaseNSURLConnection.m
//  Sample
//
//  Created by Ashwinkumar Mangrulkar on 27/11/14.
//  Copyright (c) 2014 smartdata. All rights reserved.
//

#import "CommunicationManager.h"
#import "Reachability.h"
#import <UIKit/UIKit.h>

@implementation CommunicationManager

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/*
 /initialize Connction and set timeout to request.
 */
-(void)initConnection:(NSMutableURLRequest *)request
{
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPShouldHandleCookies:YES];
    [request setTimeoutInterval:30];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

/*
 /send Synchronous request for POST method
 */
-(NSDictionary *)sendSynchronousRequestForPostMethod:(NSMutableURLRequest *)request withResponseCallback:(void (^)(NSDictionary *responseDictionary, NSError *error))callback
{
  
    [self initConnection:request];
    
    [request setHTTPMethod:@"POST"];
    
        //Send synchronous request
        NSError *error = nil;
        NSData *responseData=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if(!error)
    {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
        callback((NSDictionary *)responseDict,nil);
    }else
    {
        callback(nil, error);
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    return nil;
}

/*
 /send Asynchronous request for POST method
 */
-(NSDictionary *)sendASynchronousRequestForPostMethod:(NSMutableURLRequest *)request requestBody:(NSDictionary *)body withResponseCallback:(void (^)(NSDictionary *responseDictionary, NSError *error))callback
{

    [self initConnection:request];
    
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:&error];
    
    [request setHTTPMethod:@"POST"];
    request.HTTPBody = data;
    
    //send asynchnous request
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (!error) {
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
            callback((NSDictionary *)responseDict,nil);
        }else
        {
            callback(nil,error);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    }];
    
    return nil;
}

/*
 /send Synchronous request for GET method
 */
-(NSDictionary *)sendSynchronousRequestForGetMethod:(NSMutableURLRequest *)request withResponseCallback:(void (^)(NSDictionary *responseDictionary, NSError *error))callback
{
    
    [self initConnection:request];
    
    [request setHTTPMethod:@"GET"];
    
    //Send synchronous request
    NSError *error = nil;
    NSData *responseData=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if(!error)
    {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
        callback((NSDictionary *)responseDict,nil);
    }else
    {
        callback(nil, error);
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    return nil;
}

/*
 /send Asynchronous request for GET method
 */
-(NSDictionary *)sendASynchronousRequestForGetMethod:(NSMutableURLRequest *)request withResponseCallback:(void (^)(NSDictionary *responseDictionary, NSError *error))callback
{
    
    [self initConnection:request];
    
    [request setHTTPMethod:@"GET"];
    
    //send asynchnous request
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if(!error)
        {
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
           
            callback((NSDictionary *)responseDict,error);
        }else
        {
            callback(nil, error);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    return nil;
    
}

-(NSMutableURLRequest *)request:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    return request;
}

-(int)checkHeaderCode:(id)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int code = [httpResponse statusCode];
    return code;
}

/*
 /Method check for network availability
 */
-(BOOL)isNetworkAvailable
{
    //Check internet connection
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    if ((netStatus == NotReachable) && (netStatus != ReachableViaWiFi) && (netStatus != ReachableViaWWAN))
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"No Internet Connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return false;
        
    }else
    {
        return true;
    }
    return false;
}

@end
