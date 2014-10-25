//
//  MBTableViewController.m
//  MenuBuddy
//
//  Created by Matthew Farley on 23/09/14.
//  Copyright (c) 2014 Matthew Farley. All rights reserved.
//

#import "MBTableViewController.h"
#import "MBRecipe.h"
#import "MBViewController.h"

@interface MBTableViewController ()

@property(strong, nonatomic) NSArray *testRecipeList;

@end

@implementation MBTableViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSString *filePath =[[NSBundle mainBundle] pathForResource:@"recipies" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSArray *jsonDataArray = [[NSArray alloc] initWithArray:[json objectForKey:@"recipes"]];
    NSMutableArray *recipeList = [[NSMutableArray alloc] init];
    
    if (jsonDataArray && [jsonDataArray count] > 0){
        for (NSDictionary * dic in jsonDataArray){
            [recipeList addObject: [[MBRecipe alloc] initWithJsonObject:dic]];
        }
        self.testRecipeList = recipeList.copy;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.testRecipeList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menu_cell"];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"menu_cell"];
    }
    
    MBRecipe *recipe = [self.testRecipeList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = recipe.recipeName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Serves %d", recipe.numberOfServes];
    [cell.imageView setImage:recipe.icon];
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[UITableViewCell class]]){
        UITableViewCell *cell = (UITableViewCell *)sender;
        if ([[segue destinationViewController] isKindOfClass:[MBViewController class]]){
            MBViewController *mbvc = [segue destinationViewController];
            NSInteger index = [self.tableView indexPathForCell:cell].row;
            mbvc.recipe = self.testRecipeList[index];
        }
    }
}

@end
