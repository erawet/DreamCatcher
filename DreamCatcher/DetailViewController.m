//
//  DetailViewController.m
//  DreamCatcher
//
//  Created by Don Wettasinghe on 1/3/15.
//  Copyright (c) 2015 Don Wettasinghe. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextView *txtView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=self.titleString;
    self.txtView.text=self.descriptionString;
    
}



@end
