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

#import "SimpleDBSelectResponse.h"


@implementation SimpleDBSelectResponse

@synthesize items;
@synthesize nextToken;


-(id)init {
	if ( self = [super init] ) {
        items = [[NSMutableArray alloc] initWithCapacity:1];
        nextToken = nil;
    }
    
    return self;
}
   

-(void)setException:(AmazonServiceException *)theException
{
    AmazonServiceException *newException = nil;
    
        if([[theException errorCode] isEqualToString:@"InvalidParameterValue"]) {
            newException = [[SimpleDBInvalidParameterValueException alloc] initWithMessage:@""];
        }
    
        if([[theException errorCode] isEqualToString:@"InvalidQueryExpression"]) {
            newException = [[SimpleDBInvalidQueryExpressionException alloc] initWithMessage:@""];
        }
    
        if([[theException errorCode] isEqualToString:@"RequestTimeout"]) {
            newException = [[SimpleDBRequestTimeoutException alloc] initWithMessage:@""];
        }
    
        if([[theException errorCode] isEqualToString:@"InvalidNumberPredicates"]) {
            newException = [[SimpleDBInvalidNumberPredicatesException alloc] initWithMessage:@""];
        }
    
        if([[theException errorCode] isEqualToString:@"NoSuchDomain"]) {
            newException = [[SimpleDBNoSuchDomainException alloc] initWithMessage:@""];
        }
    
        if([[theException errorCode] isEqualToString:@"InvalidNextToken"]) {
            newException = [[SimpleDBInvalidNextTokenException alloc] initWithMessage:@""];
        }
    
        if([[theException errorCode] isEqualToString:@"TooManyRequestedAttributes"]) {
            newException = [[SimpleDBTooManyRequestedAttributesException alloc] initWithMessage:@""];
        }
    
        if([[theException errorCode] isEqualToString:@"MissingParameter"]) {
            newException = [[SimpleDBMissingParameterException alloc] initWithMessage:@""];
        }
    
        if([[theException errorCode] isEqualToString:@"InvalidNumberValueTests"]) {
            newException = [[SimpleDBInvalidNumberValueTestsException alloc] initWithMessage:@""];
        }
    
    if (newException != nil) {
        [newException setPropertiesWithException:theException];
        [exception release];
        exception = newException;
    }
    else {
        [exception release];
        exception = [theException retain];
    }
}    
    

-(void)addItem:(SimpleDBItem*)item {
    if ( items == nil ) {
        items = [[NSMutableArray alloc] initWithCapacity:1];
    }
    
    [items addObject:item];
}
        

-(NSString*)description {
    NSMutableString* buffer = [[NSMutableString alloc] initWithCapacity:256];
    
	[buffer appendString:@"{"];    
    [buffer appendString:[[[NSString alloc] initWithFormat:@"Items: %@,", items] autorelease]];
    [buffer appendString:[[[NSString alloc] initWithFormat:@"NextToken: %@,", nextToken] autorelease]];
	[buffer appendString:[super description]];
	[buffer appendString:@"}"];

	return [buffer autorelease];
}
    

-(void)dealloc {
            [items release];
    [nextToken release];

	[super dealloc];
}		
	

@end
    