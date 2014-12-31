//
//  UserInfo.h
//  Buyer
//
//  Created by Himanshu Gupta on 24/04/14.
//  Copyright (c) 2014 Appstudioz Technology Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserInfo : NSManagedObject

@property (nonatomic, retain) NSString * creation_date;
@property (nonatomic, retain) NSString * oauth_key;
@property (nonatomic, retain) NSString * requirment_added;
@property (nonatomic, retain) NSString * user_address;
@property (nonatomic, retain) NSString * user_age;
@property (nonatomic, retain) NSString * user_contact;
@property (nonatomic, retain) NSString * user_email;
@property (nonatomic, retain) NSString * user_fname;
@property (nonatomic, retain) NSString * user_id;
@property (nonatomic, retain) NSString * user_image;
@property (nonatomic, retain) NSString * user_lname;
@property (nonatomic, retain) NSString * user_status;
@property (nonatomic, retain) NSString * user_type;
@property (nonatomic, retain) NSString * currentActiveReqLocation;
@property (nonatomic, retain) NSString * currentActiveReqAddedDate;
@property (nonatomic, retain) NSString * sound;
@property (nonatomic, retain) NSString * notification;
@property (nonatomic, retain) NSString * amount;
@property (nonatomic, retain) NSString * is_verified;


@end


