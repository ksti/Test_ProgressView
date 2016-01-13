//
//  ViewController.m
//  Test_ProgressView
//
//  Created by forp on 16/1/8.
//  Copyright © 2016年 forp. All rights reserved.
//

#import "ViewController.h"
#import "SDViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonActionToSDViewController:(id)sender {
    SDViewController *sdVC = [SDViewController new];
    [self.navigationController pushViewController:sdVC animated:YES];
}

@end
