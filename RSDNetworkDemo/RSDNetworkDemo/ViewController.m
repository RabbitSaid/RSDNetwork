//
//  ViewController.m
//  RSDNetworkDemo
//
//  Created by Eiwodetianna on 16/11/2.
//  Copyright © 2016年 Eiwodetianna. All rights reserved.
//

#import "ViewController.h"
#import "TestAPIManager.h"

@interface ViewController ()

@property (nonatomic, strong) TestAPIManager *testAPI;

@end

@implementation ViewController

- (void)dealloc {

    [_testAPI cancelAllRequest];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.testAPI = [TestAPIManager new];


    
}
- (IBAction)buttonClicked:(id)sender {
    [_testAPI startLoadWithSuccess:^(RSDResponse *responseObject) {
        NSLog(@"isCatched : %d", responseObject.isCatched);
        NSLog(@"%@", responseObject.contentString);
    } failure:^(RSDResponse *responseObject) {
        NSLog(@"error:%@", responseObject.responseError);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
