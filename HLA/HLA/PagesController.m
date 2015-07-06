//
//  PDSPagesController.m
//  iMobile Planner
//
//  Created by shawal sapuan on 4/24/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "PagesController.h"
#import "AppDelegate.h"

@interface PagesController ()

@end

@implementation PagesController
@synthesize pageDesc,htmlName,PDSorSI,TradOrEver,pdfTotalPage;
@synthesize delegate = _delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    [self getPages];
}

-(void)getPages
{
    pageDesc = [[NSMutableArray alloc] init];
    htmlName = [[NSMutableArray alloc] init];
    
	
	
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
		NSString *querySQL;
		if ([TradOrEver isEqualToString:@"Trad"]) {
			if ([PDSorSI isEqualToString:@"PDS"])
				querySQL = [NSString stringWithFormat:@"SELECT htmlName, PageNum, PageDesc FROM SI_Temp_Pages_PDS"];
			else
				querySQL = [NSString stringWithFormat:@"SELECT htmlName, PageNum, PageDesc FROM SI_Temp_Pages"];
		}
		else{
			if ([PDSorSI isEqualToString:@"PDS"]){
				//querySQL = [NSString stringWithFormat:@"SELECT htmlName, PageNum, PageDesc FROM UL_Temp_Pages_PDS"];
				[self readPDF];
				querySQL = @"";
			}
			else{
				querySQL = [NSString stringWithFormat:@"SELECT htmlName, PageNum, PageDesc FROM UL_Temp_Pages"];
			}
				
		}
        
		if(querySQL.length == 0) //if 0, it get from PDF instead.
        {
            for(int x=1; x<=pdfTotalPage; x++)
            {
                NSString* htmlNameTemp = [NSString stringWithFormat:@"%@%d%@", @"Page", x, @".html"];
                NSString* pageDescTemp = [NSString stringWithFormat:@"%@%d", @"Page", x];
                [htmlName addObject:htmlNameTemp ];
                [pageDesc addObject:pageDescTemp ];
            }
        }
		else{
			if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{
				while (sqlite3_step(statement) == SQLITE_ROW)
				{
					[htmlName addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)]];
					[pageDesc addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)]];
				}
				sqlite3_finalize(statement);
			}
		}
		
		
        sqlite3_close(contactDB);
    }
}

-(void) readPDF
{
    AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    //zzz.PDFpath;
    
    NSString *myString = zzz.PDFpath;
    const char *pathChar = [myString cStringUsingEncoding:NSASCIIStringEncoding];
    
    CFStringRef path;
    CFURLRef url;
    CGPDFDocumentRef document;
    
    path = CFStringCreateWithCString (NULL, pathChar,kCFStringEncodingUTF8);
    url = CFURLCreateWithFileSystemPath (NULL, path, kCFURLPOSIXPathStyle, 0);
    
    CFRelease (path);
    document = CGPDFDocumentCreateWithURL (url);// 2
    CFRelease(url);
    pdfTotalPage = CGPDFDocumentGetNumberOfPages (document);// 3
    
    NSLog(@"pages count = %d", pdfTotalPage);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [pageDesc count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [pageDesc objectAtIndex:indexPath.row];
    
    /*
    if (indexPath.row == selectedIndex) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
	else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}*/
    
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16 ];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = indexPath.row;
    [_delegate getPages:[pageDesc objectAtIndex:selectedIndex]];
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewDidUnload
{
    [self setDelegate:nil];
    [self setHtmlName:nil];
    [self setPageDesc:nil];
    [super viewDidUnload];
}

@end
