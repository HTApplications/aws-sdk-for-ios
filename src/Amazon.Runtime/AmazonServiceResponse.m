/*
 * Copyright 2010 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */


#import "AmazonServiceResponse.h"

@implementation AmazonServiceResponse

@synthesize httpStatusCode;
@synthesize isFinishedLoading;
@synthesize request;
@synthesize requestId;

-(id)init
{
	self = [super init];	
	if ( self != nil ) {
		isFinishedLoading = NO;
		exception = nil;
	}
	
	return self;
}

-(NSData *)body
{
	return [NSData dataWithData:body];
}

// TODO: Make the body property readonly when all operations are converted to the delegate technique.
-(void)setBody:(NSData *)data
{
	if (nil != body) {
		[body setLength:0];
	}
	body = [[NSMutableData dataWithData:data] retain];
	[self processBody];
}

// Override this to perform processing on the body.
-(void)processBody
{
	// Subclasses can use this to build object data from the response, for example
	// parsing XML content.
}

-(NSException *)exception
{
	return exception;
}

#pragma mark NSURLConnection delegate methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
	self.httpStatusCode = [httpResponse statusCode];
	
	//	NSDictionary *headers = [httpResponse allHeaderFields];
	//	
	//	for (id key in headers)
	//	{
	//		[self setValue:[headers valueForKey:key] forHTTPHeaderField:key];
	//	}
	
	[body setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	if (nil == body) {
		body = [[NSMutableData data] retain];
	}
	[body appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection 
{
	isFinishedLoading = YES;
}



-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSDictionary *info = [error userInfo];
	for (id key in info)
	{
		NSLog( @"UserInfo.%@ = %@", [key description], [[info valueForKey:key] description]);
	}
	exception = [[AmazonClientException exceptionWithMessage:[error description]] retain];
	NSLog( @"An error occured in the request: %@", [error description] );
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
	NSLog(@"didSendBodyData");
}

// When a request gets a redirect due to the bucket being in a different region, 
// The request gets re-written with a GET http method. This is to set the method back to
// the appropriate method if necessary
- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)proposedRequest redirectResponse:(NSURLResponse *)redirectResponse
{
	return proposedRequest;
}

#pragma mark memory management

-(void)dealloc
{
	[requestId release];
	[body      release];
	[exception release];
	[request   release];
	
	[super dealloc];
}

-(NSString*)description {
    NSMutableString* buffer = [[NSMutableString alloc] initWithCapacity:256];
    
	[buffer appendString:@"{"];    
//    [buffer appendString:[[[NSString alloc] initWithFormat:@"httpStatusCode: %d,", httpStatusCode] autorelease]];
    [buffer appendString:[[[NSString alloc] initWithFormat:@"requestId: %@", requestId] autorelease]];
	[buffer appendString:@"}"];
	
	return [buffer autorelease]; 
}

@end
