//
//  SRDonation.m
//  ScanForGood
//
//  Created by Gilad Shai on 3/10/13.
//  Copyright (c) 2013 Spotted Rhino. All rights reserved.
//

#import "SRDonation.h"

@implementation SRDonation
@synthesize accountID = _accountID;
@synthesize url = _url;
@synthesize options = _options;

- (id) init {
	self = [super init];
	if (self != nil) {
        
	}
	return self;
}

- (id) initWithDictionary:(NSDictionary *)dict {
	self = [super init];
	if (self != nil) {
        _url = [dict objectForKey:@"url"];
        _options = [dict objectForKey:@"options"];
        _accountID = [dict objectForKey:@"account_id"];
	}
	return self;
}

@end
