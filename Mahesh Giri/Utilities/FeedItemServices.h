//
//  Last Updated by Alok on 19/02/14.
//  Copyright (c) 2014 Aryansbtloe. All rights reserved.
//

/**
 FeedItemServices:-
 This service class initiates and handles all server interaction related network connection.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, ResponseErrorOption) {
	DontShowErrorResponseMessage = 0,
	ShowErrorResponseWithUsingNotification, //Default value is set to this option
	ShowErrorResponseWithUsingPopUp
};

@class AppDelegate;

typedef void (^operationFinishedBlock)(id responseData);
typedef void (^operationFinishedBlockWithOutUpdate)();


@interface FeedItemServices : NSObject

@property (nonatomic, readwrite) ResponseErrorOption responseErrorOption;
@property (nonatomic, retain) NSString *progresssIndicatorText;

/**
 login user
 */
- (void)signupUserWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
- (void)loginUserWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
- (void)userForgotWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
- (void)userConfirmWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
- (void)logoutUserWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
- (void)userAttributeWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
- (void)userLocationWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
- (void)userSearchWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
- (void)addInterestWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
- (void)agentRatingWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;


#pragma mark -Himanshu

-(void)userInterestedCampaignBuyerWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;

-(void)userCampaignProposedWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;

- (void)userCampaignBuyerDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
-(void)userChangePasswordServiceWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
- (void)getMainThreadOfAgentWithDetail:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
- (void)getCommentForThreadWithDetail:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
- (void)postCommentForThreadWithDetail:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
- (void)getMyAddedRquirementHistoryWithDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
- (void)activateRequirementFromRquirementHistoryWithDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
- (void)addUserDocServiceWithInfo:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock ;
- (void)removeUserDocServiceWithInfo:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;

- (void)submitEditProfileWithInfo:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock ;
- (void)deleteCommentForThreadWithDetail:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
-(void)blockAgentWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
- (void)getblockedAgentListDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;

- (void)updateRequirementWithDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
- (void)getContactListOfCampaignWithSearchStringAndDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;

- (void)getInboxOutboxSyncWithData:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;

- (void)getConversationListWithData:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;

- (void)composeAndSendMailWithDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
- (void)deleteConversationWithDetail:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
- (void)bidTheCampWithDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;

- (void)addToGoogleCalendarEventWithDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;

- (void)getAlreadyAddedCalendarEvents:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;

-(void)setSoundSettingWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;

-(void)setNotificationSettingWith:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
- (void)getNotificationForUserWithDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
- (void)hitSeenNotificationService:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;

-(void)getSoldCampaignList:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;

-(void)getTrashedCampaignList:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
-(void)moveToTrashToCampaign:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;

-(void)removeFromTrashToCampaign:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;

- (void)getProductTopupWithDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;


//for agent services
-(void)postImageInCommentService:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
-(void)postVideoInCommentService:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
-(void)postDocFileInCommentService:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;
-(void)postTextInCommentService:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;

//agent ends

-(void)sendMessageWithOrWithoutAttachmentInMessageService:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;

- (void)getProductTopupIDWithDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;

- (void)StoreTopUpAmountWithDetails:(NSMutableDictionary *)info didFinished:(operationFinishedBlock)operationFinishedBlock;




#pragma mark ends


@end


#define TRUE_FOR_LOCAL_SERVER____FALSE_FOR_GLOBAL_SERVER 0

//http://buyingbuddy.indiatomorrow.in/    >> client url
//http://buyingbuddydev.indiatomorrow.in/   >> company url


//#define BASE_URL                          @"http://buyingbuddy.indiatomorrow.in/"

#define BASE_URL                          @"http://buyingbuddydev.indiatomorrow.in/"



/**
 LOGIN USER :
 */
#define SIGNUP_URL                            @"%@signup"
#define LOGIN_URL                             @"%@login"
#define FORGOT_URL                            @"%@forgot"
#define LOGOUT_URL                            @"%@logout/post"
#define ATTRIBUTE_URL                         @"%@attribute/get"
#define LOCATION_URL                          @"%@location/get"
#define ADD_SEARCH_URL                        @"%@searchcampaigns/post"
#define UPDATE_SEARCH_URL                     @"%@searchcampaigns/put"

#define CAMPAIGN_URL                          @"%@campbuyers/get"
#define CAMPAIGN_PROPOSED_URL                 @"%@campbuyers/get"
#define CAMPAIGN_INTERESTED_URL               @"%@interest/get"

#define ADD_INTEREST_URL                      @"%@interest/"
#define RATING_URL                            @"%@rating"



#pragma mark Himanshu

#define CHANGE_PASSWORD_URL                   @"%@forgot"
#define GET_MAIN_THREAD                       @"%@thread/get"
#define GET_COMMENT_THREAD                    @"%@comment/get"
#define POST_COMMENT_ON_THREAD                @"%@comment"
#define DELETE_COMMENT_ON_THREAD              @"%@comment/delete"

#define REUIREMENT_HISTORY                    @"%@Searchcampaigns/get"
#define ACTIVATE_REUIREMENT                   @"%@Searchcampaigns/put"
#define ADD_USER_DOC                          @"%@campbuyers"
#define REMOVE_USER_DOC                       @"%@campbuyers/delete"
#define SUBMIT_USER_EDIT_PROFILE              @"%@profile/put"
#define BLOCK_AGENT                           @"%@segment"
#define BLOCKED_AGENT_LIST_URL                @"%@segment/get"
#define UPDATE_REUIREMENT_URL                 @"%@searchcampaigns"

#define SEARCH_CONTACT_CAMPAIGN               @"%@campaign/get"
#define SYNC_INBOX_OUTBOX_URL                 @"%@message/get"
#define GET_CONVERSATION_LIST                 @"%@msgconversation/get"
#define SEND_MAIL_URL                         @"%@message"

#define DELETE_CONVERSATION_URL               @"%@msgconversation"

#define BID_ON_CAMPAIGN                       @"%@bid"


#define ADD_TO_CALENDAR                       @"%@availability"
#define GET_EVENTS_OF_CALENDAR                @"%@availability/get"
#define SOUND_NOTI_SETTING                    @"%@notification"
#define GET_USER_NOTIFICATION                 @"%@notification"
#define GET_GLOBAL_NOTIFICATION_COUNT         @"%@notification"
#define SEEN_NOTIFICATION_SERVICE             @"%@notification"
#define GET_SOLD_CAMAPIGN                     @"%@campbuyers/get"
#define GET_TRASH_CAMAPIGN                    @"%@trash/get"

#define MOVE_TO_TRASH_CAMAPIGN                @"%@trash"
#define REMOVE_FROM_TRASH_CAMAPIGN            @"%@trash"


#define GET_PRODUCTID_FOR_TOPUP               @"%@productids/get"
#define GET_STORE_AMOUNT_TOPUP                @"%@transaction"
#define PRODUCT_ID_DETAILS                    @"%@transaction/get"


