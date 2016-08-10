//
//  ViewController.m
//  Lesson 7
//
//  Created by T on 30.07.16.
//  Copyright © 2016 Tanya. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

- (IBAction)addAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * arrayEvents;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayEvents = [[NSMutableArray alloc]init];

}
//  Метод срабатывает когда экран почти загружен - но еще не виден!
- (void) viewWillAppear:(BOOL)animated {
    
    [self.arrayEvents removeAllObjects];
    
    NSArray * arrayEvent = [[NSUserDefaults standardUserDefaults] arrayForKey:@"eventDetail"];
    
    NSMutableArray * arrayM = [[NSMutableArray alloc] initWithArray:arrayEvent];

    self.arrayEvents = arrayM;
    
    [self.tableView reloadData];

}
//  Метод срабатывает когда экран загружен!
- (void) viewDidAppear:(BOOL)animated {
    
}
//  Метод срабатывает когда экран почти погас, например, когда пользователь переходит на другое окно приложения!
- (void) viewWillDisappear:(BOOL)animated {
    
}
//  Метод срабатывает когда экран погас, пользователь ушел на другое окно или выключил приложение!
- (void) viewDidDisappear:(BOOL)animated {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addAction:(id)sender {
    
    SecondViewController * second = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondView"];
    
    second.isDetail = NO;
    
    [self.navigationController pushViewController:second animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrayEvents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * identifier = @"Cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    NSDictionary * dict = [self.arrayEvents objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [dict objectForKey: @"eventValue"];
    
    NSNumber * boolNumber = [dict valueForKey:@"eventStatus"];
    
    NSDate * eventDate = [dict valueForKey:@"eventDate"];
    
    BOOL isFinished = [boolNumber boolValue];
    
    if (!isFinished) {
        cell.detailTextLabel.text = @"Выполняется";
    }
    else {
        
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary * dict = [self.arrayEvents objectAtIndex:indexPath.row];

    SecondViewController * second = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondView"];
    
    second.isDetail = YES;
    
    second.dictEvent = dict;
    
    second.index = indexPath.row;
    
    [self.navigationController pushViewController:second animated:YES];
 
}

@end
