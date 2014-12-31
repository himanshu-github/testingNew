//
//  BaseScreenVC.m
//  Mahesh Giri
//
//  Created by Himanshu Gupta on 09/07/14.
//  Copyright (c) 2014 AppStudioz Technology Pvt. Ltd. All rights reserved.
//

#import "BaseScreenVC.h"
#import "IIViewDeckController.h"
@interface BaseScreenVC ()

@end

@implementation BaseScreenVC

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
    
    
    
    
    IIViewDeckController *deck = [[IIViewDeckController alloc] initWithCenterViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"HomePageVC"] leftViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SideMenuVC"]];
    [self.navigationController pushViewController:deck animated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}



@end
