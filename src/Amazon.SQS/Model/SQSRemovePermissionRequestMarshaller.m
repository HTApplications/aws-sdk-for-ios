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

#import "SQSRemovePermissionRequestMarshaller.h"
#import "SQSRequest.h"

       


@implementation SQSRemovePermissionRequestMarshaller 

+(AmazonServiceRequest*)createRequest:(SQSRemovePermissionRequest*)removePermissionRequest {
    AmazonServiceRequest* request = [[SQSRequest alloc] init];
    [request setParameterValue:@"RemovePermission"           forKey:@"Action"];
    [request setParameterValue:@"2009-02-01"   forKey:@"Version"];
    
        if (removePermissionRequest != nil) {
            if (removePermissionRequest.queueUrl != nil) {
            [request setParameterValue:[NSString stringWithFormat:@"%@", removePermissionRequest.queueUrl] forKey:[NSString stringWithFormat:@"%@",@"QueueUrl"]];
        }
            }
    if (removePermissionRequest != nil) {
            if (removePermissionRequest.label != nil) {
            [request setParameterValue:[NSString stringWithFormat:@"%@", removePermissionRequest.label] forKey:[NSString stringWithFormat:@"%@",@"Label"]];
        }
            }

    
    return [request autorelease];
}

@end

