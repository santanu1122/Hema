//
//  PContactWithHemaAdmin.m
//  Hema
//
//  Created by Mac on 13/01/15.
//  Copyright (c) 2015 Hema. All rights reserved.
//

#import "PContactWithHemaAdmin.h"
#import "UIColor+HexColor.h"
#import "UITextField+Attribute.h"
#import "UITextView+Extentation.h"

@interface PContactWithHemaAdmin () <UIScrollViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,UITextViewDelegate>

@property (nonatomic,retain) UIScrollView *MainScrollView;
@property (nonatomic,retain) UIView *HeaderNavigationViewBackgroundView;

@property (nonatomic,retain) UITextField * CTMessageTitle;
@property (nonatomic,retain) SDAPlaceholderTextView *CTMDetails;
@property (nonatomic,retain) UIButton * SubmitButton;
@end

@implementation PContactWithHemaAdmin

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self=((([[UIScreen mainScreen] bounds].size.height)>500))?[super initWithNibName:@"RegisterViewController" bundle:nil]:[super initWithNibName:@"RegisterViewController4s" bundle:nil];
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:[self UIViewSetHeaderViewWithbackButton:YES]];
    [self.view addSubview:[self UIViewSetFooterView]];
    [self.view addSubview:[self UIViewSetHeaderAfterLoginNavigationViewWithSelectedTab:@"Dashboard"]];
    
    _MainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, self.view.frame.size.height-150)];
    [_MainScrollView setUserInteractionEnabled:YES];
    [_MainScrollView setContentSize:CGSizeMake(self.view.frame.size.width, 500)];
    [_MainScrollView setDelegate:self];
    [self.view addSubview:_MainScrollView];
    
    UILabel *WelcomeMessage = [[UILabel alloc] initWithFrame:CGRectMake(10, 15,  self.view.frame.size.width-10, 20)];
    [WelcomeMessage setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [WelcomeMessage setTextColor:[UIColor darkGrayColor]];
    [WelcomeMessage setBackgroundColor:[UIColor clearColor]];
    [WelcomeMessage setTextAlignment:NSTextAlignmentLeft];
    [WelcomeMessage setText:@"Contact With HEMA Admin"];
    [_MainScrollView addSubview:WelcomeMessage];
    
    UILabel *WelcomeUnderline = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, self.view.frame.size.width-20, 1)];
    [WelcomeUnderline setBackgroundColor:[UIColor lightGrayColor]];
    [_MainScrollView addSubview:WelcomeUnderline];
    
    //float StatingYPosition = 50.0f;
    float Difference       = 50.0f;
    float LastPosition     = 70.0f;
    int nextdatatag        = 2001;
    float TextfieldWidth   = self.view.frame.size.width-40;
    float TextfieldHeight  = 40;
    float TextfieldXposition  = 20;
    float SubmitButtonWidth = 140.0f;
    float SubmitButtonHeight = 40.0f;
    float SubmitButtonxposition = (self.view.frame.size.width-SubmitButtonWidth)/2;
    
    // Password *
    
    self.CTMessageTitle = [[UITextField alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, TextfieldHeight)];
    [self.CTMessageTitle customizeWithPlaceholderText:@"Message Title" andImageOnRightView:nil andLeftBarText:@"*"];
    [self.CTMessageTitle setTag:nextdatatag];
    [_MainScrollView addSubview:self.CTMessageTitle];
    
    LastPosition = LastPosition + Difference;
    nextdatatag  = nextdatatag +1;
    // Confirm Password *
    
    self.CTMDetails = [[SDAPlaceholderTextView alloc] initWithFrame:CGRectMake(TextfieldXposition, LastPosition, TextfieldWidth, 100)];
    [self.CTMDetails setPlaceholder:@"Description"];
    [self.CTMDetails setPlaceholderColor:[UIColor colorFromHex:0x755049]];
    [self.CTMDetails setTag:nextdatatag];
    [_MainScrollView addSubview:self.CTMDetails];
    
    LastPosition = LastPosition + Difference*2;
    nextdatatag  = nextdatatag +1;
    
    _SubmitButton = [[UIButton alloc] initWithFrame:CGRectMake(SubmitButtonxposition ,LastPosition+50, SubmitButtonWidth, SubmitButtonHeight)];
    [_SubmitButton setBackgroundColor:[UIColor colorFromHex:0xe66a4c]];
    [_SubmitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [_SubmitButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:12.0f]];
    [_SubmitButton.layer setCornerRadius:3.0f];
    [_SubmitButton addTarget:self action:@selector(ChangePasswordProcess:) forControlEvents:UIControlEventTouchUpInside];
    [_SubmitButton setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
    [_SubmitButton setTag:104];
    [_MainScrollView addSubview:_SubmitButton];
    
    for(id aSubView in [_MainScrollView subviews])
    {
        if([aSubView isKindOfClass:[UITextField class]])
        {
            UITextField *textField=(UITextField*)aSubView;
            [textField setDelegate:self];
        }
    }
    
    for(id ASubview in [_MainScrollView subviews])
    {
        if([ASubview isKindOfClass:[UITextView class]])
        {
            UITextView *textView = (UITextView *)ASubview;
            [textView setDelegate:self];
            [textView.layer setBorderColor:[UIColor colorFromHex:0xe66a4c].CGColor];
            [textView.layer setBorderWidth:1.0f];
            NSLog(@"textView ---- %ld",(long)textView.tag);
        }
    }
}

#pragma mark - UITextField Delegates

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    for(id aSubView in [_MainScrollView subviews])
    {
        if([aSubView isKindOfClass:[UITextField class]])
        {
            UITextField *textField=(UITextField*)aSubView;
            [textField resignFirstResponder];
        }
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:1.0f animations:^(void){
        //[_MainScrollView setContentOffset:CGPointMake(0, -20) animated:YES];
    }];
    [textField resignFirstResponder];
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

#pragma Contact to Hema Admin

-(IBAction)ChangePasswordProcess:(id)sender
{
    
}

@end
