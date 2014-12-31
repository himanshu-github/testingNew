//
//  Last Updated by Alok on 19/02/14.
//  Copyright (c) 2014 Aryansbtloe. All rights reserved.
//

#import "FeedItemServices.h"
#import "SBJson.h"
#import "AFNetworking.h"
#import "Reachability.h"
#import "SBJsonParser.h"
#import "NSObject+SBJSON.h"
#import "Debugging+Macros.h"
#import "AKSMethods.h"
#import "NSDate+Helper.h"
#import "NSObject+PE.h"
#import "AppDelegate.h"
#import "UIDevice+Macros.h"
#import "ApplicationSpecificConstants.h"
#import "CommonFunctions.h"
#import "UI+Macros.h"

@implementation FeedItemServices

@synthesize responseErrorOption;
@synthesize progresssIndicatorText;

/**
 METHODS TO DIRECTLY GET UPDATED DATA FROM THE SERVER
 */

- (id)init {
	self = [super init];
	if (self) {
		[self setResponseErrorOption:ShowErrorResponseWithUsingNotification];
	}
	return self;
}

#define CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG if (![self getStatusForNetworkConnectionAndShowUnavailabilityMessage:YES]) { operationFinishedBlock(nil); return; }
#define CONTINUE_IF_CONNECTION_AVAILABLE                if (![self getStatusForNetworkConnectionAndShowUnavailabilityMessage:NO]) { operationFinishedBlock(nil); return; }
#define CONTINUE_IF_CONNECTION_AVAILABLE_1              if (![self getStatusForNetworkConnectionAndShowUnavailabilityMessage:NO]) { operationFinishedBlock(); return; }


#pragma mark - Himanshu

-(void)userInterestedCampaignBuyerWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock
{
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    if([info objectForKey:@"offset"])
    {
        
        //very first time data hit
        NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
        [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
        [AKSMethods addParameterFrom:info WithKey:@"user_id"    To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
        [AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
        
        if([info objectForKey:@"camp_id"])
            [AKSMethods addParameterFrom:info WithKey:@"camp_id" To:bodyData UnderKey:@"camp_id"  OnMethodName:METHOD_NAME];
        else if ([info objectForKey:@"offset"])
            [AKSMethods addParameterFrom:info WithKey:@"offset" To:bodyData UnderKey:@"offset"  OnMethodName:METHOD_NAME];
        [self performGetRequestWithBody:bodyData toUrl:CAMPAIGN_INTERESTED_URL withFinishedBlock:operationFinishedBlock];
        
    }
    else{
        
        //hit with link present in dictionary
        
        //[self performGetRequestWithBody:nil toUrl:[info objectForKey:@"nextUrl"] withFinishedBlock:operationFinishedBlock];
        
        [self performPagingRequestWithBody:nil toUrl:[info objectForKey:@"nextUrl"] withFinishedBlock:operationFinishedBlock];

        
    }
    
    
    TCEND
}
-(void)userCampaignProposedWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock
{
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    if([info objectForKey:@"offset"])
    {
        
        //very first time data hit
        NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
        [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
        [AKSMethods addParameterFrom:info WithKey:@"user_id"    To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
        [AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
        
        if([info objectForKey:@"camp_id"])
            [AKSMethods addParameterFrom:info WithKey:@"camp_id" To:bodyData UnderKey:@"camp_id"  OnMethodName:METHOD_NAME];
        else if ([info objectForKey:@"offset"])
            [AKSMethods addParameterFrom:info WithKey:@"offset" To:bodyData UnderKey:@"offset"  OnMethodName:METHOD_NAME];
        [self performGetRequestWithBody:bodyData toUrl:CAMPAIGN_PROPOSED_URL withFinishedBlock:operationFinishedBlock];
        
    }
    else{
        
        //hit with link present in dictionary

       // [self performGetRequestWithBody:nil toUrl:[info objectForKey:@"nextUrl"] withFinishedBlock:operationFinishedBlock];
        
        [self performPagingRequestWithBody:nil toUrl:[info objectForKey:@"nextUrl"] withFinishedBlock:operationFinishedBlock];

    }
    
    
    TCEND
}

- (void)userCampaignBuyerDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{

    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"user_id"    To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"camp_id" To:bodyData UnderKey:@"camp_id"  OnMethodName:METHOD_NAME];

    [self performGetRequestWithBody:bodyData toUrl:CAMPAIGN_URL withFinishedBlock:operationFinishedBlock];
    
    TCEND





}
#pragma Himanshu methods ends


-(void)agentRatingWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock
{
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"user_id"    To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
    
    if([info objectForKey:@"rate"])
        [AKSMethods addParameterFrom:info WithKey:@"rate" To:bodyData UnderKey:@"rate"  OnMethodName:METHOD_NAME];
    
    if([info objectForKey:@"resource_id"])
        [AKSMethods addParameterFrom:info WithKey:@"resource_id" To:bodyData UnderKey:@"resource_id"  OnMethodName:METHOD_NAME];
    
    [self performPostRequestWithBody:bodyData toUrl:RATING_URL withFinishedBlock:operationFinishedBlock];
    
    TCEND
}

-(void)addInterestWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock
{
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"user_id"    To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"mode" To:bodyData UnderKey:@"mode"  OnMethodName:METHOD_NAME];

    if([info objectForKey:@"camp_id"])
        [AKSMethods addParameterFrom:info WithKey:@"camp_id" To:bodyData UnderKey:@"camp_id"  OnMethodName:METHOD_NAME];

    [self performPostRequestWithBody:bodyData toUrl:ADD_INTEREST_URL withFinishedBlock:operationFinishedBlock];
    
    TCEND
}


-(void)userLocationWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock
{
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"status"    To:bodyData UnderKey:@"status"  OnMethodName:METHOD_NAME];
    
    [self performGetRequestWithBody:bodyData toUrl:LOCATION_URL withFinishedBlock:operationFinishedBlock];
    
    TCEND
}

-(void)userAttributeWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock
{
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"user_id"    To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
    
    [self performGetRequestWithBody:bodyData toUrl:ATTRIBUTE_URL withFinishedBlock:operationFinishedBlock];
    
    TCEND
}

-(void)userSearchWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock
{
    TCSTART
    
   /*
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"user_id"    To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"camp_location" To:bodyData UnderKey:@"camp_location"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"camp_type" To:bodyData UnderKey:@"camp_type"  OnMethodName:METHOD_NAME];
    if([info objectForKey:@"camp_minprice"])
        [AKSMethods addParameterFrom:info WithKey:@"camp_minprice"    To:bodyData UnderKey:@"camp_minprice"  OnMethodName:METHOD_NAME];
    if([info objectForKey:@"camp_maxprice"])
        [AKSMethods addParameterFrom:info WithKey:@"camp_maxprice" To:bodyData UnderKey:@"camp_maxprice"   OnMethodName:METHOD_NAME];
    if([info objectForKey:@"camp_bedroom"])
        [AKSMethods addParameterFrom:info WithKey:@"camp_bedroom" To:bodyData UnderKey:@"camp_bedroom"  OnMethodName:METHOD_NAME];
    if([info objectForKey:@"camp_bathroom"])
        [AKSMethods addParameterFrom:info WithKey:@"camp_bathroom"    To:bodyData UnderKey:@"camp_bathroom"  OnMethodName:METHOD_NAME];
    if([info objectForKey:@"camp_garages"])
        [AKSMethods addParameterFrom:info WithKey:@"camp_garages" To:bodyData UnderKey:@"camp_garages"   OnMethodName:METHOD_NAME];
    if([info objectForKey:@"land_size"])
        [AKSMethods addParameterFrom:info WithKey:@"land_size" To:bodyData UnderKey:@"land_size"  OnMethodName:METHOD_NAME];
    if([info objectForKey:@"internal_size"])
        [AKSMethods addParameterFrom:info WithKey:@"internal_size"    To:bodyData UnderKey:@"internal_size"  OnMethodName:METHOD_NAME];
    if([info objectForKey:@"max_yield"])
        [AKSMethods addParameterFrom:info WithKey:@"max_yield" To:bodyData UnderKey:@"max_yield"  OnMethodName:METHOD_NAME];
    if([info objectForKey:@"min_yield"])
        [AKSMethods addParameterFrom:info WithKey:@"min_yield"    To:bodyData UnderKey:@"min_yield"  OnMethodName:METHOD_NAME];
    
    if([info objectForKey:@"mode"])
        [AKSMethods addParameterFrom:info WithKey:@"mode"    To:bodyData UnderKey:@"mode"  OnMethodName:METHOD_NAME];
    
    if([info objectForKey:@"id"])
        [AKSMethods addParameterFrom:info WithKey:@"id"    To:bodyData UnderKey:@"id"  OnMethodName:METHOD_NAME];
    
    */
    
    if([info objectForKey:@"mode"])
    {
    [self performPutRequestWithBody:info toUrl:UPDATE_SEARCH_URL withFinishedBlock:operationFinishedBlock];
    }else{
    
        [self performPostRequestWithBody:info toUrl:ADD_SEARCH_URL withFinishedBlock:operationFinishedBlock];

    
    }
    
    TCEND
}

-(void)logoutUserWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock
{
    TCSTART
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"user_id"    To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
    
    [self performPostRequestWithBody:bodyData toUrl:LOGOUT_URL withFinishedBlock:operationFinishedBlock];
    
    TCEND
}

-(void)loginUserWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock
{
    TCSTART
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"type"    To:bodyData UnderKey:@"type"          OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
    
    [bodyData setValue:[info objectForKey:@"device_token"] forKey:@"device_token"];
    
    
    [AKSMethods addParameterFrom:info WithKey:@"device_type" To:bodyData UnderKey:@"device_type"  OnMethodName:METHOD_NAME];

	[AKSMethods addParameterFrom:info WithKey:@"email"    To:bodyData UnderKey:@"email"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"password" To:bodyData UnderKey:@"password" OnMethodName:METHOD_NAME];
    
    [self performPostRequestWithBody:bodyData toUrl:LOGIN_URL withFinishedBlock:operationFinishedBlock];
    
    TCEND
}

- (void)signupUserWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock {
    
	TCSTART
    
	NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
	[AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"type" To:bodyData UnderKey:@"type" OnMethodName:METHOD_NAME];
    
    //[AKSMethods addParameterFrom:info WithKey:@"device_token" To:bodyData
    //UnderKey:@"device_token" OnMethodName:METHOD_NAME];
    [bodyData setValue:[info objectForKey:@"device_token"] forKey:@"device_token"];

    [AKSMethods addParameterFrom:info WithKey:@"device_type" To:bodyData UnderKey:@"device_type"  OnMethodName:METHOD_NAME];
    
    
    
	[AKSMethods addParameterFrom:info WithKey:@"first_name" To:bodyData UnderKey:@"first_name" OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"last_name"  To:bodyData UnderKey:@"last_name"  OnMethodName:METHOD_NAME];
    
	[AKSMethods addParameterFrom:info WithKey:@"email"    To:bodyData UnderKey:@"email"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"password" To:bodyData UnderKey:@"password" OnMethodName:METHOD_NAME];
    if([info objectForKey:@"address"])
        [AKSMethods addParameterFrom:info WithKey:@"address" To:bodyData UnderKey:@"address"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"contact" To:bodyData UnderKey:@"contact" OnMethodName:METHOD_NAME];
    NSLog(@"parameters in post === %@",bodyData);
    
    

    
    [self performPostRequestWithBody:bodyData toUrl:SIGNUP_URL constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if([info objectForKey:@"user_image"])
        {
        [formData appendPartWithFileData:[info objectForKey:@"user_image"]
	                                name:@"user_image"
	                            fileName:[NSString stringWithFormat:@"%@_%f.png", [[bodyData objectForKey:@"first_name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]], (double)([[NSDate date]timeIntervalSince1970])]
	                            mimeType:@"image/png"];
        }
        if([info objectForKey:@"user_doc1"])
        {
            [formData appendPartWithFileData:UIImagePNGRepresentation([info objectForKey:@"user_doc1"]) name:@"user_doc1" fileName:[NSString stringWithFormat:@"%@1_image.png",[[NSDate date] string]] mimeType:@"image/png"];
        }
        if([info objectForKey:@"user_doc2"])
        {
            [formData appendPartWithFileData:UIImagePNGRepresentation([info objectForKey:@"user_doc2"]) name:@"user_doc2" fileName:[NSString stringWithFormat:@"%@2_image.png",[[NSDate date] string]] mimeType:@"image/png"];
        }
        if([info objectForKey:@"user_doc3"])
        {
            [formData appendPartWithFileData:UIImagePNGRepresentation([info objectForKey:@"user_doc3"]) name:@"user_doc3" fileName:[NSString stringWithFormat:@"%@3_image.png",[[NSDate date] string]] mimeType:@"image/png"];
        }
        if([info objectForKey:@"user_doc4"])
        {
            [formData appendPartWithFileData:UIImagePNGRepresentation([info objectForKey:@"user_doc4"]) name:@"user_doc4" fileName:[NSString stringWithFormat:@"%@4_image.png",[[NSDate date] string]] mimeType:@"image/png"];
        }
        if([info objectForKey:@"user_doc5"])
        {
            [formData appendPartWithFileData:UIImagePNGRepresentation([info objectForKey:@"user_doc5"]) name:@"user_doc5" fileName:[NSString stringWithFormat:@"%@5_image.png",[[NSDate date] string]] mimeType:@"image/png"];
        }
    } withFinishedBlock:operationFinishedBlock];
    
	TCEND
}

-(void)userForgotWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock
{
    TCSTART
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"email"    To:bodyData UnderKey:@"email"  OnMethodName:METHOD_NAME];
    
    [self performPostRequestWithBody:bodyData toUrl:FORGOT_URL withFinishedBlock:operationFinishedBlock];
    
    TCEND
}

-(void)userConfirmWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock
{
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    NSString *url = [[NSString stringWithFormat:FORGOT_URL, BASE_URL] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"passcode"    To:bodyData UnderKey:@"passcode"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"new_password" To:bodyData UnderKey:@"new_password"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"renter_password"    To:bodyData UnderKey:@"renter_password"  OnMethodName:METHOD_NAME];
    
    if (progresssIndicatorText != nil)
		[CommonFunctions showActivityIndicatorWithText:progresssIndicatorText];
    
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	[manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
	[manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
	[manager PUT:url parameters:bodyData success: ^(AFHTTPRequestOperation *operation, id responseObject) {
	    [self verifyServerResponseAndPerformAction:operationFinishedBlock WithResponseData:responseObject IfError:nil];
	} failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
	    [self verifyServerResponseAndPerformAction:operationFinishedBlock WithResponseData:nil IfError:error];
	}];
    
    TCEND
}
- (void)getblockedAgentListDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"user_id"    To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
    
    [self performGetRequestWithBody:bodyData toUrl:BLOCKED_AGENT_LIST_URL withFinishedBlock:operationFinishedBlock];
    
    TCEND
    

}
- (void)getContactListOfCampaignWithSearchStringAndDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    [self performGetRequestWithBody:info toUrl:SEARCH_CONTACT_CAMPAIGN withFinishedBlock:operationFinishedBlock];
    
    TCEND
    
    
}
- (void)getProductTopupIDWithDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    [self performGetRequestWithBody:info toUrl:GET_PRODUCTID_FOR_TOPUP withFinishedBlock:operationFinishedBlock];
    
    TCEND
    
    
}
- (void)getProductTopupWithDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    [self performGetRequestWithBody:info toUrl:PRODUCT_ID_DETAILS withFinishedBlock:operationFinishedBlock];
    
    TCEND
    
    
}

- (void)StoreTopUpAmountWithDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    [self performPostRequestWithBody:info toUrl:GET_STORE_AMOUNT_TOPUP withFinishedBlock:operationFinishedBlock];
    
    TCEND
    
    
}


- (void)updateRequirementWithDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    /*   "mode": "Edit",
     "oauth_key": "$oauth_key",
     "device_key": "$device_key",
     "user_id" : "$user_id".
     "id" : "$id",
     "camp_type" : $camp_type
     "camp_title" : "$camp_title".
     "camp_location" : $camp_location.
     "camp_minprice" : $camp minprice.
     "camp_maxprice" : $camp maxprice.
     "camp_bedroom" : $camp bedroom.
     "camp_bathroom" : $camp bathroom.
     "camp_garages" : $camp garages.
     "land_size" : $land size.
     "internal_size" : $internal size.
     "max_yield" : $max_yield,
     "min_yield" : $min_yield,
     */

    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"user_id"    To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"mode" To:bodyData UnderKey:@"mode"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"id" To:bodyData UnderKey:@"id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"camp_type" To:bodyData UnderKey:@"camp_type"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"camp_title" To:bodyData UnderKey:@"camp_title"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"camp_location" To:bodyData UnderKey:@"camp_location"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"camp_minprice" To:bodyData UnderKey:@"camp_minprice"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"camp_maxprice" To:bodyData UnderKey:@"camp_maxprice"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"camp_bedroom" To:bodyData UnderKey:@"camp_bedroom"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"camp_bathroom" To:bodyData UnderKey:@"camp_bathroom"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"camp_garages" To:bodyData UnderKey:@"camp_garages"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"land_size" To:bodyData UnderKey:@"land_size"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"internal_size" To:bodyData UnderKey:@"internal_size"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"max_yield" To:bodyData UnderKey:@"max_yield"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"min_yield" To:bodyData UnderKey:@"min_yield"  OnMethodName:METHOD_NAME];
    
    [self performPutRequestWithBody:bodyData toUrl:UPDATE_REUIREMENT_URL withFinishedBlock:operationFinishedBlock];
    
    TCEND
    
    
}
- (void)getInboxOutboxSyncWithData:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
    TCSTART
    
    //CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"user_id"    To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"mode" To:bodyData UnderKey:@"mode"  OnMethodName:METHOD_NAME];
    
    [self performGetRequestWithBody:bodyData toUrl:SYNC_INBOX_OUTBOX_URL withFinishedBlock:operationFinishedBlock];
    
    TCEND
    
    
}

- (void)getConversationListWithData:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    if([info objectForKey:@"offset"])
    {
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"user_id"    To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"msg_id" To:bodyData UnderKey:@"msg_id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"user_type" To:bodyData UnderKey:@"user_type"  OnMethodName:METHOD_NAME];


    [self performGetRequestWithBody:bodyData toUrl:GET_CONVERSATION_LIST withFinishedBlock:operationFinishedBlock];
    }else
    {
        
        //hit with link present in dictionary
        
        [self performPagingRequestWithBody:nil toUrl:[info objectForKey:@"nextUrl"] withFinishedBlock:operationFinishedBlock];
        
        
        
        
    }
    
    TCEND
    
    
}
- (void)composeAndSendMailWithDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"user_id"    To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"msg_id" To:bodyData UnderKey:@"msg_id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"body" To:bodyData UnderKey:@"body"  OnMethodName:METHOD_NAME];

    [self performPostRequestWithBody:bodyData toUrl:SEND_MAIL_URL withFinishedBlock:operationFinishedBlock];
    
    TCEND
    
    
}

- (void)getNotificationForUserWithDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"user_id"    To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"page" To:bodyData UnderKey:@"page"  OnMethodName:METHOD_NAME];
    
    [AKSMethods addParameterFrom:info WithKey:@"camp_id" To:bodyData UnderKey:@"camp_id"  OnMethodName:METHOD_NAME];


    
    [self performPostRequestWithBody:bodyData toUrl:GET_USER_NOTIFICATION withFinishedBlock:operationFinishedBlock];
    
    TCEND
    
    
}

-(void)setSoundSettingWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock
{
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    
    [self performPutRequestWithBody:info toUrl:SOUND_NOTI_SETTING withFinishedBlock:operationFinishedBlock];
    
    TCEND
}
-(void)setNotificationSettingWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock
{
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    
    [self performPutRequestWithBody:info toUrl:SOUND_NOTI_SETTING withFinishedBlock:operationFinishedBlock];
    
    TCEND
}
- (void)hitSeenNotificationService:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    [self performPutRequestWithBody:info toUrl:SEEN_NOTIFICATION_SERVICE withFinishedBlock:operationFinishedBlock];
    
    TCEND
    
    
}
-(void)getSoldCampaignList:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock
{
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    if([info objectForKey:@"nextUrl"])
    {
        [self performPagingRequestWithBody:info toUrl:GET_SOLD_CAMAPIGN withFinishedBlock:operationFinishedBlock];
    }
    else{
    [self performGetRequestWithBody:info toUrl:GET_SOLD_CAMAPIGN withFinishedBlock:operationFinishedBlock];
    }
    
    TCEND
}
-(void)getTrashedCampaignList:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock
{
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    if([info objectForKey:@"nextUrl"])
    {
        [self performPagingRequestWithBody:info toUrl:GET_TRASH_CAMAPIGN withFinishedBlock:operationFinishedBlock];
    }
    else{
    [self performGetRequestWithBody:info toUrl:GET_TRASH_CAMAPIGN withFinishedBlock:operationFinishedBlock];
    }
    
    TCEND
}

-(void)moveToTrashToCampaign:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock
{
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    [self performPostRequestWithBody:info toUrl:MOVE_TO_TRASH_CAMAPIGN withFinishedBlock:operationFinishedBlock];
    
    TCEND
}

-(void)removeFromTrashToCampaign:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock
{
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    [self performPostRequestWithBody:info toUrl:REMOVE_FROM_TRASH_CAMAPIGN withFinishedBlock:operationFinishedBlock];
    
    TCEND
}
#pragma mark - My services
-(void)userChangePasswordServiceWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock
{
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    [self performPutRequestWithBody:info toUrl:CHANGE_PASSWORD_URL withFinishedBlock:operationFinishedBlock];
    TCEND
}
- (void)getMainThreadOfAgentWithDetail:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"user_id"    To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"camp_id" To:bodyData UnderKey:@"camp_id"  OnMethodName:METHOD_NAME];
    
    [self performPostRequestWithBody:bodyData toUrl:GET_MAIN_THREAD withFinishedBlock:operationFinishedBlock];
    
    TCEND

}
- (void)getCommentForThreadWithDetail:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
    TCSTART
    
    if([info objectForKey:@"offset"])
    {
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"user_id"    To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"thread_id" To:bodyData UnderKey:@"thread_id"  OnMethodName:METHOD_NAME];
    
    [self performGetRequestWithBody:bodyData toUrl:GET_COMMENT_THREAD withFinishedBlock:operationFinishedBlock];
    }else{
    
        //hit with link present in dictionary
        
        [self performPagingRequestWithBody:nil toUrl:[info objectForKey:@"nextUrl"] withFinishedBlock:operationFinishedBlock];
    
    
    
    
    }
    TCEND
    
}
- (void)deleteCommentForThreadWithDetail:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"user_id"    To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
    
    [AKSMethods addParameterFrom:info WithKey:@"comment_id" To:bodyData UnderKey:@"comment_id"  OnMethodName:METHOD_NAME];

    [self performDeleteRequestWithBody:bodyData toUrl:DELETE_COMMENT_ON_THREAD withFinishedBlock:operationFinishedBlock];

    //[self performPostRequestWithBody:bodyData toUrl:DELETE_COMMENT_ON_THREAD withFinishedBlock:operationFinishedBlock];
    
    TCEND
    
}

- (void)postCommentForThreadWithDetail:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    [self performPostRequestWithBody:info toUrl:POST_COMMENT_ON_THREAD constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {} withFinishedBlock:operationFinishedBlock];

    //[self performPostRequestWithBody:info toUrl:POST_COMMENT_ON_THREAD withFinishedBlock:operationFinishedBlock];
    
    TCEND
    
}
- (void)getMyAddedRquirementHistoryWithDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"user_id"    To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
    
    [self performPostRequestWithBody:bodyData toUrl:REUIREMENT_HISTORY withFinishedBlock:operationFinishedBlock];
    
    TCEND
    
}
- (void)activateRequirementFromRquirementHistoryWithDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"user_id"    To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"requirement_id" To:bodyData UnderKey:@"requirement_id"  OnMethodName:METHOD_NAME];

    
    [self performPostRequestWithBody:bodyData toUrl:ACTIVATE_REUIREMENT withFinishedBlock:operationFinishedBlock];
    
    TCEND
    
}
- (void)addUserDocServiceWithInfo:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock {
    
    
	TCSTART
    
	NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
	[AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"user_id" To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"role" To:bodyData UnderKey:@"role"  OnMethodName:METHOD_NAME];

    
    [self performPostRequestWithBody:bodyData toUrl:ADD_USER_DOC constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if([info objectForKey:@"prop_img"])
        {
            [formData appendPartWithFileData:UIImagePNGRepresentation([info objectForKey:@"prop_img"]) name:@"prop_img" fileName:[NSString stringWithFormat:@"%@1_image.png",[[NSDate date] string]] mimeType:@"image/png"];
        }
        
    } withFinishedBlock:operationFinishedBlock];
    
	TCEND
}

- (void)removeUserDocServiceWithInfo:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock {
    
    
    
    
    
	TCSTART
    
	NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
	[AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"user_id" To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"role" To:bodyData UnderKey:@"role"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"image_id" To:bodyData UnderKey:@"image_id"  OnMethodName:METHOD_NAME];

    
    [self performDeleteRequestWithBody:bodyData toUrl:REMOVE_USER_DOC withFinishedBlock:operationFinishedBlock];

    
	TCEND
}


- (void)submitEditProfileWithInfo:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock {
    
	TCSTART
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];

	[AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"user_id" To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"role" To:bodyData UnderKey:@"role"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"first_name" To:bodyData UnderKey:@"first_name"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"last_name" To:bodyData UnderKey:@"last_name"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"type" To:bodyData UnderKey:@"type"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"address" To:bodyData UnderKey:@"address"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"contact" To:bodyData UnderKey:@"contact"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"role" To:bodyData UnderKey:@"role"  OnMethodName:METHOD_NAME];



    
    [self performPostRequestWithBody:info toUrl:SUBMIT_USER_EDIT_PROFILE  constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if([info objectForKey:@"user_image"])
        {
            [formData appendPartWithFileData:[info objectForKey:@"user_image"] name:@"user_image" fileName:[NSString stringWithFormat:@"%@1_image.png",[[NSDate date] string]] mimeType:@"image/png"];
        }
        
    } withFinishedBlock:operationFinishedBlock];

    
    
	TCEND
}
-(void)blockAgentWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock
{
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    
    [self performPostRequestWithBody:info toUrl:BLOCK_AGENT withFinishedBlock:operationFinishedBlock];
    
    TCEND
}

- (void)deleteConversationWithDetail:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"user_id"    To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
    
    [AKSMethods addParameterFrom:info WithKey:@"msg_id" To:bodyData UnderKey:@"msg_id"  OnMethodName:METHOD_NAME];
    
    [self performPutRequestWithBody:bodyData toUrl:DELETE_CONVERSATION_URL withFinishedBlock:operationFinishedBlock];
    
    //[self performPostRequestWithBody:bodyData toUrl:DELETE_CONVERSATION_URL withFinishedBlock:operationFinishedBlock];
    
    TCEND
    
}
- (void)bidTheCampWithDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"user_id"    To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"camp_id" To:bodyData UnderKey:@"camp_id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"amount" To:bodyData UnderKey:@"amount"  OnMethodName:METHOD_NAME];

    [self performPostRequestWithBody:bodyData toUrl:BID_ON_CAMPAIGN withFinishedBlock:operationFinishedBlock];
    
    TCEND
    
    
}
- (void)addToGoogleCalendarEventWithDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"user_id"    To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"camp_id" To:bodyData UnderKey:@"camp_id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"availibility_time" To:bodyData UnderKey:@"availibility_time"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"availibility_date" To:bodyData UnderKey:@"availibility_date"  OnMethodName:METHOD_NAME];

    
    
    [self performPostRequestWithBody:bodyData toUrl:ADD_TO_CALENDAR withFinishedBlock:operationFinishedBlock];
    
    TCEND
    
    
    
    
    
}
- (void)getAlreadyAddedCalendarEvents:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
    TCSTART
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    NSMutableDictionary *bodyData = [[NSMutableDictionary alloc]init];
    [AKSMethods addParameterFrom:info WithKey:@"oauth_key" To:bodyData UnderKey:@"oauth_key"   OnMethodName:METHOD_NAME];
	[AKSMethods addParameterFrom:info WithKey:@"user_id"    To:bodyData UnderKey:@"user_id"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"device_key" To:bodyData UnderKey:@"device_key"  OnMethodName:METHOD_NAME];
    [AKSMethods addParameterFrom:info WithKey:@"camp_id" To:bodyData UnderKey:@"camp_id"  OnMethodName:METHOD_NAME];
    
    [self performGetRequestWithBody:bodyData toUrl:GET_EVENTS_OF_CALENDAR withFinishedBlock:operationFinishedBlock];
    
    TCEND
    
}
-(void)postTextInCommentService:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{


    [self performPostRequestWithBody:info toUrl:POST_COMMENT_ON_THREAD constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {} withFinishedBlock:operationFinishedBlock];
    


}
-(void)postImageInCommentService:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
	TCSTART
    
    
    
    
    [self performPostRequestWithBody:info toUrl:POST_COMMENT_ON_THREAD constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if([info objectForKey:@"comment_image"])
        {
            [formData appendPartWithFileData:UIImagePNGRepresentation([info objectForKey:@"comment_image"]) name:@"comment_image" fileName:[NSString stringWithFormat:@"%@1_image.png",[[NSDate date] string]] mimeType:@"image/png"];
        }

    } withFinishedBlock:operationFinishedBlock];
    
	TCEND
}
-(void)postVideoInCommentService:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
	TCSTART
    
    
    
    
    [self performPostRequestWithBody:info toUrl:POST_COMMENT_ON_THREAD constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if([info objectForKey:@"comment_image"])
        {
            [formData appendPartWithFileData:[info objectForKey:@"comment_image"] name:@"comment_image" fileName:[NSString stringWithFormat:@"%@1_video.mp4",[[NSDate date] string]] mimeType:@"video/mp4"];
        }
        
        if([info objectForKey:@"video_thumb"])
        {
            [formData appendPartWithFileData:UIImagePNGRepresentation([info objectForKey:@"video_thumb"]) name:@"video_thumb" fileName:[NSString stringWithFormat:@"%@1_thumbImage.png",[[NSDate date] string]] mimeType:@"image/png"];
        }

        
    } withFinishedBlock:operationFinishedBlock];
    
	TCEND
}
-(void)postDocFileInCommentService:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
	TCSTART
    
    
    
    
    [self performPostRequestWithBody:info toUrl:POST_COMMENT_ON_THREAD constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if([info objectForKey:@"comment_image"])
        {
            [formData appendPartWithFileData:[info objectForKey:@"comment_image"] name:@"comment_image" fileName:[NSString stringWithFormat:@"%@1_doc.pdf",[[NSDate date] string]] mimeType:@"application/pdf"];
        }

        
    } withFinishedBlock:operationFinishedBlock];
    
	TCEND
}

#pragma mark--- buyer service

-(void)sendMessageWithOrWithoutAttachmentInMessageService:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock{
    
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG


    TCSTART
    if([(NSString*)[info objectForKey:@"message_type"]isEqualToString:@"1"])
    {
    //simple text send
      [self performPostRequestWithBody:info toUrl:SEND_MAIL_URL constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {} withFinishedBlock:operationFinishedBlock];

    }
    else if([(NSString*)[info objectForKey:@"message_type"]isEqualToString:@"2"])
    {
        //only image send
        [self performPostRequestWithBody:info toUrl:SEND_MAIL_URL constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            if([info objectForKey:@"message_image"])
            {
                [formData appendPartWithFileData:UIImagePNGRepresentation([info objectForKey:@"message_image"]) name:@"message_image" fileName:[NSString stringWithFormat:@"%@_image.png",[[NSDate date] string]] mimeType:@"image/png"];
            }
            
        } withFinishedBlock:operationFinishedBlock];

    }
    else if([(NSString*)[info objectForKey:@"message_type"]isEqualToString:@"3"])
    {
        //only doc send
        [self performPostRequestWithBody:info toUrl:SEND_MAIL_URL constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            if([info objectForKey:@"message_image"])
            {
                NSString*fileName = [info objectForKey:@"file_text"];
                NSLog(@"extension >>>>%@",[fileName pathExtension]);
                fileName = [NSString stringWithFormat:@"%@.%@",[[NSDate date] string],[fileName pathExtension]];

                [formData appendPartWithFileData:[info objectForKey:@"message_image"] name:@"message_image" fileName:fileName mimeType:@"application/*"];
            }
            
            
        } withFinishedBlock:operationFinishedBlock];
        

        
    }
    else if([(NSString*)[info objectForKey:@"message_type"]isEqualToString:@"4"])
    {
        //only pdf send
        [self performPostRequestWithBody:info toUrl:SEND_MAIL_URL constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            if([info objectForKey:@"message_image"])
            {
                NSString*fileName = [info objectForKey:@"file_text"];
                NSLog(@"extension >>>>%@",[fileName pathExtension]);
                fileName = [NSString stringWithFormat:@"%@.%@",[[NSDate date] string],[fileName pathExtension]];

                
                [formData appendPartWithFileData:[info objectForKey:@"message_image"] name:@"message_image" fileName:fileName mimeType:@"application/pdf"];
            }
            
            
        } withFinishedBlock:operationFinishedBlock];
        
        
    }
    else if([(NSString*)[info objectForKey:@"message_type"]isEqualToString:@"5"])
    {
        //only video send
        [self performPostRequestWithBody:info toUrl:SEND_MAIL_URL constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            if([info objectForKey:@"message_image"])
            {
                [formData appendPartWithFileData:[info objectForKey:@"message_image"] name:@"message_image" fileName:[NSString stringWithFormat:@"%@_video.mp4",[[NSDate date] string]] mimeType:@"video/mp4"];
            }
            
            if([info objectForKey:@"video_thumb"])
            {
                [formData appendPartWithFileData:[info objectForKey:@"video_thumb"] name:@"video_thumb" fileName:[NSString stringWithFormat:@"%@_thumbImage.png",[[NSDate date] string]] mimeType:@"image/png"];
            }
            
            
        } withFinishedBlock:operationFinishedBlock];
    }
    
   
    
	TCEND

}
#pragma mark - my methods ends

/*
 My Methods
 */

- (void)performPostRequestWithBody:(NSMutableDictionary*)bodyData toUrl:(NSString*)url withFinishedBlock:(operationFinishedBlock)operationFinishedBlock{
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    
    id json = [bodyData JSONRepresentation];
   NSLog(@"json === >>%@",json);
    
    
    
    NSString *urlToHit = [[NSString stringWithFormat:url, BASE_URL] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    if (progresssIndicatorText != nil)
		[CommonFunctions showActivityIndicatorWithText:progresssIndicatorText];
    
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	[manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
	[manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    
	[manager POST:urlToHit parameters:bodyData success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@" Response == %@",responseObject);
        
	    [self verifyServerResponseAndPerformAction:operationFinishedBlock WithResponseData:responseObject IfError:nil];
        
	} failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@" Response error == %@",error);

	    [self verifyServerResponseAndPerformAction:operationFinishedBlock WithResponseData:nil IfError:error];
	}];
    
    
}

- (void)performPutRequestWithBody:(NSMutableDictionary*)bodyData toUrl:(NSString*)url withFinishedBlock:(operationFinishedBlock)operationFinishedBlock{
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    id json = [bodyData JSONRepresentation];
    NSLog(@"json === >>%@",json);

    
    
    NSString *urlToHit = [[NSString stringWithFormat:url, BASE_URL] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    if (progresssIndicatorText != nil)
		[CommonFunctions showActivityIndicatorWithText:progresssIndicatorText];
    
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	[manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
	[manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
	[manager PUT:urlToHit parameters:bodyData success: ^(AFHTTPRequestOperation *operation, id responseObject) {
	    [self verifyServerResponseAndPerformAction:operationFinishedBlock WithResponseData:responseObject IfError:nil];
	} failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
	    [self verifyServerResponseAndPerformAction:operationFinishedBlock WithResponseData:nil IfError:error];
	}];
    
    
}

- (void)performDeleteRequestWithBody:(NSMutableDictionary*)bodyData toUrl:(NSString*)url withFinishedBlock:(operationFinishedBlock)operationFinishedBlock{

    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    id json = [bodyData JSONRepresentation];
    NSLog(@"json === >>%@",json);

    
    
    NSString *urlToHit = [[NSString stringWithFormat:url, BASE_URL] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    if (progresssIndicatorText != nil)
		[CommonFunctions showActivityIndicatorWithText:progresssIndicatorText];
    
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	[manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
	[manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    
	[manager DELETE:urlToHit parameters:bodyData success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@" Response == %@",responseObject);
        
	    [self verifyServerResponseAndPerformAction:operationFinishedBlock WithResponseData:responseObject IfError:nil];
        
        
	} failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@" Response error == %@",error);
        
	    [self verifyServerResponseAndPerformAction:operationFinishedBlock WithResponseData:nil IfError:error];
	}];

    
    
    
    
    
    


}
- (void)performGetRequestWithBody:(NSMutableDictionary*)bodyData toUrl:(NSString*)url withFinishedBlock:(operationFinishedBlock)operationFinishedBlock{
    
    //CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    id json = [bodyData JSONRepresentation];
    NSLog(@"json === >>%@",json);

    
    NSString *urlToHit = [[NSString stringWithFormat:url, BASE_URL] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    if (progresssIndicatorText != nil)
		[CommonFunctions showActivityIndicatorWithText:progresssIndicatorText];
    
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	[manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
	[manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    
	[manager GET:urlToHit parameters:bodyData success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
	    [self verifyServerResponseAndPerformAction:operationFinishedBlock WithResponseData:responseObject IfError:nil];
        
        
	} failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
	    [self verifyServerResponseAndPerformAction:operationFinishedBlock WithResponseData:nil IfError:error];
        
        
	}];
    
    
}
- (void)performPagingRequestWithBody:(NSMutableDictionary*)bodyData toUrl:(NSString*)url withFinishedBlock:(operationFinishedBlock)operationFinishedBlock{
    
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
   // NSString *urlToHit = [[NSString stringWithFormat:@"%@%@",BASE_URL,url ] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    id json = [bodyData JSONRepresentation];
    NSLog(@"json === >>%@",json);

    NSString *urlToHit = [NSString stringWithFormat:@"%@%@",BASE_URL,url];

    if (progresssIndicatorText != nil)
		[CommonFunctions showActivityIndicatorWithText:progresssIndicatorText];
    
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	[manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
	[manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    
	[manager GET:urlToHit parameters:bodyData success: ^(AFHTTPRequestOperation *operation, id responseObject) {
	    [self verifyServerResponseAndPerformAction:operationFinishedBlock WithResponseData:responseObject IfError:nil];
	} failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
	    [self verifyServerResponseAndPerformAction:operationFinishedBlock WithResponseData:nil IfError:error];
	}];
    
    
}

- (void)performPostRequestWithBody:(NSMutableDictionary*)bodyData toUrl:(NSString*)url constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block withFinishedBlock:(operationFinishedBlock)operationFinishedBlock{
    CONTINUE_IF_CONNECTION_AVAILABLE_SHOW_ERROR_MSG
    
    id json = [bodyData JSONRepresentation];
    NSLog(@"json === >>%@",json);

    
    NSString *urlToHit = [[NSString stringWithFormat:url, BASE_URL] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    if (progresssIndicatorText != nil)
      [CommonFunctions showActivityIndicatorWithText:progresssIndicatorText];
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	[manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
	[manager POST:urlToHit parameters:bodyData constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        block(formData);
    }success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
	    [self verifyServerResponseAndPerformAction:operationFinishedBlock WithResponseData:responseObject IfError:nil];
	} failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
	    [self verifyServerResponseAndPerformAction:operationFinishedBlock WithResponseData:nil IfError:error];
	}];
}


- (void)verifyServerResponseAndPerformAction:(operationFinishedBlock)block WithResponseData:(id)responseData IfError:(NSError *)error {
	BOOL removeActivityIndicator = (progresssIndicatorText != nil);
	if (removeActivityIndicator)
		[CommonFunctions removeActivityIndicator];
    
	if ([self isNotNull:error]) {
		[self showServerNotRespondingMessage];
		[FeedItemServices printErrorMessage:error];
		block(nil);
	}
	else if ([self isNotNull:responseData]) {
		id responseDictionary = [self getParsedDataFrom:responseData];
		if ([responseDictionary isKindOfClass:[NSDictionary class]]) {
			if ([self isSuccess:responseDictionary]) {
				block(responseDictionary);
			}
            else{
                if ([self isNotNull:[responseDictionary objectForKey:@"MESSAGE"]]) {

                    [CommonFunctions showToastMessageWithMessage:[responseDictionary objectForKey:@"MESSAGE"]];
                }
                block(nil);
            }

//			else if (!([[NSString stringWithFormat:@"%@",[responseDictionary objectForKey:@"CODE"]] isEqualToString:@"200"])) {
//				NSString *errorMessage = nil;
//                
//				if ([self isNotNull:[responseDictionary objectForKey:@"MESSAGE"]]) {
//					errorMessage = [responseDictionary objectForKey:@"MESSAGE"];
//				}
//				else {
//					errorMessage = MESSAGE_TEXT___FOR_SERVER_NOT_REACHABILITY;
//				}
//                
//				if (responseErrorOption == ShowErrorResponseWithUsingNotification) {
//					[CommonFunctions showNotificationInViewController:APPDELEGATE.window.rootViewController withTitle:nil withMessage:errorMessage withType:TSMessageNotificationTypeError withDuration:MIN_DUR];
//				}
//				else if (responseErrorOption == ShowErrorResponseWithUsingPopUp) {
//					[CommonFunctions showMessageWithTitle:@"Error" withMessage:errorMessage];
//				}
//				block(nil);
//			}
			//else {
				//[self showServerNotRespondingMessage];
				//block(responseDictionary);
			//}
		}
		else {
			block(nil);
		}
	}
	else {
		block(nil);
	}
}

#pragma mark - common method for Internet reachability checking

- (BOOL)getStatusForNetworkConnectionAndShowUnavailabilityMessage:(BOOL)showMessage {
	AppDelegate *appDelegate = APPDELEGATE;
	if (([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)) {
		if (showMessage == NO) return NO;
		[CommonFunctions showNotificationInViewController:appDelegate.window.rootViewController withTitle:MESSAGE_TITLE___FOR_NETWORK_NOT_REACHABILITY withMessage:MESSAGE_TEXT___FOR_NETWORK_NOT_REACHABILITY withType:TSMessageNotificationTypeError withDuration:MIN_DUR];
		return NO;
	}
	return YES;
}

- (void)showServerNotRespondingMessage {
	[CommonFunctions showNotificationInViewController:APPDELEGATE.window.rootViewController withTitle:MESSAGE_TITLE___FOR_SERVER_NOT_REACHABILITY withMessage:MESSAGE_TEXT___FOR_SERVER_NOT_REACHABILITY withType:TSMessageNotificationTypeError withDuration:MIN_DUR];
}

#pragma mark - common method parse and return the data

- (id)getParsedDataFrom:(NSData *)dataReceived {
	NSString *dataAsString = [[NSString alloc] initWithData:dataReceived encoding:NSUTF8StringEncoding];
	id parsedData   = [[[SBJsonParser alloc]init] objectWithString:dataAsString];
    
	NSLog(@"\n\nRECEIVED DATA BEFORE PARSING IS \n\n%@\n\n\n", dataAsString);
	NSLog(@"\n\nRECEIVED DATA AFTER PARSING IS \n\n%@\n\n\n", parsedData);

	return parsedData;
}

- (void)prepareRequestForGetMethod:(NSMutableURLRequest *)request {
	[self addCredentialsToRequest:request];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
}

- (void)reportMissingParameterWithName:(NSString *)missingParameter WhileRequestingWithMethodName:(NSString *)method {
	NSString *report = [NSString stringWithFormat:@"\n\n\n PARAMETER MISSING\n\nPARAMETER NAME IS : %@ \n\nIN METHOD : %@ \n\n PLEASE CORRECT IT ASAP\n\n", missingParameter, method];
	NSLog(@"%@", report);
}

- (BOOL)isSuccess:(NSMutableDictionary *)response {
	if ([response isKindOfClass:[NSDictionary class]]) {
		if ([[NSString stringWithFormat:@"%@", [response objectForKey:@"CODE"]] isEqualToString:@"200"]||[[NSString stringWithFormat:@"%@", [response objectForKey:@"CODE"]] isEqualToString:@"400"]||[[NSString stringWithFormat:@"%@", [response objectForKey:@"CODE"]] isEqualToString:@"401"]) {
			return YES;
		}
        else {
        
            [CommonFunctions showToastMessageWithMessage:[response objectForKey:@"MESSAGE"]];
            return NO;
        }
	}
    else{
        
        [CommonFunctions showToastMessageWithMessage:@"Parsing Error"];
        
	return NO;
    }
}

#pragma mark - common method to add credentials to request

- (void)addCredentialsToRequest:(NSMutableURLRequest *)request {
#define NEED_TO_ADD_CREDENTIALS FALSE
	if (NEED_TO_ADD_CREDENTIALS) {
		NSString *userName = @"";
		NSString *password = @"";
		if ([self isNotNull:userName] && [self isNotNull:password]) {
			[request addValue:[@"Basic "stringByAppendingFormat : @"%@", [self encode:[[NSString stringWithFormat:@"%@:%@", userName, password] dataUsingEncoding:NSUTF8StringEncoding]]] forHTTPHeaderField:@"Authorization"];
		}
	}
}

#pragma mark - common method to do some encoding

static char *alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
- (NSString *)encode:(NSData *)plainText {
	int encodedLength = (4 * (([plainText length] / 3) + (1 - (3 - ([plainText length] % 3)) / 3))) + 1;
	unsigned char *outputBuffer = malloc(encodedLength);
	unsigned char *inputBuffer = (unsigned char *)[plainText bytes];
	NSInteger i;
	NSInteger j = 0;
	int remain;
	for (i = 0; i < [plainText length]; i += 3) {
		remain = [plainText length] - i;
		outputBuffer[j++] = alphabet[(inputBuffer[i] & 0xFC) >> 2];
		outputBuffer[j++] = alphabet[((inputBuffer[i] & 0x03) << 4) |
		                             ((remain > 1) ? ((inputBuffer[i + 1] & 0xF0) >> 4) : 0)];
        
		if (remain > 1)
			outputBuffer[j++] = alphabet[((inputBuffer[i + 1] & 0x0F) << 2)
			                             | ((remain > 2) ? ((inputBuffer[i + 2] & 0xC0) >> 6) : 0)];
		else outputBuffer[j++] = '=';
        
		if (remain > 2) outputBuffer[j++] = alphabet[inputBuffer[i + 2] & 0x3F];
		else outputBuffer[j++] = '=';
	}
	outputBuffer[j] = 0;
	NSString *result = [NSString stringWithCString:outputBuffer length:strlen(outputBuffer)];
	free(outputBuffer);
	return result;
}

+ (void)printErrorMessage:(NSError *)error {
	if (error) {
		NSLog(@"[error localizedDescription]        : %@", [error localizedDescription]);
		NSLog(@"[error localizedFailureReason]      : %@", [error localizedFailureReason]);
		NSLog(@"[error localizedRecoverySuggestion] : %@", [error localizedRecoverySuggestion]);
	}
}

@end
