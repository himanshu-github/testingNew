//
//  SideMenuVC.m
//  Mahesh Giri
//
//  Created by Himanshu Gupta on 09/07/14.
//  Copyright (c) 2014 AppStudioz Technology Pvt. Ltd. All rights reserved.
//

#import "SideMenuVC.h"

@interface SideMenuVC ()
@property (weak, nonatomic) IBOutlet UITableView * table;

@end

@implementation SideMenuVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
    [_table reloadData];
    
}

#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(IS_IPHONE)
    {
        if(IS_IPHONE_5)
        {
            if(indexPath.row==0)
            {
                return 100;
            }
            else{
                return 80;
            }
        }
        else if (IS_IPHONE_4)
        {
            if(indexPath.row==0)
            {
                return 110;
            }
            else{
                return 65;
            }
            
            
            
            
        }
        else{
            
            return 80;
            
        }
    }
    else{
        
        if(indexPath.row==0)
        {
            return 155;
        }
        else{
            return 145;
        }
        
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    cell=[tableView dequeueReusableCellWithIdentifier:@"SideMenu"];
    if(!cell)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SideMenu"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *lbl = (UILabel*)[cell.contentView viewWithTag:1];
    UILabel *notificatinLbl = (UILabel*)[cell.contentView viewWithTag:7];
    UILabel *amountLbl = (UILabel*)[cell.contentView viewWithTag:11];
    
    amountLbl.hidden = YES;
    
    UIImageView *imgV = (UIImageView*)[cell.contentView viewWithTag:2];
    if (IS_IPHONE)
    {
        //3.5 inch screen
        if(IS_IPHONE_5)
            lbl.frame = CGRectMake(0, 49, 80, 20);
        else
            lbl.frame = CGRectMake(0, 42, 80, 20);
        
        
        
    }
    else{
        
        
        
    }
    [self roundImgeViewWithBorder:notificatinLbl.layer Radius:notificatinLbl.frame.size.width/2.0 BorderWidth:0 andBorderColor:[UIColor clearColor]];
    notificatinLbl.textColor = [UIColor whiteColor];
    notificatinLbl.backgroundColor = [UIColor redColor];
    
    notificatinLbl.hidden = YES;
    
    
    if(IS_IPHONE)
    {
        lbl.font = [UIFont fontWithName:@"Roboto-Condensed" size:11.0];
        notificatinLbl.font = [UIFont fontWithName:@"Roboto-Condensed" size:12.0];
        
        
    }
    else if (IS_IPAD)
    {
        lbl.font = [UIFont fontWithName:@"Roboto-Condensed" size:20.0];
        notificatinLbl.font = [UIFont fontWithName:@"Roboto-Condensed" size:16.0];
        
    }
    
    lbl.textColor =[UIColor colorWithRed:89.0/255 green:89.0/255 blue:89.0/255 alpha:1.0];
    
    if(indexPath.row%2)
    {
        
        cell.contentView.backgroundColor = [UIColor colorWithRed:241.0/255 green:241.0/255 blue:241.0/255 alpha:1.0];
        
    }
    else{
        
        cell.contentView.backgroundColor = [UIColor colorWithRed:223.0/255 green:223.0/255 blue:223.0/255 alpha:1.0];
        
        
    }
    
    
    
    
    
    if(indexPath.row==0)
    {
        imgV.contentMode = UIViewContentModeScaleToFill;
        
        
        
    }
    else{
        
        imgV.contentMode = UIViewContentModeCenter;
        
    }
    
    
    UserInfo *info = [UserInfo MR_findFirst];
    amountLbl.hidden = YES;
    [self roundImgeViewWithBorder:imgV.layer Radius:0 BorderWidth:0 andBorderColor:[UIColor clearColor]];
    
    if(indexPath.row==0)
    {
        
        
        lbl.text = [NSString stringWithFormat:@"%@ %@",info.user_fname,info.user_lname];
        
        
       // amountLbl.text = [NSString stringWithFormat:@"$%@",[self getFormatttedString:info.amount]];
        
        //amountLbl.hidden = NO;
        
        amountLbl.textColor = [UIColor colorWithRed:89.0/255 green:89.0/255 blue:89.0/255 alpha:1.0];
        
        
        if(IS_IPHONE)
        {
            lbl.font = [UIFont fontWithName:@"Roboto-BoldCondensed" size:11.0];
            amountLbl.font = [UIFont fontWithName:@"Roboto-BoldCondensed" size:11.0];
            
            imgV.frame = CGRectMake(15, 19, 50.0, 50.0);
            [lbl setFrame:CGRectMake(0, 70, 80, 18)];
            if(IS_IPHONE_5)
                amountLbl.frame = CGRectMake(0, 80, 80, 20);
            else
                amountLbl.frame = CGRectMake(0, 85, 80, 20);
            
            [self roundImgeViewWithBorder:imgV.layer Radius:imgV.frame.size.width/2.0 BorderWidth:1.2 andBorderColor:[UIColor colorWithRed:45.0/255 green:181.0/255 blue:54.0/255 alpha:1.0]];
            
        }
        else if (IS_IPAD)
        {
            lbl.font = [UIFont fontWithName:@"Roboto-Condensed" size:20.0];
            amountLbl.font = [UIFont fontWithName:@"Roboto-Condensed" size:20.0];
            
            imgV.frame = CGRectMake(32, 25, 80, 80.0);
            [lbl setFrame:CGRectMake(0, 100, 143, 30)];
            amountLbl.frame = CGRectMake(0, 130, 143, 20);
            
            [self roundImgeViewWithBorder:imgV.layer Radius:imgV.frame.size.width/2.0 BorderWidth:2.5 andBorderColor:[UIColor colorWithRed:45.0/255 green:181.0/255 blue:54.0/255 alpha:1.0]];
            
        }
        
        
        
        
        
        
        if([self isNotNull:info.user_image])
        {
            NSString *userImageString = [info.user_image substringFromIndex:1];
            NSString* webName = [userImageString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString* stringURL = [NSString stringWithFormat:@"%@%@",BASE_URL,webName];
            NSURL* url = [NSURL URLWithString:stringURL];
            
            
            __weak UIImageView *image1=imgV;
            
            [image1 setImageWithURL:url placeholderImage:[UIImage imageNamed:@"profile_new.png"] options:0 completed:^(UIImage *image,NSError *error,SDImageCacheType type){
                [image1 setImage:image];
            }];
            
        }
        else{
            
            [imgV setImage:[UIImage imageNamed:@"profile_new.png"]];
        }
        
    }
    else if(indexPath.row==1)
    {
        if(IS_IPHONE)
            imgV.image = [UIImage imageNamed:@"myh matches.png"];
        else if (IS_IPAD)
            imgV.image = [UIImage imageNamed:@"mymatches_iPad"];
        
        lbl.text = @"My Matches";
        
        
    }
    else if(indexPath.row==2)
    {
        if(IS_IPHONE)
            imgV.image = [UIImage imageNamed:@"addsearch.png"];
        else if (IS_IPAD)
            imgV.image = [UIImage imageNamed:@"addsearch_iPad"];
        
        lbl.text = @"Add Search";
        
    }
    else if(indexPath.row==4)
    {
        if(IS_IPHONE)
            imgV.image = [UIImage imageNamed:@"messages.png"];
        else if (IS_IPAD)
            imgV.image = [UIImage imageNamed:@"message_iPad"];
        
        lbl.text = @"My Messages";
        
    }
    else if(indexPath.row==3)
    {
        if(IS_IPHONE)
            imgV.image = [UIImage imageNamed:@"notification.png"];
        else if (IS_IPAD)
            imgV.image = [UIImage imageNamed:@"my notification_iPad"];
        
        lbl.text = @"My Notifications";
        
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"GLOBAL_COUNT"])
        {
            
            NSString *globalCount = [[NSUserDefaults standardUserDefaults] objectForKey:@"GLOBAL_COUNT"];
            if(globalCount.integerValue>0)
                notificatinLbl.hidden = NO;
            else
                notificatinLbl.hidden = YES;
            
            notificatinLbl.text = globalCount;
            
            
        }
        
        
        
    }
       else if(indexPath.row==5)
    {
        if(IS_IPHONE)
            imgV.image = [UIImage imageNamed:@"settings.png"];
        else if (IS_IPAD)
            imgV.image = [UIImage imageNamed:@"settings_iPad"];
        
        lbl.text = @"Settings";
        
    }
    else if(indexPath.row==6)
    {
        if(IS_IPHONE)
            imgV.image = [UIImage imageNamed:@"logout.png"];
        else if (IS_IPAD)
            imgV.image = [UIImage imageNamed:@"logout_iPad"];
        
        lbl.text = @"LogOut";
        
    }
    
    
    
    
    
    
    return cell;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row==0)
    {
        [self performSelector:@selector(gotoProfilePage) withObject:nil afterDelay:0.0];
        
    }
    else if(indexPath.row==1)
    {
        [self performSelector:@selector(gotoMyMatchesPage) withObject:nil afterDelay:0.0];
        
        
    }
    else if(indexPath.row==2)
    {
        [self performSelector:@selector(gotoAddSearchPage) withObject:nil afterDelay:0.0];
        
        
    }
    else if(indexPath.row==3)
    {
        
        [self performSelector:@selector(gotoMyNotificationsPage) withObject:nil afterDelay:0.0];
        
    }
    else if(indexPath.row==4)
    {
        [self performSelector:@selector(gotoMyMessagePage) withObject:nil afterDelay:0.0];
        
    }
   
    
    else if(indexPath.row==5)
    {
        [self performSelector:@selector(gotoSettingPage) withObject:nil afterDelay:0.0];
        
    }
    else if(indexPath.row==6)
    {
        
        [self performSelector:@selector(gotoLogOutPage) withObject:nil afterDelay:0.0];
        
    }
    
    
}
//make round shape oh image view
-(void) roundImgeViewWithBorder:(CALayer *)layer Radius:(float)r BorderWidth:(float)w andBorderColor:(UIColor*)color
{
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:r];
    [layer setBorderWidth:w];
    [layer setBorderColor:color.CGColor];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
