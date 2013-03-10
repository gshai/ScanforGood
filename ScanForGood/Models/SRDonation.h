//
//  SRDonation.h
//  ScanForGood
//
//  Created by Gilad Shai on 3/10/13.
//  Copyright (c) 2013 Spotted Rhino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRDonation : NSObject

@property (nonatomic, strong) NSString  *accountID;
@property (nonatomic, strong) NSString  *url;
@property (nonatomic, strong) NSArray   *options;

- (id) init;
- (id) initWithDictionary:(NSDictionary *)dict;
@end
