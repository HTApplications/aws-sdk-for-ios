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

#import "S3BucketNameUtilities.h"
#import "AmazonClientException.h"

@implementation S3BucketNameUtilities

+(void)validateBucketName:(NSString *)theBucketName; 
{
	if ( theBucketName == nil ) {
		@throw [AmazonClientException exceptionWithMessage:@"Bucket name should not be nil."];
	}
	
	if ( [theBucketName length] < 3 || [theBucketName length] > 63 ) {
		@throw [AmazonClientException exceptionWithMessage:@"Bucket name should be between 3 and 63 characters in length."];
	}

	if ( [theBucketName hasSuffix:@"-"] ) {
		@throw [AmazonClientException exceptionWithMessage:@"Bucket name should not end with a '-'."];
	}

	if ( [S3BucketNameUtilities contains:theBucketName searchString:@".."] ) {
		@throw [AmazonClientException exceptionWithMessage:@"Bucket name should not contain two adjacent periods."];
	}
	
	if ( [S3BucketNameUtilities contains:theBucketName searchString:@"_"] ) {
		@throw [AmazonClientException exceptionWithMessage:@"Bucket name should not contain '_'."];
	}

	if ( [S3BucketNameUtilities contains:theBucketName searchString:@"-."] ||
		 [S3BucketNameUtilities contains:theBucketName searchString:@".-"] ) {
		@throw [AmazonClientException exceptionWithMessage:@"Bucket name should not contain dashes next to periods."];
	}

	if ( [[theBucketName lowercaseString] isEqualToString:theBucketName] == NO ) {
		@throw [AmazonClientException exceptionWithMessage:@"Bucket name should not contain upper case characters."];
	}	 
}

+(bool)contains:(NSString*)sourceString searchString:(NSString*)searchString
{
	NSRange range = [sourceString rangeOfString:searchString];
	return (range.location != NSNotFound);
}


@end
