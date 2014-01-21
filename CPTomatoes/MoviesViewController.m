//
//  MoviesViewController.m
//  CodePathTomatoes
//
//  Created by Christine Wang on 1/15/14.
//  Copyright (c) 2014 Christine Wang. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieViewController.h"
#import "MovieCell.h"
#import "Movie.h"

@interface MoviesViewController ()

@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, weak) IBOutlet UIWebView *testWebView;
@property (nonatomic, strong) NSMutableArray *moviesObjects;

- (void) reload;

@end

@implementation MoviesViewController

- (void)setup {
    [self reload];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setup];
    }
    return self;
}

// storyboards use this init
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}

#pragma mark - Table view methods

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    Movie *movieObj = self.moviesObjects[indexPath.row];
    cell.movieTitleLabel.text = movieObj.title;
    cell.synopsisLabel.text = movieObj.synopsis;
    cell.castLabel.text = movieObj.cast;
    
    return cell;
}

#pragma mark - Private methods

- (void)reload {
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        self.movies = [object objectForKey:@"movies"];
        
        self.moviesObjects = [[NSMutableArray alloc] init];
        for (NSDictionary *movie in self.movies) {
            Movie *movieObj = [[Movie alloc] initWithDictionary:movie];
            [self.moviesObjects addObject:movieObj];
        }

        [self.tableView reloadData];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showMovieDetail"]) {
        UITableViewCell *selectedCell = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:selectedCell];
        Movie *movieObj = self.moviesObjects[indexPath.row];
    
        MovieViewController *movieViewController = (MovieViewController *)segue.destinationViewController;
        movieViewController.movie = movieObj;
    }
}

@end
