//
//  SecondViewController.m
//  Lesson 7
//
//  Created by T on 30.07.16.
//  Copyright © 2016 Tanya. All rights reserved.
//

#import "SecondViewController.h"
#import "AppConstants.h"

@interface SecondViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *buttonSave;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.buttonSave addTarget:self action:@selector(startStopEvent) forControlEvents:UIControlEventTouchUpInside];
    
    if (!self.isDetail) {
                
        [self.textField becomeFirstResponder];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBackgroundTap:)];
        
        [self.view addGestureRecognizer:tap];
        
        self.labelStart.text = NSLocalizedString(@"", nil);
        
        self.labelTimeValue.text = NSLocalizedString(@"", nil);
        
        [self.buttonSave setTitle:@"START" forState:UIControlStateNormal];
        
        [self.buttonSave setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        
    }
    
    else {
        
        self.textField.userInteractionEnabled = NO;
        
        self.textField.text = [self.dictEvent objectForKey:@"eventValue"];
        
        NSNumber * boolNumber = [self.dictEvent valueForKey:@"eventStatus"];
        
        BOOL isFinished = [boolNumber boolValue];
        
        if (!isFinished) {
            
            NSDate * eventDate = [self.dictEvent valueForKey:@"eventDate"];
            
            NSDate * currentDate = [NSDate date];
            
            NSTimeInterval interval = [currentDate timeIntervalSinceDate:eventDate];
            
            NSLog(@"%f", interval);
            
            double secondsInOneHour = 3600;
            
            double min = interval / 60;
            
            NSInteger hours = interval/secondsInOneHour;
            
            NSInteger minutes = min;
            
            self.labelStart.text = NSLocalizedString(@"Прошло времени с момент старта", nil);
            
            NSString * str = [NSString stringWithFormat:@"%i часов %i минут", hours, minutes];
            
            self.labelTimeValue.text = str;
            
            [self.buttonSave setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            
            [self.buttonSave setTitle:@"STOP" forState:UIControlStateNormal];
        }
        
        else {
            
            self.buttonSave.alpha = 0;
            
        }
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) handleBackgroundTap: (UITapGestureRecognizer *) tap {
    
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField isEqual:self.textField] && self.textField.text.length != 0) {
        
        self.buttonSave.userInteractionEnabled = YES;
        
        [self.textField resignFirstResponder];
        
        return YES;
    }
    
    else {
        
        [self alertMessage:@"Введите значение для события"];
    }
    
    return NO;
}

- (void) alertMessage : (NSString *) message{
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Внимание!" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    [alert show];
}

- (void) startStopEvent {
    
    if (!self.isDetail) {
        
        NSArray * arrayEvent = [[NSUserDefaults standardUserDefaults] arrayForKey:@"eventDetail"];
        
        NSMutableArray * arrayM;
        
        if (!arrayEvent) {
            
            arrayM = [[NSMutableArray alloc] init];
        }
        
        else {
            
            arrayM = [[NSMutableArray alloc]initWithArray:arrayEvent];
        }
        
        BOOL isFinished = NO;
        
        NSNumber * boolNumber = [NSNumber numberWithBool:isFinished];

    NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:self.textField.text,@"eventValue",
                           [NSDate date], @"eventDate",
                           boolNumber, @"eventStatus", nil];
        
        [arrayM addObject:dict];
        
    [[NSUserDefaults standardUserDefaults] setObject:arrayM forKey:@"eventDetail"];
        
    [self.buttonSave setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
    [self.buttonSave setTitle:@"STOP" forState:UIControlStateNormal];

    }
    
    else {
        
        NSArray * arrayEvent = [[NSUserDefaults standardUserDefaults] arrayForKey:@"eventDetail"];
        
        NSMutableArray * arrayM = [[NSMutableArray alloc] initWithArray:arrayEvent];

        [arrayM removeObjectAtIndex:self.index];
        
        
        NSDate * eventDate = [self.dictEvent valueForKey:@"eventDate"];
        
        NSDate * currentDate = [NSDate date];
        
        NSTimeInterval interval = [currentDate timeIntervalSinceDate:eventDate];
        
        double secondsInOneHour = 3600;
        
        double min = interval / 60;
        
        NSInteger hours = interval/secondsInOneHour;
        
        NSInteger minutes = min;
        
        NSString * str = [NSString stringWithFormat:@"%i часов %i минут", hours, minutes];
        
        BOOL isFinished = YES;
        
        NSNumber * boolNumber = [NSNumber numberWithBool:isFinished];

        NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:self.textField.text,@"eventValue",
                               [NSDate date], @"eventDate",
                               boolNumber, @"eventStatus", str, @"dateStoped", nil];

        self.buttonSave.userInteractionEnabled = NO;
        
        [arrayM insertObject:dict atIndex:self.index];
        
        [[NSUserDefaults standardUserDefaults] setObject:arrayM forKey:@"eventDetail"];
        
        NSLog(@"%@", dict);
        
    }
    
}

@end
