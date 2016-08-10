//
//  SecondViewController.h
//  Lesson 7
//
//  Created by T on 30.07.16.
//  Copyright © 2016 Tanya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController

@property (strong, nonatomic) NSDate * eventDate;
@property (nonatomic, assign) BOOL isDetail;
@property (nonatomic, strong) NSDictionary * dictEvent;
@property (nonatomic, assign) NSInteger * index;

@property (weak, nonatomic) IBOutlet UILabel *labelStart;
@property (weak, nonatomic) IBOutlet UILabel *labelTimeValue;

@end
