//
//  ViewController.m
//  SuperHeroPedia
//
//  Created by Basel Farag on 8/4/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property NSArray *heroes;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSDictionary *superman = @{@"name": @"superperson", @"age": @"31"};
//    NSDictionary *spiderman = @{@"name": @"spiderman", @"age": @"18"};
//    self.heroes = [NSArray arrayWithObjects:superman, spiderman, nil];

    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/superheroes.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *rsp, NSData *data, NSError *connectionError)
    {
        self.heroes = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [self.tableView reloadData];
        NSString *jsonString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];

        //NSLog(@"%@", jsonString);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.heroes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *superhero = [self.heroes objectAtIndex: indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCellID"];
    cell.textLabel.text = [superhero objectForKey:@"name"];
    cell.detailTextLabel.text = [superhero objectForKey:@"description"];

    NSURL *url = [NSURL URLWithString:[superhero objectForKey:@"avatar_url"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    cell.imageView.image = [UIImage imageWithData:data];


    return cell;
}


@end
