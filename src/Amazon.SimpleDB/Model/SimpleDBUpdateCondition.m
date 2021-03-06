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

#import "SimpleDBUpdateCondition.h"


@implementation SimpleDBUpdateCondition

@synthesize name;
@synthesize value;
@synthesize exists;


-(id)init {
	if ( self = [super init] ) {
        name = nil;
        value = nil;
        exists = NO;
    }
    
    return self;
}
    
-(id)initWithName:(NSString*)theName andValue:(NSString*)theValue andExists:(bool)theExists {
	if ( self = [self init] ) {
        self.name = theName;
        self.value = theValue;
        self.exists = theExists;
	}
	
	return self;
}
    


-(NSString*)description {
    NSMutableString* buffer = [[NSMutableString alloc] initWithCapacity:256];
    
	[buffer appendString:@"{"];    
    [buffer appendString:[[[NSString alloc] initWithFormat:@"Name: %@,", name] autorelease]];
    [buffer appendString:[[[NSString alloc] initWithFormat:@"Value: %@,", value] autorelease]];
    [buffer appendString:[[[NSString alloc] initWithFormat:@"Exists: %d,", exists] autorelease]];
	[buffer appendString:[super description]];
	[buffer appendString:@"}"];

	return [buffer autorelease];
}
    

-(void)dealloc {
            [name release];
    [value release];

	[super dealloc];
}		
	

@end
    