//
//  SIUtilities.m
//  iMobile Planner
//
//  Created by shawal sapuan on 5/13/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "SIUtilities.h"
#import "DataTable.h"
#import "FMDatabaseAdditions.h"


static sqlite3 *contactDB = nil;

@implementation SIUtilities


+(void)modTradSysOtherValue:(NSString *)path
{
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    /**********C+ rider***************/
    NSUInteger countAgt = [database intForQuery:@"SELECT count(*) from Trad_Sys_Other_Value where code='PlanOptionC+' and value in ('L','I','B','N')"];
    BOOL toContAgt = false;
    if (countAgt<4){
        toContAgt = true;
    }
    
    if(toContAgt)
    {
        NSString *query = nil;
        query = @"update Trad_Sys_Other_Value set value='L' where code='PlanOptionC+' and desc='Level'";
        [database executeUpdate:query];
        
        query = @"update Trad_Sys_Other_Value set value='I' where code='PlanOptionC+' and desc='Increasing'";
        [database executeUpdate:query];
        
        query = @"update Trad_Sys_Other_Value set value='B' where code='PlanOptionC+' and desc='Level_NCB'";
        [database executeUpdate:query];
        
        query = @"update Trad_Sys_Other_Value set value='N' where code='PlanOptionC+' and desc='Increasing_NCB'";
        [database executeUpdate:query];
    }
    /********************************/
    
    /***********HSP II***************/
    NSUInteger countAgt2 = [database intForQuery:@"SELECT count(*) from Trad_Sys_Other_Value where code='PlanChoiceHSPII' and value in ('S','D','P')"];
    BOOL toContAgt2 = false;
    if (countAgt2<3){
        toContAgt2 = true;
    }
    
    if(toContAgt2)
    {
        NSString *query = nil;
        query = @"update Trad_Sys_Other_Value set value='S' where code='PlanChoiceHSPII' and desc='Standard'";
        [database executeUpdate:query];
        
        query = @"update Trad_Sys_Other_Value set value='D' where code='PlanChoiceHSPII' and desc='Deluxe'";
        [database executeUpdate:query];
        
        query = @"update Trad_Sys_Other_Value set value='P' where code='PlanChoiceHSPII' and desc='Premier'";
        [database executeUpdate:query];
    }
    /********************************/
    
    [database close];
}


/*
 merge all data into one table - Agent_Profile, copies data from user_profile to agent_profile: edwin 24-01-2014
 */
+(void)migrateIntoAgentProfile:(NSString *)path
{
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    NSUInteger countAgt = [database intForQuery:@"SELECT count(*) from agent_profile where AgentPassword is null"]; //because null only happens once during the creation of this new column in agent_profile, any subsequent usage of the app shouldn't insert any null data to the password, it's safe so far to have this clause
    BOOL toContAgt = false;
    if (countAgt>0){ //to cont update the data from user_profile only if it's null
        toContAgt = true;
    }
    
    if(toContAgt)
    {
        NSString *query = @"update agent_profile set AgentPassword =(select AgentPassword from user_profile where indexNo=1)";
        [database executeUpdate:query];
        
        query = @"update agent_profile set FirstLogin=(select FirstLogin from user_profile where indexNo=1)";
        [database executeUpdate:query];
        
        query = @"update agent_profile set LastLogonDate =(select LastLogonDate from user_profile where indexNo=1)";
        [database executeUpdate:query];
        
        query = @"update agent_profile set LastLogoutDate =(select LastLogoutDate from user_profile where indexNo=1)";
        [database executeUpdate:query];
        
        query = @"update agent_profile set AgentStatus =(select AgentStatus from user_profile where indexNo=1)";
        [database executeUpdate:query];
        
        query = @"update agent_profile set Channel ='AGT'";
        [database executeUpdate:query];
    }
    
    [database close];
}


+(BOOL)checkDBCountry:(NSString *)path
{
    //  dispatch_queue_t myBackgroundQueue;
    //  myBackgroundQueue = dispatch_queue_create("com.company.subsystem.task", NULL);
    
    //   dispatch_async(myBackgroundQueue, ^(void) {
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *results;
    
    
    //INSERT COUNTRY RECORDS - START
    int count;
    NSString *query17 = [NSString stringWithFormat:@"SELECT COUNT(*) from eProposal_Country"];
    results = [database executeQuery:query17];
    
    while ([results next]) {
        
        count = [[results objectForColumnName:@"COUNT(*)"] integerValue];
        
        
    }
    
    
    if(count < 158)
    {
        
        NSString *file = [[NSBundle mainBundle] pathForResource:@"CountryList" ofType:@"csv"];
        NSString *content =  [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
        NSString  *country_query = [NSString stringWithFormat:@"DELETE from eProposal_Country"];
        [database executeUpdate:country_query];
        
        NSArray *contentArray  = [content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        for (NSString *item in contentArray) {
            
            NSArray *itemArray = [item componentsSeparatedByString:@","];
            
            country_query = [NSString stringWithFormat:@"INSERT INTO eProposal_Country ('CountryCode', 'CountryDesc', 'Status') VALUES('%@','%@','%@')",[itemArray objectAtIndex:0],[itemArray objectAtIndex:1],[itemArray objectAtIndex:2]];
            
            
            [database executeUpdate:country_query];
            
            
        }
        
        
    }
    //INSERT COUNTRY RECORDS - END
    
    
    
    //*******START - CHECK IF TABLE STORED COUNTRY DESC, AND REPLACE IT WITH COUNTRY CODE
    NSString *countryDesc = [NSString stringWithFormat:@"SELECT IndexNo, ResidenceAddressCountry , OfficeAddressCountry  from prospect_profile"];
    results = [database executeQuery:countryDesc];
    
    NSString *indexno;
    NSString *home;
    NSString *office;
    
    while ([results next]) {
        
        
        indexno = [results stringForColumn:@"IndexNo"];
        home = [results stringForColumn:@"ResidenceAddressCountry"];
        office = [results stringForColumn:@"OfficeAddressCountry"];
        home = [home uppercaseString];
        office = [office uppercaseString];
        
        if(home==Nil || home==NULL)
            home = @"";
        else
            home = [home stringByTrimmingCharactersInSet:
                    [NSCharacterSet whitespaceCharacterSet]];
        
        if(office==Nil || office ==NULL)
            office=@"";
        else
            office = [office stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceCharacterSet]];
        
        
        
        
        
        //******* START Update country code for home
        if(![home isEqualToString:@""])
        {
            
            NSString *get_countryDesc = [NSString stringWithFormat:@"SELECT CountryCode from eProposal_Country WHERE CountryDesc = '%@'",home];
            FMResultSet *res2;
            
            
            
            res2 = [database executeQuery:get_countryDesc];
            
            
            while ([res2 next]) {
                NSString *code = [res2 stringForColumn:@"CountryCode"] ;
                
                
                if(code!=NULL || code!=Nil)
                {
                    
                    
                    NSString *update = [NSString stringWithFormat:@"UPDATE prospect_profile  SET \"ResidenceAddressCountry\" = '%@'  WHERE IndexNo = '%@'",code,indexno];
                    
                    [database executeUpdate:update];
                    
                    
                    
                }
                
                
            }
            
            [res2 close];
        }
        
        //******* END Update country code for home
        
        
        //******* START Update country code for Office in Table prospect_profile
        if(![office isEqualToString:@""])
        {
            
            
            NSString *get_countryDesc = [NSString stringWithFormat:@"SELECT CountryCode  from eProposal_Country WHERE CountryDesc = '%@'",office];
            
            
            FMResultSet *res2;
            
            res2 = [database executeQuery:get_countryDesc];
            
            
            while ([res2 next]) {
                NSString *code = [res2 stringForColumn:@"CountryCode"] ;
                
                
                if(code!=NULL || code!=Nil)
                {
                    
                    
                    NSString *update = [NSString stringWithFormat:@"UPDATE prospect_profile  SET \"OfficeAddressCountry\" = '%@'  WHERE IndexNo = '%@'",code,indexno];
                    
                    [database executeUpdate:update];
                    
                    
                }
                
                
            }
            [res2 close];
        }
        
        
        //******* END Update country code for Office in Table prospect_profile
    }
    
    
    //*******END - CHECK IF TABLE STORED COUNTRY DESC, AND REPLACE IT WITH COUNTRY CODE
    
    
    
    
    //**********START - UPDATE COUNTRY CODE FOR TABLE  - CFF_Personal_Details
    countryDesc = [NSString stringWithFormat:@"SELECT ID, MailingCountry , PermanentCountry from CFF_Personal_Details"];
    results = [database executeQuery:countryDesc];
    
    NSString *ID  =@"";
    NSString *mailcountry = @"";
    NSString *permanentcountry  = @"";
    
    while ([results next]) {
        
        
        ID = [results stringForColumn:@"ID"] ;
        mailcountry = [results stringForColumn:@"MailingCountry"] ;
        permanentcountry = [results stringForColumn:@"PermanentCountry"] ;
        
        mailcountry = [mailcountry uppercaseString];
        permanentcountry = [permanentcountry uppercaseString];
        
        if(mailcountry==Nil || mailcountry==NULL)
            mailcountry = @"";
        else
            mailcountry = [mailcountry stringByTrimmingCharactersInSet:
                           [NSCharacterSet whitespaceCharacterSet]];
        
        if(permanentcountry==Nil || permanentcountry ==NULL)
            permanentcountry=@"";
        else
            permanentcountry = [permanentcountry stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceCharacterSet]];
        
        
        
        
        
        //******* START Update country code for mailcountry
        if(![mailcountry isEqualToString:@""])
        {
            
            NSString *get_countryDesc = [NSString stringWithFormat:@"SELECT CountryCode from eProposal_Country WHERE CountryDesc = '%@'",mailcountry];
            FMResultSet *res2;
            
            res2 = [database executeQuery:get_countryDesc];
            
            
            while ([res2 next]) {
                NSString *code = [res2 stringForColumn:@"CountryCode"] ;
                
                
                if(code!=NULL || code!=Nil)
                {
                    
                    
                    NSString *update = [NSString stringWithFormat:@"UPDATE CFF_Personal_Details  SET \"MailingCountry\" = '%@'  WHERE ID = '%@'",code,ID];
                    
                    [database executeUpdate:update];
                    
                    
                    
                }
                
                
            }
            [res2 close];
        }
        
        
        //******* START Update country code for permanent country
        if(![permanentcountry isEqualToString:@""])
        {
            NSString *get_countryDesc = [NSString stringWithFormat:@"SELECT CountryCode from eProposal_Country WHERE CountryDesc = '%@'",permanentcountry];
            FMResultSet *res2;
            
            res2 = [database executeQuery:get_countryDesc];
            
            
            while ([res2 next]) {
                NSString *code = [res2 stringForColumn:@"CountryCode"] ;
                
                
                if(code!=NULL || code!=Nil)
                {
                    
                    
                    NSString *update = [NSString stringWithFormat:@"UPDATE CFF_Personal_Details  SET \"PermanentCountry\" = '%@'  WHERE ID = '%@'",code,ID];
                    
                    [database executeUpdate:update];
                    
                    
                }
                
                
            }
            
            [res2 close];
        }
        
        
    }
    
    
    
    
    //**********START - UPDATE COUNTRY CODE FOR TABLE  - eProposal_Trustee_Details
    countryDesc = [NSString stringWithFormat:@"SELECT ID, TrusteeCountry from eProposal_Trustee_Details"];
    results = [database executeQuery:countryDesc];
    
    ID  =@"";
    NSString *TrusteeCountry = @"";
    
    
    while ([results next]) {
        ID = [results stringForColumn:@"ID"] ;
        TrusteeCountry = [results stringForColumn:@"TrusteeCountry"] ;
        
        
        TrusteeCountry = [TrusteeCountry uppercaseString];
        
        
        if(TrusteeCountry==Nil || TrusteeCountry==NULL)
            TrusteeCountry = @"";
        else
            TrusteeCountry = [TrusteeCountry stringByTrimmingCharactersInSet:
                              [NSCharacterSet whitespaceCharacterSet]];
        
        
        
        
        
        //******* START Update country code for mailcountry
        if(![TrusteeCountry isEqualToString:@""])
        {
            
            NSString *get_countryDesc = [NSString stringWithFormat:@"SELECT CountryCode from eProposal_Country WHERE CountryDesc = '%@'",TrusteeCountry];
            FMResultSet *res2;
            
            res2 = [database executeQuery:get_countryDesc];
            while ([res2 next]) {
                NSString *code = [res2 stringForColumn:@"CountryCode"] ;
                
                
                if(code!=NULL || code!=Nil)
                {
                    
                    
                    NSString *update = [NSString stringWithFormat:@"UPDATE eProposal_Trustee_Details  SET \"TrusteeCountry\" = '%@'  WHERE ID = '%@'",code,ID];
                    
                    [database executeUpdate:update];
                    
                    
                }
                
                
            }
            [res2 close];
        }
        
        
        
    }
    
    
    
    //**********START - UPDATE COUNTRY CODE FOR TABLE  - eProposal_NM_Details
    countryDesc = [NSString stringWithFormat:@"SELECT ID, NMCountry from eProposal_NM_Details"];
    results = [database executeQuery:countryDesc];
    
    ID  =@"";
    NSString *NMCountry = @"";
    
    
    while ([results next]) {
        ID = [results stringForColumn:@"ID"] ;
        NMCountry = [results stringForColumn:@"NMCountry"] ;
        
        
        NMCountry = [NMCountry uppercaseString];
        
        
        if(NMCountry==Nil || NMCountry==NULL)
            NMCountry = @"";
        else
            NMCountry = [NMCountry stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
        
        
        
        
        
        //******* START Update country code for mailcountry
        if(![NMCountry isEqualToString:@""])
        {
            
            NSString *get_countryDesc = [NSString stringWithFormat:@"SELECT CountryCode from eProposal_Country WHERE CountryDesc = '%@'",NMCountry];
            FMResultSet *res2;
            
            res2 = [database executeQuery:get_countryDesc];
            while ([res2 next]) {
                NSString *code = [res2 stringForColumn:@"CountryCode"] ;
                
                
                if(code!=NULL || code!=Nil)
                {
                    
                    
                    NSString *update = [NSString stringWithFormat:@"UPDATE eProposal_NM_Details  SET \"NMCountry\" = '%@'  WHERE ID = '%@'",code,ID];
                    
                    [database executeUpdate:update];
                    
                    
                }
                
                
            }
            [res2 close];
        }
        
        
        
    }
    
    
    
    //**********START - UPDATE COUNTRY CODE FOR TABLE  - eProposal_LA_Details
    countryDesc = [NSString stringWithFormat:@"SELECT ID, ResidenceCountry, OfficeCountry from eProposal_LA_Details"];
    results = [database executeQuery:countryDesc];
    
    ID  =@"";
    NSString *resCountry = @"";
    NSString *officeCountry = @"";
    
    
    while ([results next]) {
        ID = [results stringForColumn:@"ID"] ;
        resCountry = [results stringForColumn:@"ResidenceCountry"];
        officeCountry = [results stringForColumn:@"OfficeCountry"] ;
        
        
        resCountry = [resCountry uppercaseString];
        officeCountry = [officeCountry uppercaseString];
        
        
        if(resCountry==Nil || resCountry==NULL)
            resCountry = @"";
        else
            resCountry = [resCountry stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceCharacterSet]];
        
        
        
        
        
        if(officeCountry==Nil || officeCountry==NULL)
            officeCountry = @"";
        else
            officeCountry = [officeCountry stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceCharacterSet]];
        
        
        
        
        
        //******* START Update country code for residence country
        if(![resCountry isEqualToString:@""])
        {
            
            NSString *get_countryDesc = [NSString stringWithFormat:@"SELECT CountryCode from eProposal_Country WHERE CountryDesc = '%@'",resCountry];
            FMResultSet *res2;
            
            res2 = [database executeQuery:get_countryDesc];
            while ([res2 next]) {
                NSString *code = [res2 stringForColumn:@"CountryCode"] ;
                
                
                if(code!=NULL || code!=Nil)
                {
                    
                    
                    NSString *update = [NSString stringWithFormat:@"UPDATE eProposal_LA_Details  SET \"ResidenceCountry\" = '%@'  WHERE ID = '%@'",code,ID];
                    
                    [database executeUpdate:update];
                    
                    
                }
                
                
            }
            [res2 close];
        }
        
        
        
        
        
        //******* START Update country code for office country
        if(![officeCountry isEqualToString:@""])
        {
            
            NSString *get_countryDesc = [NSString stringWithFormat:@"SELECT CountryCode from eProposal_Country WHERE CountryDesc = '%@'",officeCountry];
            FMResultSet *res2;
            
            res2 = [database executeQuery:get_countryDesc];
            while ([res2 next]) {
                NSString *code = [res2 stringForColumn:@"CountryCode"] ;
                
                
                if(code!=NULL || code!=Nil)
                {
                    
                    
                    NSString *update = [NSString stringWithFormat:@"UPDATE eProposal_LA_Details  SET \"OfficeCountry\" = '%@'  WHERE ID = '%@'",code,ID];
                    
                    [database executeUpdate:update];
                    
                    
                }
                
                
            }
            [res2 close];
        }
        
        
        
    }
    
    
    
    
    
    //**********START - UPDATE COUNTRY CODE FOR TABLE  - eProposal_CFF_Personal_Details 
    countryDesc = [NSString stringWithFormat:@"SELECT ID, MailingCountry, PermanentCountry from eProposal_CFF_Personal_Details"];
    results = [database executeQuery:countryDesc];
    
    ID  =@"";
    mailcountry = @"";
    permanentcountry = @"";
    
    
    while ([results next]) {
        ID = [results stringForColumn:@"ID"] ;
        mailcountry = [results stringForColumn:@"MailingCountry"];
        permanentcountry = [results stringForColumn:@"PermanentCountry"] ;
        
        
        mailcountry = [mailcountry uppercaseString];
        permanentcountry = [permanentcountry uppercaseString];
        
        
        if(mailcountry==Nil || mailcountry==NULL)
            mailcountry = @"";
        else
            mailcountry = [mailcountry stringByTrimmingCharactersInSet:
                           [NSCharacterSet whitespaceCharacterSet]];
        
        
        
        
        
        if(permanentcountry==Nil || permanentcountry==NULL)
            permanentcountry = @"";
        else
            permanentcountry = [permanentcountry stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceCharacterSet]];
        
        
        
        
        
        //******* START Update country code for mail country
        if(![mailcountry isEqualToString:@""])
        {
            
            NSString *get_countryDesc = [NSString stringWithFormat:@"SELECT CountryCode from eProposal_Country WHERE CountryDesc = '%@'",mailcountry];
            FMResultSet *res2;
            
            res2 = [database executeQuery:get_countryDesc];
            while ([res2 next]) {
                NSString *code = [res2 stringForColumn:@"CountryCode"] ;
                
                
                if(code!=NULL || code!=Nil)
                {
                    
                    
                    NSString *update = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Personal_Details  SET \"MailingCountry\" = '%@'  WHERE ID = '%@'",code,ID];
                    
                    [database executeUpdate:update];
                    
                    
                }
                
                
            }
            [res2 close];
        }
        
        
        
        //******* START Update country code for permanent country
        if(![permanentcountry isEqualToString:@""])
        {
            
            NSString *get_countryDesc = [NSString stringWithFormat:@"SELECT CountryCode from eProposal_Country WHERE CountryDesc = '%@'",permanentcountry];
            FMResultSet *res2;
            
            res2 = [database executeQuery:get_countryDesc];
            while ([res2 next]) {
                NSString *code = [res2 stringForColumn:@"CountryCode"] ;
                
                
                if(code!=NULL || code!=Nil)
                {
                    
                    
                    NSString *update = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Personal_Details  SET \"PermanentCountry\" = '%@'  WHERE ID = '%@'",code,ID];
                    
                    [database executeUpdate:update];
                    
                    
                }
                
                
            }
            [res2 close];
        }
        
    }
    //
    
    
    // do some time consuming things here
    
    /* dispatch_async(dispatch_get_main_queue(), ^{
     
     
     });
     */
    [results close];
    [database close];
    
    
    // });
    
    
    // dispatch_release(myBackgroundQueue);
    return  true;
}

+(BOOL)makeDBCopy:(NSString *)path
{
    BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	
    success = [fileManager fileExistsAtPath:path];
    if (success) return YES;
    
    if (!success) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"hladb.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:path error:&error];
        if (!success) {
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
            return NO;
        }
        
        defaultDBPath = Nil;
    }
    
	fileManager = Nil;
    error = Nil;
    return YES;
}


//added by Edwin 13-02-2014
+(void)upgradeRatesDB:(NSString *)ratesPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
    BOOL success;
	
    success = [fileManager fileExistsAtPath:ratesPath];
    
    if (!success) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"BCA_Rates.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:ratesPath error:&error];
        if (!success) {
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
        }
        
        defaultDBPath = Nil;
    }
    else{
        
          }
    
	fileManager = Nil;
    error = Nil;
    
    
}

//added by Edwin 13-02-2014, @new rates table doesn't go through pentacode anymore.
+(BOOL) isNewTradRatesTableExist:(NSString*)ratesPath
{
    NSString *sqlTrad_Basic_Prem = @"SELECT name FROM sqlite_master WHERE type='table' AND name='Trad_Sys_Basic_Prem_New'";
    NSString *sqlTrad_Rider_Prem = @"SELECT name FROM sqlite_master WHERE type='table' AND name='Trad_Sys_Rider_Prem_New'";
    NSString *sqlTrad_sys_basic_csvL100 = @"select * from trad_sys_basic_csv where plancode='L100' limit 10";
    NSString *sqlTrad_sys_basic_lsdL100 = @"Select * from trad_sys_basic_lsd where plancode='L100'";
    NSString *sqlTrad_sys_basic_prem_HLAWP = @"Select * from Trad_Sys_Basic_Prem_New where PlanCode='HLAWP'";
    
    bool exist = FALSE;
    
    FMDatabase *database = [FMDatabase databaseWithPath:ratesPath];
    [database open];
    
    FMResultSet *results = [database executeQuery:sqlTrad_Basic_Prem];
    while ([results next]) {
        
        if (exist == TRUE) {
            break;
        }
        
        FMResultSet *results2 = [database executeQuery:sqlTrad_Rider_Prem];
        while ([results2 next]) 
        {
            if (exist == TRUE) {
                break;
            }
            
            FMResultSet *results3 = [database executeQuery:sqlTrad_sys_basic_csvL100];
            while ([results3 next]) 
            {
                if (exist == TRUE) {
                    break;
                }
                
                FMResultSet *results4 = [database executeQuery:sqlTrad_sys_basic_lsdL100];
                while ([results4 next]) 
                {
                    if (exist == TRUE) {
                        break;
                    }

                    FMResultSet *results5 = [database executeQuery:sqlTrad_sys_basic_prem_HLAWP];
                    while ([results5 next]) 
                    {
                        exist = TRUE;
                        break;
                    }
                }
            }
        }
    }
    
    [database close];
    
    return exist;
}


+(BOOL)addColumnTable:(NSString *)table column:(NSString *)columnName type:(NSString *)columnType dbpath:(NSString *)path
{
    sqlite3_stmt *statement;
    if (sqlite3_open([path UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"ALTER TABLE %@ ADD COLUMN %@ %@",table,columnName,columnType];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) != SQLITE_OK) {
            return NO;
        }
        
        sqlite3_exec(contactDB, [querySQL UTF8String], NULL, NULL, NULL);
        return YES;
        sqlite3_close(contactDB);
    }
    return YES;
}


+(BOOL)updateTable:(NSString *)table set:(NSString *)column value:(NSString *)val where:(NSString *)param equal:(NSString *)val2 dbpath:(NSString *)path
{
    sqlite3_stmt *statement;
    if (sqlite3_open([path UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"UPDATE %@ SET %@= \"%@\" WHERE %@=\"%@\"",table,column,val,param,val2];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) != SQLITE_OK) {
            return NO;
        }
        
        sqlite3_exec(contactDB, [querySQL UTF8String], NULL, NULL, NULL);
        return YES;
        sqlite3_close(contactDB);
    }
    return YES;
}

+(BOOL)patcheProposal_Question:(NSString *)path
{

    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    NSString *QnID = @"Q1027";
    NSString *Question = @"14(a)";
    NSString *update_query = [NSString stringWithFormat:@"update eProposal_Question SET \"QuestionNo\" = '%@' where QnID = '%@'",Question,QnID];
    [database executeUpdate:update_query];
    
    QnID = @"Q1028";
    Question = @"14(b)";
    update_query = [NSString stringWithFormat:@"update eProposal_Question SET \"QuestionNo\" = '%@' where QnID = '%@'",Question,QnID];
    [database executeUpdate:update_query];
    
    QnID = @"Q1029";
    Question = @"11";
    update_query = [NSString stringWithFormat:@"update eProposal_Question SET \"QuestionNo\" = '%@' where QnID = '%@'",Question,QnID];
    [database executeUpdate:update_query];
    
    QnID = @"Q1030";
    Question = @"12";
    update_query = [NSString stringWithFormat:@"update eProposal_Question SET \"QuestionNo\" = '%@' where QnID = '%@'",Question,QnID];
    [database executeUpdate:update_query];
    
    QnID = @"Q1031";
    Question = @"13";
    update_query = [NSString stringWithFormat:@"update eProposal_Question SET \"QuestionNo\" = '%@' where QnID = '%@'",Question,QnID];
    [database executeUpdate:update_query];
    
    
    NSString *RowID = @"26";
    Question = @"14(b)";
    update_query = [NSString stringWithFormat:@"update eProposal_Question SET \"QuestionNo\" = '%@' where QnID = '%@'",Question,QnID];
    [database executeUpdate:update_query];
    
    RowID = @"3";
    Question = @"14(a)";
    update_query = [NSString stringWithFormat:@"update eProposal_Question SET \"QuestionNo\" = '%@' where QnID = '%@'",Question,QnID];
    [database executeUpdate:update_query];
    
    RowID = @"6";
    Question = @"11";
    update_query = [NSString stringWithFormat:@"update eProposal_Question SET \"QuestionNo\" = '%@' where QnID = '%@'",Question,QnID];
    [database executeUpdate:update_query];
    
    [database close];
    NSLog(@"Question table patched!");
    return YES;
    
}

+(BOOL)patchTableProspectProfile:(NSString *)path
{
    NSLog(@"Prospect_Profile table start patching!");
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];

    FMResultSet *result = [database executeQuery:@"select IndexNo, ProspectGender, ProspectDOB, ProspectGroup, ProspectTitle, Race, MaritalStatus, Religion, OtherIDType, Nationality, ProspectOccupationCode from prospect_profile"];
    while ([result next]) {
        NSString *indexNo = [result stringForColumn:@"IndexNo"];

        // Patch Prospect Title
        NSString *ptitle = [result stringForColumn:@"ProspectTitle"];
        NSString *trim_ptitle = [ptitle stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        NSString *caps_ptitle = [trim_ptitle uppercaseString];
        if (![caps_ptitle isEqualToString:@"- SELECT -"]) {
            FMResultSet  *resultTitleCode = [database executeQuery:@"select * from eProposal_Title where TitleDesc = ?",trim_ptitle];
            while ([resultTitleCode next]) {
                NSString *ProspectTitleCode = [resultTitleCode stringForColumn:@"TitleCode"];
                NSString *update_query = [NSString stringWithFormat:@"UPDATE prospect_profile SET \"ProspectTitle\" = '%@' where IndexNo = '%@'",ProspectTitleCode,indexNo];
                [database executeUpdate:update_query];
            }

        }else
        {
            NSString *ProspectTitleCode = @"";
            NSString *update_query = [NSString stringWithFormat:@"UPDATE prospect_profile SET \"ProspectTitle\" = '%@' where IndexNo = '%@'",ProspectTitleCode,indexNo];
            [database executeUpdate:update_query];
        }

        // Patch OtherIDType
        NSString *_otherIDType = [result stringForColumn:@"OtherIDType"];
        NSString *trim_otherIDType = [_otherIDType stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        NSString *caps_otherIDType = [trim_otherIDType uppercaseString];
        if (![caps_otherIDType isEqualToString:@"- SELECT -"]) {
            
            FMResultSet  *resultOtherIDType = [database executeQuery:@"select * from eProposal_Identification where IdentityDesc = ?",caps_otherIDType];
            while ([resultOtherIDType next]) {
                NSString *OtherIDTypeCode = [resultOtherIDType stringForColumn:@"IdentityCode"];
                NSString *update_query1 = [NSString stringWithFormat:@"UPDATE prospect_profile SET \"OtherIDType\" = '%@' where IndexNo = '%@'",OtherIDTypeCode,indexNo];
                [database executeUpdate:update_query1];
            }

            if ([caps_otherIDType isEqualToString:@"OLD IDENTIFICATION NUMBER"]) {
                NSString *OtherIDTypeCode = @"OLDIC";
                NSString *update_query1 = [NSString stringWithFormat:@"UPDATE prospect_profile SET \"OtherIDType\" = '%@' where IndexNo = '%@'",OtherIDTypeCode,indexNo];
                [database executeUpdate:update_query1];
            }
            else if ([caps_otherIDType isEqualToString:@"NEW IDENTIFICATION NUMBER"])
            {
                NSString *OtherIDTypeCode = @"NRIC";
                NSString *update_query1 = [NSString stringWithFormat:@"UPDATE prospect_profile SET \"OtherIDType\" = '%@' where IndexNo = '%@'",OtherIDTypeCode,indexNo];
                [database executeUpdate:update_query1];
            }
            
        }
        else
        {
            NSString *OtherIDTypeCode = @"";
            NSString *update_query1 = [NSString stringWithFormat:@"UPDATE prospect_profile SET \"OtherIDType\" = '%@' where IndexNo = '%@'",OtherIDTypeCode,indexNo];
            [database executeUpdate:update_query1];
        }
        
        
        // Patch ProspectDOB
        NSString *pDOB = [result stringForColumn:@"ProspectDOB"];
        NSString *trim_pDOB = [pDOB stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        NSString *caps_pDOB = [trim_pDOB uppercaseString];
        if ([caps_pDOB isEqualToString:@"-SELECT-"]) {
            NSString *prospectDOB = @"";
            NSString *update_query2 = [NSString stringWithFormat:@"UPDATE prospect_profile SET \"ProspectDOB\" = '%@' where IndexNo = '%@'",prospectDOB,indexNo];
            [database executeUpdate:update_query2];
            
        }
        
        // Patch ProspectGroup
        NSString *pGroup = [result stringForColumn:@"ProspectGroup"];
        NSString *trim_pGroup = [pGroup stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        NSString *caps_pGroup = [trim_pGroup uppercaseString];
        if ([caps_pGroup isEqualToString:@"- SELECT -"]) {
            NSString *prospectGroup = @"";
            NSString *update_query3 = [NSString stringWithFormat:@"UPDATE prospect_profile SET \"ProspectGroup\" = '%@' where IndexNo = '%@'",prospectGroup,indexNo];
            [database executeUpdate:update_query3];
        } else
        {
            FMResultSet  *resultPGroup = [database executeQuery:@"select * from prospect_groups where name = ?",trim_pGroup];
            while ([resultPGroup next]) {
                NSString *pGroupCode = [resultPGroup stringForColumn:@"id"];
                NSString *update_query3 = [NSString stringWithFormat:@"UPDATE prospect_profile SET \"ProspectGroup\" = '%@' where IndexNo = '%@'",pGroupCode,indexNo];
                [database executeUpdate:update_query3];
            }
        }
        
        // Patch Race
        NSString *pRace = [result stringForColumn:@"Race"];
        NSString *trim_pRace = [pRace stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        NSString *caps_pRace = [trim_pRace uppercaseString];
        if ([caps_pRace isEqualToString:@"- SELECT -"]) {
            NSString *prospectRace = @"";
            NSString *update_query4 = [NSString stringWithFormat:@"UPDATE prospect_profile SET \"Race\" = '%@' where IndexNo = '%@'",prospectRace,indexNo];
            [database executeUpdate:update_query4];
        } else
        {
            NSString *update_query4 = [NSString stringWithFormat:@"UPDATE prospect_profile SET \"Race\" = '%@' where IndexNo = '%@'",caps_pRace,indexNo];
            [database executeUpdate:update_query4];
        }

        // Patch MaritalStatus
        NSString *pMStatus = [result stringForColumn:@"MaritalStatus"];
        NSString *trim_pMStatus = [pMStatus stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        NSString *caps_pMStatus = [trim_pMStatus uppercaseString];
        if ([caps_pMStatus isEqualToString:@"- SELECT -"]) {
            NSString *prospectMStatus = @"";
            NSString *update_query5 = [NSString stringWithFormat:@"UPDATE prospect_profile SET \"MaritalStatus\" = '%@' where IndexNo = '%@'",prospectMStatus,indexNo];
            [database executeUpdate:update_query5];
        } else
        {
            NSString *update_query5 = [NSString stringWithFormat:@"UPDATE prospect_profile SET \"MaritalStatus\" = '%@' where IndexNo = '%@'",caps_pMStatus,indexNo];
            [database executeUpdate:update_query5];
        }

        // Patch Religion
        NSString *pReligion = [result stringForColumn:@"Religion"];
        NSString *trim_pReligion = [pReligion stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        NSString *caps_pReligion = [trim_pReligion uppercaseString];
        if ([caps_pReligion isEqualToString:@"- SELECT -"]) {
            NSString *prospectReligion = @"";
            NSString *update_query6 = [NSString stringWithFormat:@"UPDATE prospect_profile SET \"Religion\" = '%@' where IndexNo = '%@'",prospectReligion,indexNo];
            [database executeUpdate:update_query6];
        } else
        {
            NSString *update_query6 = [NSString stringWithFormat:@"UPDATE prospect_profile SET \"Religion\" = '%@' where IndexNo = '%@'",caps_pReligion,indexNo];
            [database executeUpdate:update_query6];
        }

        // Patch Nationality
        NSString *pNationality = [result stringForColumn:@"Nationality"];
        NSString *trim_pNationality = [pNationality stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        NSString *caps_pNationality = [trim_pNationality uppercaseString];
        if ([caps_pNationality isEqualToString:@"- SELECT -"]) {
            NSString *prospectNationality = @"";
            NSString *update_query7 = [NSString stringWithFormat:@"UPDATE prospect_profile SET \"Nationality\" = '%@' where IndexNo = '%@'",prospectNationality,indexNo];
            [database executeUpdate:update_query7];
        } else
        {
            NSString *update_query7 = [NSString stringWithFormat:@"UPDATE prospect_profile SET \"Nationality\" = '%@' where IndexNo = '%@'",caps_pNationality,indexNo];
            [database executeUpdate:update_query7];
        }

        // Patch ProspectGender
        NSString *pGender = [result stringForColumn:@"ProspectGender"];
        if (![pGender isEqualToString:@"MALE"] && ![pGender isEqualToString:@"FEMALE"] ) {
            NSString *prospectGender = @"";
            NSString *update_query8 = [NSString stringWithFormat:@"UPDATE prospect_profile SET \"ProspectGender\" = '%@' where IndexNo = '%@'",prospectGender,indexNo];
            [database executeUpdate:update_query8];
        }
        

        
    }
    
    [database close];
    NSLog(@"Prospect_Profile table patched!");
    return YES;
}


+(BOOL)createTableCFF:(NSString *)path
{
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    NSString *query = @"CREATE TABLE IF NOT EXISTS CFF_CA_Recommendation (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, Seq TEXT, PTypeCode TEXT, InsuredName TEXT, PlanType TEXT, Term TEXT, Premium TEXT, Frequency TEXT, SumAssured TEXT, BoughtOption TEXT, AddNew TEXT)";
    [database executeUpdate:query];
    
    
    NSString *query2 = @"CREATE TABLE IF NOT EXISTS CFF_CA_Recommendation_Rider (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, Seq TEXT, RiderName TEXT)";
    [database executeUpdate:query2];
    
    
    NSString *query3 = @"CREATE TABLE IF NOT EXISTS CFF_Education (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, NoChild TEXT, NoExistingPlan TEXT, CurrentAmt_Child_1 TEXT, RequiredAmt_Child_1 TEXT, SurplusShortFallAmt_Child_1 TEXT, CurrentAmt_Child_2 TEXT, RequiredAmt_Child_2 TEXT, SurplusShortFallAmt_Child_2 TEXT, CurrentAmt_Child_3 TEXT, RequiredAmt_Child_3 TEXT, SurplusShortFallAmt_Child_3 TEXT, CurrentAmt_Child_4 TEXT, RequiredAmt_Child_4 TEXT, SurplusShortFallAmt_Child_4 TEXT, AllocateIncome_1 TEXT)";
    [database executeUpdate:query3];
    
    
    NSString *query4 = @"CREATE TABLE IF NOT EXISTS CFF_Education_Details (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, SeqNo TEXT, Name TEXT, CompanyName TEXT, Premium TEXT, Frequency TEXT, StartDate TEXT, MaturityDate TEXT, ProjectedValueAtMaturity TEXT)";
    [database executeUpdate:query4];
    
    
    NSString *query5 = @"CREATE TABLE IF NOT EXISTS CFF_Family_Details (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, AddFromCFF TEXT, CompleteFlag TEXT, SameAsPO TEXT, PTypeCode TEXT, Name TEXT, Relationship TEXT, DOB TEXT, Age TEXT, Sex TEXT, YearsToSupport TEXT)";
    [database executeUpdate:query5];
    
    
    NSString *query6 = @"CREATE TABLE IF NOT EXISTS CFF_Master (ID INTEGER PRIMARY KEY AUTOINCREMENT, eProposalNo TEXT, ClientProfileID TEXT,PartnerClientProfileID TEXT, IntermediaryStatus TEXT, BrokerName TEXT, ClientChoice TEXT, RiskReturnProfile TEXT, NeedsQ1_Ans1 TEXT, NeedsQ1_Ans2 TEXT, NeedsQ1_Priority TEXT, NeedsQ2_Ans1 TEXT, NeedsQ2_Ans2 TEXT, NeedsQ2_Priority TEXT, NeedsQ3_Ans1 TEXT, NeedsQ3_Ans2 TEXT, NeedsQ3_Priority TEXT, NeedsQ4_Ans1 TEXT, NeedsQ4_Ans2 TEXT, NeedsQ4_Priority TEXT, NeedsQ5_Ans1 TEXT, NeedsQ5_Ans2 TEXT, NeedsQ5_Priority TEXT, IntermediaryCode TEXT, IntermediaryName TEXT, IntermediaryNRIC TEXT, IntermediaryContractDate TEXT, IntermediaryAddress1 TEXT, IntermediaryAddress2 TEXT, IntermediaryAddress3 TEXT, IntermediaryAddress4 TEXT, IntermediaryManagerName TEXT, ClientAck TEXT, ClientComments TEXT, CreatedAt TEXT, LastUpdatedAt TEXT, Status TEXT, CFFType TEXT, SecACompleted TEXT, SecBCompleted TEXT, SecCCompleted TEXT,SecDCompleted TEXT, SecECompleted TEXT, SecFProtectionCompleted TEXT, SecFRetirementCompleted TEXT, SecFEducationCompleted TEXT, SecFSavingsCompleted TEXT, SecGCompleted TEXT, SecHCompleted TEXT, SecICompleted TEXT)";
    [database executeUpdate:query6];
    
    
    NSString *query7 = @"CREATE TABLE IF NOT EXISTS CFF_Personal_Details (ID INTEGER PRIMARY KEY AUTOINCREMENT, eProposalNo TEXT, AddFromCFF TEXT, CompleteFlag TEXT, PTypeCode TEXT, PYFlag TEXT, AddNewPayor TEXT, SameAsPO TEXT, Title TEXT, Name, NewICNo TEXT, OtherIDType TEXT, OtherID TEXT, Nationality TEXT, Race TEXT, Religion TEXT, Sex TEXT, Smoker TEXT, DOB TEXT, Age TEXT, MaritalStatus TEXT, OccupationCode TEXT, MailingForeignAddressFlag TEXT, MailingAddressSameAsPO TEXT, MailingAddress1 TEXT, MailingAddress2 TEXT, MailingAddress3 TEXT, MailingTown TEXT, MailingState TEXT, MailingPostCode TEXT, MailingCountry TEXT, PermanentForeignAddressFlag TEXT, PermanentAddressSameAsPO TEXT, PermanentAddress1 TEXT, PermanentAddress2 TEXT, PermanentAddress3 TEXT, PermanentTown TEXT, PermanentState TEXT, PermanentPostCode TEXT, PermanentCountry TEXT, ResidencePhoneNo TEXT, OfficePhoneNo TEXT, MobilePhoneNo TEXT, FaxPhoneNo TEXT, EmailAddress TEXT)";
    [database executeUpdate:query7];
    
    
    NSString *query8 = @"CREATE TABLE IF NOT EXISTS CFF_Protection (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, NoExistingPlan TEXT, AllocateIncome_1 TEXT, AllocateIncome_2 TEXT, TotalSA_CurrentAmt TEXT, TotalSA_RequiredAmt TEXT, TotalSA_SurplusShortFall TEXT, TotalCISA_CurrentAmt TEXT, TotalCISA_RequiredAmt TEXT, TotalCISA_SurplusShortFall TEXT, TotalHB_CurrentAmt TEXT, TotalHB_RequiredAmt TEXT, TotalHB_SurplusShortFall TEXT, TotalPA_CurrentAmt TEXT, TotalPA_RequiredAmt TEXT, TotalPA_SurplusShortFall TEXT)";
    [database executeUpdate:query8];
    
    
    NSString *query9 = @"CREATE TABLE IF NOT EXISTS CFF_RecordOfAdvice (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, SameAsQuotation TEXT, Priority TEXT, PlanType TEXT, Term TEXT, InsurerName TEXT, PTypeCode TEXT, InsuredName TEXT, SumAssured TEXT, ReasonRecommend TEXT, ActionRemark TEXT)";
    [database executeUpdate:query9];
    
    
    NSString *query10 = @"CREATE TABLE IF NOT EXISTS CFF_Protection_Details (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, SeqNo TEXT, POName TEXT, CompanyName TEXT, PlanType TEXT, LifeAssuredName TEXT, Benefit1 TEXT, Benefit2 TEXT, Benefit3 TEXT, Benefit4 TEXT, Premium TEXT, Mode TEXT, MaturityDate TEXT)";
    
    [database executeUpdate:query10];
    
    
    NSString *query11 = @"CREATE TABLE IF NOT EXISTS CFF_RecordOfAdvice_Rider (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, Priority TEXT, RiderName TEXT, Seq TEXT)";
    [database executeUpdate:query11];
    
    
    NSString *query12 = @"CREATE TABLE IF NOT EXISTS CFF_Retirement (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, NoExistingPlan TEXT, AllocateIncome_1 TEXT, AllocateIncome_2 TEXT, CurrentAmt TEXT, RequiredAmt TEXT, SurplusShortFallAmt TEXT, OtherIncome_1 TEXT, OtherIncome_2 TEXT)";
    [database executeUpdate:query12];
    
    
    NSString *query13 = @"CREATE TABLE IF NOT EXISTS CFF_Retirement_Details (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, SeqNo TEXT, POName TEXT, CompanyName TEXT, PlanType TEXT, Premium TEXT, Frequency TEXT, StartDate TEXT, MaturityDate TEXT, ProjectedLumSum TEXT, ProjectedAnnualIncome TEXT, AdditionalBenefits TEXT)";
    [database executeUpdate:query13];
    
    
    NSString *query14 = @"CREATE TABLE IF NOT EXISTS CFF_SavingsInvest (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, NoExistingPlan TEXT, CurrentAmt TEXT, RequiredAmt TEXT, SurplusShortFallAmt TEXT, AllocateIncome_1 TEXT)";
    [database executeUpdate:query14];
    
    
    NSString *query15 = @"CREATE TABLE IF NOT EXISTS CFF_SavingsInvest_Details (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, SeqNo TEXT, POName TEXT, CompanyName TEXT, PlanType TEXT, Purpose TEXT, Premium TEXT, CommDate TEXT, MaturityAmt TEXT)";
    [database executeUpdate:query15];
    
    
    NSString *query16 = @"CREATE TABLE IF NOT EXISTS CFF_CA (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, Choice1 TEXT, Choice2 TEXT, Choice3 TEXT, Choice4 TEXT, Choice5 TEXT, Choice6 TEXT, Choices6Desc TEXT)";
    [database executeUpdate:query16];
    
    FMResultSet *results;
    
    NSString *query17 = @"SELECT SecACompleted from CFF_master";
    results = [database executeQuery:query17];
    if (!results){
        query17 = @"alter table CFF_Master add SecACompleted TEXT";
        [database executeUpdate:query17];
    }
    
    NSString *query18 = @"SELECT SecBCompleted from CFF_master";
    results = [database executeQuery:query18];
    if (!results){
        query18 = @"alter table CFF_Master add SecBCompleted TEXT";
        [database executeUpdate:query18];
    }
    
    NSString *query19 = @"SELECT SecCCompleted from CFF_master";
    results = [database executeQuery:query19];
    if (!results){
        query19 = @"alter table CFF_Master add SecCCompleted TEXT";
        [database executeUpdate:query19];
    }
    
    NSString *query20 = @"SELECT SecDCompleted from CFF_master";
    results = [database executeQuery:query20];
    if (!results){
        query20 = @"alter table CFF_Master add SecDCompleted TEXT";
        [database executeUpdate:query20];
    }
    
    NSString *query21 = @"SELECT SecECompleted from CFF_master";
    results = [database executeQuery:query21];
    if (!results){
        query21 = @"alter table CFF_Master add SecECompleted TEXT";
        [database executeUpdate:query21];
    }
    
    NSString *query22 = @"SELECT SecFProtectionCompleted from CFF_master";
    results = [database executeQuery:query22];
    if (!results){
        query22 = @"alter table CFF_Master add SecFProtectionCompleted TEXT";
        [database executeUpdate:query22];
    }
    
    NSString *query23 = @"SELECT SecFRetirementCompleted from CFF_master";
    results = [database executeQuery:query23];
    if (!results){
        query23 = @"alter table CFF_Master add SecFRetirementCompleted TEXT";
        [database executeUpdate:query23];
    }
    
    NSString *query24 = @"SELECT SecFEducationCompleted from CFF_master";
    results = [database executeQuery:query24];
    if (!results){
        query24 = @"alter table CFF_Master add SecFEducationCompleted TEXT";
        [database executeUpdate:query24];
    }
    
    NSString *query25 = @"SELECT SecFSavingsCompleted from CFF_master";
    results = [database executeQuery:query25];
    if (!results){
        query25 = @"alter table CFF_Master add SecFSavingsCompleted TEXT";
        [database executeUpdate:query25];
    }
    
    NSString *query26 = @"SELECT SecGCompleted from CFF_master";
    results = [database executeQuery:query26];
    if (!results){
        query26 = @"alter table CFF_Master add SecGCompleted TEXT";
        [database executeUpdate:query26];
    }
    
    NSString *query27 = @"SELECT SecHCompleted from CFF_master";
    results = [database executeQuery:query27];
    if (!results){
        query27 = @"alter table CFF_Master add SecHCompleted TEXT";
        [database executeUpdate:query27];
    }
    
    NSString *query28 = @"SELECT SecICompleted from CFF_master";
    results = [database executeQuery:query28];
    if (!results){
        query28 = @"ALTER TABLE CFF_Master ADD COLUMN SecICompleted TEXT";
        [database executeUpdate:query28];
    }
	
	NSString *query80 = @"SELECT IntermediaryAddrPostcode from CFF_master";
    results = [database executeQuery:query80];
    if (!results){
        query80 = @"ALTER TABLE CFF_Master ADD COLUMN IntermediaryAddrPostcode TEXT";
        [database executeUpdate:query80];
    }
	
	NSString *query81 = @"SELECT IntermediaryAddrTown from CFF_master";
    results = [database executeQuery:query81];
    if (!results){
        query81 = @"ALTER TABLE CFF_Master ADD COLUMN IntermediaryAddrTown TEXT";
        [database executeUpdate:query81];
    }

	NSString *query82 = @"SELECT IntermediaryAddrState from CFF_master";
    results = [database executeQuery:query82];
    if (!results){
        query82 = @"ALTER TABLE CFF_Master ADD COLUMN IntermediaryAddrState TEXT";
        [database executeUpdate:query82];
    }
	
	NSString *query83 = @"SELECT IntermediaryAddrCountry from CFF_master";
    results = [database executeQuery:query83];
    if (!results){
        query83 = @"ALTER TABLE CFF_Master ADD COLUMN IntermediaryAddrCountry TEXT";
        [database executeUpdate:query83];
    }
	
	NSString *query84 = @"SELECT ClientProfileID from CFF_Family_Details";
    results = [database executeQuery:query84];
    if (!results){
        query84 = @"ALTER TABLE CFF_Family_Details ADD COLUMN ClientProfileID TEXT";
        [database executeUpdate:query84];
    }
    
    [database close];
    return YES;
}

+(BOOL)createTableeApp:(NSString *)path {
	FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
	
	NSString *query = @"CREATE TABLE IF NOT EXISTS eProposal_Contact (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, ContactCode TEXT, ContactDesc TEXT, Status TEXT)";
	[database executeUpdate:query];
	
	query = @"CREATE TABLE IF NOT EXISTS eProposal_ErrorListing (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, ID TEXT, RefNo TEXT, ErrorCode TEXT, ErrorDescription TEXT, ErrorCreatedAt TEXT, CreatedAt TEXT)";
	[database executeUpdate:query];
	
	query = @"CREATE TABLE IF NOT EXISTS eProposal_Existing_Policy_1 (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, eProposalNo TEXT, ExistingPolicy_Answer1 TEXT, ExistingPolicy_Answer1a TEXT, ExistingPolicy_Answer2 TEXT, ExistingPolicy_Answer3 TEXT, ExistingPolicy_Answer4 TEXT, ExistingPolicy_Answer5 TEXT, Withdraw_CashDividend TEXT, Withdraw_GuaranteedCash TEXT, CompanyKeep_CashDividend TEXT, CompanyKeep_GuaranteedCash TEXT, blnBackDating TEXT, BackDating TEXT, CreatedAt TEXT, UpdatedAt TEXT ProposalPTypeCode TEXT, CashPayment_PO TEXT, CashPayment_Acc TEXT)";
	[database executeUpdate:query];
	
	query = @"CREATE TABLE IF NOT EXISTS eProposal_Existing_Policy_2 (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, RecID TEXT, eProposalNo TEXT, PTypeCode TEXT, PTypeCodeDesc TEXT, ExistingPolicy_Company TEXT, ExistingPolicy_LifeTerm TEXT, ExistingPolicy_Accident TEXT,ExistingPolicy_DailyHospitalIncome TEXT, ExistingPolicy_CriticalIllness TEXT, ExistingPolicy_DateIssued TEXT, CreatedAt TEXT, UpdatedAt TEXT)";
	[database executeUpdate:query];
	
	query = @"CREATE TABLE IF NOT EXISTS eProposal_LA_Details (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, eProposalNo TEXT, PTypeCode TEXT, LATitle TEXT, LAName TEXT, LASex TEXT, LADOB TEXT, LANewICNo TEXT, LAOtherIDType TEXT, LAOtherID TEXT, LAMaritalStatus TEXT, LARace TEXT, LAReligion TEXT, LANationality TEXT, LAOccupationCode TEXT, LAExactDuties TEXT, LATypeOfBusiness TEXT, LAEmployerName TEXT, LAYearlyIncome TEXT, LARelationship TEXT, POFlag TEXT, CorrespondenceAddress TEXT, ResidenceOwnRented TEXT,ResidenceAddress1 TEXT, ResidenceAddress2 TEXT, ResidenceAddress3 TEXT, ResidenceTown TEXT, ResidenceState TEXT, ResidencePostcode TEXT, ResidenceCountry TEXT, OfficeAddress1 TEXT, OfficeAddress2 TEXT, OfficeAddress3 TEXT, OfficeTown TEXT,OfficeState TEXT, OfficePostcode TEXT, OfficeCountry TEXT, ResidencePhoneNo TEXT, OfficePhoneNo TEXT, FaxPhoneNo TEXT, MobilePhoneNo TEXT, EmailAddress TEXT, PentalHealthStatus TEXT, PentalFemaleStatus TEXT, PentalDeclarationStatus TEXT,LACompleteFlag TEXT, AddPO TEXT, LASmoker TEXT, ResidenceForeignAddressFlag TEXT, OfficeForeignAddressFlag TEXT, CreatedAt TEXT, UpdatedAt TEXT, POType TEXT, GST_registered TEXT, GST_registrationNo TEXT, GST_registrationDate TEXT, GST_exempted TEXT";
	[database executeUpdate:query];
	
	query = @"CREATE TABLE IF NOT EXISTS eProposal_NM_Details (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, eProposalNo TEXT, NMTitle TEXT, NMName TEXT, NMShare TEXT, NMNewICNo TEXT, NMOtherIDType TEXT, NMOtherID TEXT, NMSex TEXT, NMDOB TEXT, NMRelationship TEXT, NMSamePOAddress TEXT, NMAddress1 TEXT, NMAddress2 TEXT, NMAddress3 TEXT, NMTown TEXT, NMState TEXT, NMPostcode TEXT, NMCountry TEXT, NMForeignAddress TEXT, NMCRAddress1 TEXT, NMCRAddress2 TEXT, NMCRAddress3 TEXT,  NMCRTown TEXT, NMCRState TEXT, NMCRPostcode TEXT, NMCRCountry TEXT, NMCRForeignAddress TEXT, NMNationality TEXT, NMNameOfEmployer TEXT, NMOccupation TEXT, NMExactDuties TEXT, CreatedAt TEXT, UpdatedAt TEXT)";
	[database executeUpdate:query];
	
	query = @"CREATE TABLE IF NOT EXISTS eProposal_QuestionAns (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, eProposalNo TEXT, LAType TEXT, QnID TEXT, QnParty TEXT, AnswerType TEXT, Answer TEXT, Reason TEXT, CreatedAt TEXT, UpdatedAt TEXT)";
	[database executeUpdate:query];
	
	query = @"CREATE TABLE IF NOT EXISTS eProposal_Rider (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, Id TEXT, eProposalNo TEXT, PTypeCode TEXT, RiderCode TEXT, RiderTerm TEXT, RiderSA TEXT, RiderModalPremium TEXT, CreatedAt TEXT, UpdatedAt Text)";
	[database executeUpdate:query];
	
	query = @"CREATE TABLE IF NOT EXISTS eProposal_Trustee_Details (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, eProposalNo TEXT, TrusteeTitle TEXT, TrusteeName TEXT, TrusteeSex TEXT, TrusteeNewICNo TEXT, TrusteeDOB TEXT,TrusteeOtherIDType TEXT, TrusteeOtherID TEXT, TrusteeRelationship TEXT, TrusteeAddress1 TEXT, TrusteeAddress2 TEXT, TrusteeAddress3 TEXT, TrusteePostcode TEXT, TrusteeState TEXT,TrusteeTown TEXT, TrusteeCountry TEXT, CreatedAt TEXT, UpdatedAt TEXT, TrusteeSameAsPO TEXT)";
	[database executeUpdate:query];
	
	query = @"CREATE TABLE IF NOT EXISTS eProposal (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, eProposalNo TEXT, SINo TEXT, PolicyNo TEXT,Status TEXT, ClientChoice TEXT, DeclarationAuthorization TEXT,GuardianName TEXT, GuardianNewICNo TEXT, COTitle TEXT,COName TEXT, COSex TEXT, CONewICNo TEXT,COOtherIDType TEXT, COOtherID TEXT, CODOB TEXT,CORelationship TEXT, COOtherRelationship TEXT, COSameAddressPO TEXT,COAddress1 TEXT, COAddress2 TEXT, COAddress3 TEXT,COTown TEXT, COState TEXT, COOtherState TEXT,COPostcode TEXT, COCountry TEXT, COOtherCountry TEXT,  COForeignAddressFlag TEXT, COCRAddress1 TEXT, COCRAddress2 TEXT, COCRAddress3 TEXT,COCRTown TEXT, COCRState TEXT, COCROtherState TEXT,COCRPostcode TEXT, COCRCountry TEXT, COCROtherCountry TEXT, COCRForeignAddressFlag TEXT, COPhoneNo TEXT, COMobileNo TEXT, COEmailAddress TEXT, CONationality TEXT, CONameOfEmployer TEXT, COOccupation TEXT, COExactNatureOfWork TEXT, FirstTimePayment TEXT, PaymentUponFinalAcceptance TEXT, RecurringPayment TEXT,FullyPaidUpOption TEXT, FullyPaidUpTerm TEXT, RevisedSA TEXT,AmtRevised TEXT, PaymentMode TEXT, CreditCardBank TEXT,CreditCardType TEXT, CardMemberAccountNo TEXT, CardExpiredDate TEXT,PTypeCode TEXT, CardMemberName TEXT, CardMemberSex TEXT,CardMemberDOB TEXT, CardMemberNewICNo TEXT, CardMemberOtherIDType TEXT,CardMemberOtherID TEXT, CardMemberContactNo TEXT, CardMemberRelationship TEXT,BasicPlanCode TEXT, BasicPlanTerm TEXT, BasicPlanSA TEXT,BasicPlanModalPremium TEXT, TotalModalPremium TEXT, SecondAgentCode TEXT,SecondAgentName TEXT, SecondAgentContactNo TEXT, COMandatoryFlag TEXT,PolicyDetailsMandatoryFlag TEXT, ExistingPoliciesMandatoryFlag VARCHAR DEFAULT 'N' NOT NULL, ProposalCompleted VARCHAR DEFAULT 'N' NOT NULL ,QuestionnaireMandatoryFlag TEXT, NomineesMandatoryFlag TEXT,LAMandatoryFlag TEXT, AdditionalQuestionsMandatoryFlag TEXT, DeclarationMandatoryFlag TEXT,SynchFlag TEXT, SIType TEXT, SIRemarks TEXT,SIVersion TEXT, eAppVersion TEXT, AgentCode TEXT,PDSFlag TEXT, StatusRemarks TEXT, CreatedBy TEXT,CreatedAt TEXT, UpdatedAt TEXT, SynchAt TEXT,IsResubmit TEXT)";
	[database executeUpdate:query];
	
	query = @"CREATE TABLE IF NOT EXISTS eProposal_Additional_Questions_1 (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, eProposalNo TEXT, AdditionalQuestionsName TEXT, AdditionalQuestionsMonthlyIncome TEXT,AdditionalQuestionsOccupationCode TEXT, AdditionalQuestionsInsured TEXT, AdditionalQuestionsReason TEXT, CreatedAt TEXT, UpdatedAt TEXT)";
	[database executeUpdate:query];
    
	query = @"CREATE TABLE IF NOT EXISTS eProposal_Additional_Questions_2 (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, RecID TEXT, eProposalNo TEXT, AdditionalQuestionsCompany TEXT,AdditionalQuestionsAmountInsured TEXT, AdditionalQuestionsLifeAccidentDisease TEXT, AdditionalQuestionsYrIssued TEXT, CreatedAt TEXT, UpdatedAt TEXT)";
	[database executeUpdate:query];
	
	query = @"CREATE TABLE IF NOT EXISTS eProposal_Address_Type (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, AddressCode TEXT, AddressDesc TEXT, Status TEXT)";
	[database executeUpdate:query];
	
	query = @"CREATE TABLE IF NOT EXISTS eApp_Listing (ID INTEGER PRIMARY KEY AUTOINCREMENT, ClientProfileID TEXT, POName TEXT, IDNumber TEXT, ProposalNo TEXT, DateCreated TEXT, DateUpdated TEXT, Status TEXT)";
	[database executeUpdate:query];
    
    // from query15 until query30 is newly added by Benjamin on 28/10/2013
    query = @"CREATE TABLE IF NOT EXISTS eProposal_CFF_CA (CFFID , ID INTEGER PRIMARY KEY, eProposalNo TEXT, Choice1 TEXT, Choice2 TEXT, Choice3 TEXT, Choice4 TEXT, Choice5 TEXT, Choice6 TEXT, Choices6Desc TEXT, EAPPID TEXT)";
    [database executeUpdate:query];
    
    query = @"CREATE TABLE IF NOT EXISTS eProposal_CFF_CA_Recommendation (CFFID , ID INTEGER PRIMARY KEY, eProposalNo TEXT, Seq TEXT, PTypeCode TEXT, InsuredName TEXT, PlanType TEXT, Term TEXT, Premium TEXT, Frequency TEXT, SumAssured TEXT, BoughtOption TEXT, AddNew TEXT, EAPPID TEXT)";
    [database executeUpdate:query];
    
    query = @"CREATE TABLE IF NOT EXISTS eProposal_CFF_CA_Recommendation_Rider (CFFID , ID INTEGER PRIMARY KEY, eProposalNo TEXT, Seq TEXT, RiderName TEXT, EAPPID TEXT)";
    [database executeUpdate:query];
    
    query = @"CREATE TABLE IF NOT EXISTS eProposal_CFF_Education (CFFID , ID INTEGER PRIMARY KEY, eProposalNo TEXT, NoChild TEXT, NoExistingPlan TEXT, CurrentAmt_Child_1 TEXT, RequiredAmt_Child_1 TEXT, SurplusShortFallAmt_Child_1 TEXT, CurrentAmt_Child_2 TEXT, RequiredAmt_Child_2 TEXT, SurplusShortFallAmt_Child_2 TEXT, CurrentAmt_Child_3 TEXT, RequiredAmt_Child_3 TEXT, SurplusShortFallAmt_Child_3 TEXT, CurrentAmt_Child_4 TEXT, RequiredAmt_Child_4 TEXT, SurplusShortFallAmt_Child_4 TEXT, AllocateIncome_1 TEXT, EAPPID TEXT)";
    [database executeUpdate:query];
    
    query = @"CREATE TABLE IF NOT EXISTS eProposal_CFF_Education_Details (CFFID , ID INTEGER PRIMARY KEY, eProposalNo TEXT, SeqNo TEXT, Name TEXT, CompanyName TEXT, Premium TEXT, Frequency TEXT, StartDate TEXT, MaturityDate TEXT, ProjectedValueAtMaturity TEXT, EAPPID TEXT)";
    [database executeUpdate:query];
    
    query = @"CREATE TABLE IF NOT EXISTS eProposal_CFF_Family_Details (CFFID , ID INTEGER PRIMARY KEY, eProposalNo TEXT, AddFromCFF TEXT, CompleteFlag TEXT, SameAsPO TEXT, PTypeCode TEXT, Name TEXT, Relationship TEXT, DOB TEXT, Age TEXT, Sex TEXT, YearsToSupport TEXT, RelationshipIndexNo TEXT, EAPPID TEXT)";
    [database executeUpdate:query];
    
    query = @"CREATE TABLE IF NOT EXISTS eProposal_CFF_Master (SecICompleted , SecHCompleted , SecGCompleted , SecFSavingsCompleted , SecFEducationCompleted , SecFRetirementCompleted , SecFProtectionCompleted , SecECompleted , SecDCompleted , SecCCompleted , SecBCompleted , SecACompleted , PartnerClientProfileID , ID INTEGER, eProposalNo TEXT, EAPPID, TEXT, ClientProfileID TEXT, IntermediaryStatus TEXT, BrokerName TEXT, ClientChoice TEXT, RiskReturnProfile TEXT, NeedsQ1_Ans1 TEXT, NeedsQ1_Ans2 TEXT, NeedsQ1_Priority TEXT, NeedsQ2_Ans1 TEXT, NeedsQ2_Ans2 TEXT, NeedsQ2_Priority TEXT, NeedsQ3_Ans1 TEXT, NeedsQ3_Ans2 TEXT, NeedsQ3_Priority TEXT, NeedsQ4_Ans1 TEXT, NeedsQ4_Ans2 TEXT, NeedsQ4_Priority TEXT, NeedsQ5_Ans1 TEXT, NeedsQ5_Ans2 TEXT, NeedsQ5_Priority TEXT, IntermediaryCode TEXT, IntermediaryName TEXT, IntermediaryNRIC TEXT, IntermediaryContractDate TEXT, IntermediaryAddress1 TEXT, IntermediaryAddress2 TEXT, IntermediaryAddress3 TEXT, IntermediaryAddress4 TEXT, IntermediaryManagerName TEXT, ClientAck TEXT, ClientComments TEXT, CreatedAt TEXT, LastUpdatedAt TEXT, Status TEXT, CFFType TEXT)";
    [database executeUpdate:query];
    
    query = @"CREATE TABLE IF NOT EXISTS eProposal_CFF_Personal_Details (ID INTEGER PRIMARY KEY AUTOINCREMENT, eProposalNo TEXT, AddFromCFF TEXT, CompleteFlag TEXT, PTypeCode TEXT, PYFlag TEXT, AddNewPayor TEXT, SameAsPO TEXT, Title TEXT, Name, NewICNo TEXT, OtherIDType TEXT, OtherID TEXT, Nationality TEXT, Race TEXT, Religion TEXT, Sex TEXT, Smoker TEXT, DOB TEXT, Age TEXT, MaritalStatus TEXT, OccupationCode TEXT, MailingForeignAddressFlag TEXT, MailingAddressSameAsPO TEXT, MailingAddress1 TEXT, MailingAddress2 TEXT, MailingAddress3 TEXT, MailingTown TEXT, MailingState TEXT, MailingPostCode TEXT, MailingCountry TEXT, PermanentForeignAddressFlag TEXT, PermanentAddressSameAsPO TEXT, PermanentAddress1 TEXT, PermanentAddress2 TEXT, PermanentAddress3 TEXT, PermanentTown TEXT, PermanentState TEXT, PermanentPostCode TEXT, PermanentCountry TEXT, ResidencePhoneNo TEXT, OfficePhoneNo TEXT, MobilePhoneNo TEXT, FaxPhoneNo TEXT, EmailAddress TEXT, EAPPID TEXT)";
    [database executeUpdate:query];
    
    query = @"CREATE TABLE IF NOT EXISTS eProposal_CFF_Protection (CFFID , ID INTEGER PRIMARY KEY, eProposalNo TEXT, NoExistingPlan TEXT, AllocateIncome_1 TEXT, AllocateIncome_2 TEXT, TotalSA_CurrentAmt TEXT, TotalSA_RequiredAmt TEXT, TotalSA_SurplusShortFall TEXT, TotalCISA_CurrentAmt TEXT, TotalCISA_RequiredAmt TEXT, TotalCISA_SurplusShortFall TEXT, TotalHB_CurrentAmt TEXT, TotalHB_RequiredAmt TEXT, TotalHB_SurplusShortFall TEXT, TotalPA_CurrentAmt TEXT, TotalPA_RequiredAmt TEXT, TotalPA_SurplusShortFall TEXT, EAPPID TEXT)";
    [database executeUpdate:query];
    
    query = @"CREATE TABLE IF NOT EXISTS eProposal_CFF_Protection_Details (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, SeqNo TEXT, POName TEXT, CompanyName TEXT, PlanType TEXT, LifeAssuredName TEXT, Benefit1 TEXT, Benefit2 TEXT, Benefit3 TEXT, Benefit4 TEXT, Premium TEXT, Mode TEXT, MaturityDate TEXT, EAPPID TEXT)";
    [database executeUpdate:query];
    
    query = @"CREATE TABLE IF NOT EXISTS eProposal_CFF_RecordOfAdvice (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, SameAsQuotation TEXT, Priority TEXT, PlanType TEXT, Term TEXT, InsurerName TEXT, PTypeCode TEXT, InsuredName TEXT, SumAssured TEXT, ReasonRecommend TEXT, ActionRemark TEXT, EAPPID TEXT)";
    [database executeUpdate:query];
    
    query = @"CREATE TABLE IF NOT EXISTS eProposal_CFF_RecordOfAdvice_Rider (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, Priority TEXT, RiderName TEXT, Seq TEXT, EAPPID TEXT)";
    [database executeUpdate:query];
    
    query = @"CREATE TABLE IF NOT EXISTS eProposal_CFF_Retirement (CFFID , ID INTEGER PRIMARY KEY, eProposalNo TEXT, NoExistingPlan TEXT, AllocateIncome_1 TEXT, AllocateIncome_2 TEXT, CurrentAmt TEXT, RequiredAmt TEXT, SurplusShortFallAmt TEXT, OtherIncome_1 TEXT, OtherIncome_2 TEXT, EAPPID TEXT)";
    [database executeUpdate:query];
    
    query = @"CREATE TABLE IF NOT EXISTS eProposal_CFF_Retirement_Details (CFFID , ID INTEGER PRIMARY KEY, eProposalNo TEXT, SeqNo TEXT, POName TEXT, CompanyName TEXT, PlanType TEXT, Premium TEXT, Frequency TEXT, StartDate TEXT, MaturityDate TEXT, ProjectedLumSum TEXT, ProjectedAnnualIncome TEXT, AdditionalBenefits TEXT, EAPPID TEXT)";
    [database executeUpdate:query];
    
    query = @"CREATE TABLE IF NOT EXISTS eProposal_CFF_SavingsInvest (CFFID , ID INTEGER PRIMARY KEY, eProposalNo TEXT, NoExistingPlan TEXT, CurrentAmt TEXT, RequiredAmt TEXT, SurplusShortFallAmt TEXT, AllocateIncome_1 TEXT, EAPPID TEXT)";
    [database executeUpdate:query];
    
    query = @"CREATE TABLE IF NOT EXISTS eProposal_CFF_SavingsInvest_Details (CFFID , ID INTEGER PRIMARY KEY, eProposalNo TEXT, SeqNo TEXT, POName TEXT, CompanyName TEXT, PlanType TEXT, Purpose TEXT, Premium TEXT, CommDate TEXT, MaturityAmt TEXT, EAPPID TEXT)";
    [database executeUpdate:query];
    
	
	query = @"CREATE TABLE IF NOT EXISTS eProposal_Signature (ID INTEGER PRIMARY KEY AUTOINCREMENT, eProposalNo TEXT, isCustSign TEXT, DateCustSign DATETIME, isPOSign TEXT, DatePOSign DATETIME, isLASign TEXT, DateLASign DATETIME, isLA2Sign TEXT, DateLA2Sign DATETIME, isCOSign TEXT, DateCOSign DATETIME, isTrusteeSign TEXT, DateTrusteeSign DATETIME, isTrustee2Sign TEXT, DateTrustee2Sign DATETIME, isGuardianSign TEXT, DateGuardianSign DATETIME, isWitnessSign TEXT, DateWitnessSign DATETIME, isCardHolderSign TEXT, DateCardHolderSign DATETIME, isManagerSign TEXT, DateManagerSign DATETIME, isIntermediarySign TEXT, DateIntermediarySign DATETIME)";
    [database executeUpdate:query];
    
	
	query = @"SELECT SignAt from eProposal_Signature";
    FMResultSet *results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal_Signature add SignAt TEXT";
        [database executeUpdate:query];
    }
	
    //
    query = @"SELECT TrusteeSameAsPO from eProposal_Trustee_Details";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal_Trustee_Details add TrusteeSameAsPO TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT LASmoker from eProposal_LA_Details";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal_LA_Details add LASmoker TEXT";
        [database executeUpdate:query];
    }
    
    
    query = @"SELECT ResidenceForeignAddressFlag from eProposal_LA_Details";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal_LA_Details add ResidenceForeignAddressFlag TEXT";
        [database executeUpdate:query];
    }
    
    
    query = @"SELECT OfficeForeignAddressFlag from eProposal_LA_Details";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal_LA_Details add OfficeForeignAddressFlag TEXT";
        [database executeUpdate:query];
    }

    query = @"SELECT GST_registered from eProposal_LA_Details";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal_LA_Details add GST_registered TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT GST_registrationNo from eProposal_LA_Details";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal_LA_Details add GST_registrationNo TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT GST_registrationDate from eProposal_LA_Details";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal_LA_Details add GST_registrationDate TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT GST_exempted from eProposal_LA_Details";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal_LA_Details add GST_exempted TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT ExistingPoliciesMandatoryFlag from eProposal";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal add ExistingPoliciesMandatoryFlag VARCHAR DEFAULT 'N' NOT NULL  ";
        [database executeUpdate:query];
    }
    
    query = @"SELECT CashPayment_PO from eProposal_Existing_Policy_1";
    results = [database executeQuery:query];
    if (!results) {
        [database executeUpdate:@"alter table eProposal_Existing_Policy_1 add column CashPayment_PO TEXT"];
    }
    
    query = @"SELECT CashPayment_Acc from eProposal_Existing_Policy_1";
    results = [database executeQuery:query];
    if (!results) {
        [database executeUpdate:@"alter table eProposal_Existing_Policy_1 add column CashPayment_Acc TEXT"];
    }

    query = @"SELECT ExistingPolicy_Answer1a from eProposal_Existing_Policy_1";
    results = [database executeQuery:query];
    if (!results) {
        [database executeUpdate:@"alter table eProposal_Existing_Policy_1 add column ExistingPolicy_Answer1a TEXT"];
    }
    
    
    query = @"SELECT POType from eProposal_LA_Details";
    results = [database executeQuery:query];
    if (!results) {
        [database executeUpdate:@"alter table eProposal_LA_Details add column POType TEXT"];
    }
    
    query = @"SELECT ProposalCompleted from eProposal";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal add ProposalCompleted VARCHAR DEFAULT 'N' NOT NULL";
        [database executeUpdate:query];
    }
    
    query = @"CREATE TABLE IF NOT EXISTS \"prospect_groups\" (\"id\" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL, \"name\" VARCHAR NOT NULL DEFAULT \"GROUP\")";
    [database executeUpdate:query];
    
    query = @"CREATE TABLE IF NOT EXISTS \"eProposal_Authorization\" (\"eProposalNo\" VARCHAR, \"flag\" VARCHAR)";
    [database executeUpdate:query];
    
    query = @"SELECT MobilePhoneNoPrefix from eProposal_LA_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_LA_Details add column MobilePhoneNoPrefix TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT ResidencePhoneNoPrefix from eProposal_LA_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_LA_Details add column ResidencePhoneNoPrefix TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT OfficePhoneNoPrefix from eProposal_LA_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_LA_Details add column OfficePhoneNoPrefix TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT FaxPhoneNoPrefix from eProposal_LA_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_LA_Details add column FaxPhoneNoPrefix TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT CFFID from CFF_Personal_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table CFF_Personal_Details add column CFFID TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT CFFID from ResidencePhoneNoExt";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table CFF_Personal_Details add column ResidencePhoneNoExt TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT CFFID from OfficePhoneNoExt";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table CFF_Personal_Details add column OfficePhoneNoExt TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT OfficePhoneNoExt from CFF_Personal_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table CFF_Personal_Details add column OfficePhoneNoExt TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT MobilePhoneNoExt from CFF_Personal_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table CFF_Personal_Details add column MobilePhoneNoExt TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT FaxPhoneNoExt from CFF_Personal_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table CFF_Personal_Details add column FaxPhoneNoExt TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT LastUpdated from CFF_Personal_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table CFF_Personal_Details add column LastUpdated DATETIME";
        [database executeUpdate:query];
    }
    
    query = @"SELECT LastUpdated from eProposal_CFF_Personal_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_CFF_Personal_Details add column LastUpdated DATETIME";
        [database executeUpdate:query];
    }
    
    query = @"SELECT CFFID from ePropoal_CFF_Personal_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_CFF_Personal_Details add column CFFID TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT ResidencePhoneNoExt from eProposal_CFF_Personal_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_CFF_Personal_Details add column ResidencePhoneNoExt TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT OfficePhoneNoExt from eProposal_CFF_Personal_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_CFF_Personal_Details add column OfficePhoneNoExt TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT FaxPhoneNoExt from eProposal_CFF_Personal_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_CFF_Personal_Details add column FaxPhoneNoExt TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT MobilePhoneNoExt from eProposal_CFF_Personal_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_CFF_Personal_Details add column MobilePhoneNoExt TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT OtherIDNo from eApp_Listing";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eApp_Listing add column OtherIDNo TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT ProspectProfileChangesCounter from eProposal_LA_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_LA_Details add column ProspectProfileChangesCounter INTEGER DEFAULT '1' NOT NULL ";
        [database executeUpdate:query];
    }
    
    query = @"SELECT ProspectProfileID from eProposal_LA_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_LA_Details add column ProspectProfileID VARCHAR ";
        [database executeUpdate:query];
    }
    
    
    query = @"SELECT ProspectProfileChangesCounter from prospect_profile";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table prospect_profile add column ProspectProfileChangesCounter INTEGER DEFAULT '1' NOT NULL ";
        [database executeUpdate:query];
    }
    
    
    query = @"SELECT SystemName from eProposal";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal add column SystemName VARCHAR ";
        [database executeUpdate:query];
    }
    
    query = @"SELECT CFFChangesCounter from CFF_Master";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table CFF_Master add column CFFChangesCounter INTEGER DEFAULT 1 NOT NULL ";
        bool success = [database executeUpdate:query];
        if (success) {
            NSLog(@"insert CFFChangesCounter success");
        }
    }
    
    query = @"SELECT CFFChangesCounter from eProposal_CFF_Master";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_CFF_Master add column CFFChangesCounter INTEGER DEFAULT 1 NOT NULL ";
        bool success = [database executeUpdate:query];
        if (success) {
            NSLog(@"insert CFFChangesCounter success");
        }
    }
    
    results = Nil;
    results = [database executeQuery:@"select HaveChildren from eProposal_LA_Details"];
    if (!results) {
        bool success = [database executeUpdate:@"alter table eProposal_LA_Details add column HaveChildren VARCHAR"];
        if (success) {
            NSLog(@"insert HaveChildren success");
        }
    }
    
    results = Nil;
    results = [database executeQuery:@"select ProposalPTypeCode from eProposal_Existing_Policy_1"];
    if (!results) {
        bool success = [database executeUpdate:@"alter table eProposal_Existing_Policy_1 add column ProposalPTypeCode VARCHAR"];
        if (success) {
            NSLog(@"insert ProposalPTypeCode success");
        }
    }
    
    results = Nil;
    results = [database executeQuery:@"select ProspectProfileChangesCounter from CFF_Master"];
    if (!results) {
        bool success = [database executeUpdate:@"alter table CFF_Master add column ProspectProfileChangesCounter INTEGER DEFAULT 1 NOT NULL"];
        if (success) {
            NSLog(@"insert ProspectProfileChangesCounter into CFF_Master success");
        }
    }
    
    results = Nil;
    results = [database executeQuery:@"select LIEN from eProposal"];
    if (!results) {
        bool success = [database executeUpdate:@"alter table eProposal add column LIEN VARCHAR DEFAULT FALSE"];
        if (success) {
            NSLog(@"insert LIEN success");
        }
    }    
    
    query = @"CREATE TABLE IF NOT EXISTS eProposal_Riders (id INTEGER PRIMARY KEY  NOT NULL ,eProposalNo VARCHAR DEFAULT (null) ,RiderCode VARCHAR,PaidUp DOUBLE)";
    [database executeUpdate:query];
    
    query = @"CREATE TABLE eProposal_PaidUp_Riders (id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , RiderCode VARCHAR)";
    [database executeUpdate:query];
    
    query = @"SELECT count(*) as count FROM eProposal_PaidUp_Riders WHERE RiderCode = 'ECAR'";
    results = [database executeQuery:query];
    if ([results next]) {
        int count = [results intForColumn:@"count"];
        if (count == 0) {
            [database executeUpdate:@"INSERT INTO eProposal_PaidUp_Riders (RiderCode) VALUES ('ECAR')"];
        }
    }
    
    query = @"SELECT count(*) as count FROM eProposal_PaidUp_Riders WHERE RiderCode = 'ECAR6'";
    results = [database executeQuery:query];
    if ([results next]) {
        int count = [results intForColumn:@"count"];
        if (count == 0) {
            [database executeUpdate:@"INSERT INTO eProposal_PaidUp_Riders (RiderCode) VALUES ('ECAR6')"];
        }
    }
    
    query = @"SELECT count(*) as count FROM eProposal_PaidUp_Riders WHERE RiderCode = 'ECAR60'";
    results = [database executeQuery:query];
    if ([results next]) {
        int count = [results intForColumn:@"count"];
        if (count == 0) {
            [database executeUpdate:@"INSERT INTO eProposal_PaidUp_Riders (RiderCode) VALUES ('ECAR60')"];
        }
    }
    
    query = @"SELECT Years FROM eProposal_Riders";
    results = [database executeQuery:query];
    if (!results) {
        [database closeOpenResultSets];
        [database executeUpdate:@"DROP TABLE eProposal_Riders"];
        [database executeUpdate:@"CREATE TABLE eProposal_Riders (id INTEGER PRIMARY KEY  NOT NULL ,eProposalNo VARCHAR DEFAULT (null) ,RiderCode VARCHAR,PaidUp VARCHAR DEFAULT Y , Years INTEGER DEFAULT 0)"];
    }
	    
    query = @"SELECT COForeignAddressFlag FROM eProposal";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal add column COForeignAddressFlag TEXT";
        bool success = [database executeUpdate:query];
        if (success) {
            NSLog(@"insert COForeignAddressFlag success");
        }
    }
    //Basvi added
    query = @"SELECT ExistingPolicy_DailyHospitalIncome from eProposal_Existing_Policy_2";
    results = [database executeQuery:query];
    if (!results){
        query = @"ALTER TABLE eProposal_Existing_Policy_2 ADD COLUMN ExistingPolicy_DailyHospitalIncome TEXT";
        [database executeUpdate:query];
    }

    // new fields for new proposal form
    query = @"SELECT CONationality FROM eProposal";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal add column CONationality TEXT";
        bool success = [database executeUpdate:query];
        if (success) {
            NSLog(@"insert CONationality success");
        }
    }
    
    query = @"SELECT CONameOfEmployer FROM eProposal";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal add column CONameOfEmployer TEXT";
        bool success = [database executeUpdate:query];
        if (success) {
            NSLog(@"insert CONameOfEmployer success");
        }
    }
    
    query = @"SELECT COOccupation FROM eProposal";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal add column COOccupation TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT COExactNatureOfWork FROM eProposal";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal add column COExactNatureOfWork TEXT";
        [database executeUpdate:query];        
    }
    
    query = @"SELECT COCRAddress1 FROM eProposal";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal add column COCRAddress1 TEXT";
        [database executeUpdate:query];        
    }
    query = @"SELECT COCRAddress2 FROM eProposal";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal add column COCRAddress2 TEXT";
        [database executeUpdate:query];        
    }
    query = @"SELECT COCRAddress3 FROM eProposal";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal add column COCRAddress3 TEXT";
        [database executeUpdate:query];        
    }
    query = @"SELECT COCRTown FROM eProposal";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal add column COCRTown TEXT";
        [database executeUpdate:query];        
    }
    query = @"SELECT COCRState FROM eProposal";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal add column COCRState TEXT";
        [database executeUpdate:query];        
    }
    query = @"SELECT COCROtherState FROM eProposal";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal add column COCROtherState TEXT";
        [database executeUpdate:query];        
    }
    query = @"SELECT COCRPostcode FROM eProposal";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal add column COCRPostcode TEXT";
        [database executeUpdate:query];        
    }
    query = @"SELECT COCRCountry FROM eProposal";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal add column COCRCountry TEXT";
        [database executeUpdate:query];        
    }
    query = @"SELECT COCROtherCountry FROM eProposal";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal add column COCROtherCountry TEXT";
        [database executeUpdate:query];        
    }
    query = @"SELECT COCRForeignAddressFlag FROM eProposal";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal add column COCRForeignAddressFlag TEXT";
        [database executeUpdate:query];        
    }
    
    // new fields for new proposal form - Nominess
    query = @"SELECT NMForeignAddress FROM eProposal_NM_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_NM_Details add column NMForeignAddress TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT NMNationality FROM eProposal_NM_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_NM_Details add column NMNationality TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT NMNameOfEmployer FROM eProposal_NM_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_NM_Details add column NMNameOfEmployer TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT NMOccupation FROM eProposal_NM_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_NM_Details add column NMOccupation TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT NMExactDuties FROM eProposal_NM_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_NM_Details add column NMExactDuties TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT NMCRAddress1 FROM eProposal_NM_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_NM_Details add column NMCRAddress1 TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT NMCRAddress2 FROM eProposal_NM_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_NM_Details add column NMCRAddress2 TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT NMCRAddress3 FROM eProposal_NM_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_NM_Details add column NMCRAddress3 TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT NMCRTown FROM eProposal_NM_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_NM_Details add column NMCRTown TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT NMCRState FROM eProposal_NM_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_NM_Details add column NMCRState TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT NMCRPostcode FROM eProposal_NM_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_NM_Details add column NMCRPostcode TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT NMCRCountry FROM eProposal_NM_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_NM_Details add column NMCRCountry TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT NMCRForeignAddress FROM eProposal_NM_Details";
    results = [database executeQuery:query];
    if (!results) {
        query = @"alter table eProposal_NM_Details add column NMCRForeignAddress TEXT";
        [database executeUpdate:query];
    }
    
    //added to remove foreign postcode
    FMResultSet *result = [database executeQuery:@"select count(*) as count from adm_postcode where statecode='OT'"];
    int count = -1;
    while ([result next]) {
        count = [result intForColumn:@"count"];
    }
    if (count > 0) {
        bool success = [database executeUpdate:@"delete from adm_postcode where statecode = 'OT'"];
        if (success) {
            NSLog(@"OT foreign postcode is removed");
        }
    }
    result = nil;
    result = [database executeQuery:@"select count(*) as count from adm_postcode where statecode='SA'"];
	while ([result next]) {
        count = [result intForColumn:@"count"];
    }
    if (count > 0) {
        bool success = [database executeUpdate:@"delete from adm_postcode where statecode = 'SA'"];
        if (success) {
            NSLog(@"SA foreign postcode is removed");
        }
        
    }
    
    result = nil;
    result = [database executeQuery:@"select count(*) as count from adm_postcode where statecode='BD'"];
	while ([result next]) {
        count = [result intForColumn:@"count"];
    }
    if (count > 0) {
        bool success = [database executeUpdate:@"delete from adm_postcode where statecode = 'BD'"];
        if (success) {
            NSLog(@"BD foreign postcode is removed");
        }
        
    }
    
    result = nil;
    result = [database executeQuery:@"select count(*) as count from adm_postcode where statecode='DO'"];
	while ([result next]) {
        count = [result intForColumn:@"count"];
    }
    if (count > 0) {
        bool success = [database executeUpdate:@"delete from adm_postcode where statecode = 'DO'"];
        if (success) {
            NSLog(@"DO foreign postcode is removed");
        }
        
    }
    
    result = nil;
    result = [database executeQuery:@"select count(*) as count from adm_postcode where statecode='PT'"];
	while ([result next]) {
        count = [result intForColumn:@"count"];
    }
    if (count > 0) {
        bool success = [database executeUpdate:@"delete from adm_postcode where statecode = 'PT'"];
        if (success) {
            NSLog(@"PT foreign postcode is removed");
        }
        
    }
    
    result = nil;
    result = [database executeQuery:@"select count(*) as count from adm_postcode where statecode='SH'"];
	while ([result next]) {
        count = [result intForColumn:@"count"];
    }
    if (count > 0) {
        bool success = [database executeUpdate:@"delete from adm_postcode where statecode = 'SH'"];
        if (success) {
            NSLog(@"SH foreign postcode is removed");
        }
        
    }
    
    result = nil;
    result = [database executeQuery:@"select count(*) as count from adm_postcode where statecode='KW'"];
	while ([result next]) {
        count = [result intForColumn:@"count"];
    }
    if (count > 0) {
        bool success = [database executeUpdate:@"delete from adm_postcode where statecode = 'KW'"];
        if (success) {
            NSLog(@"KW foreign postcode is removed");
        }
        
    }
    
    result = nil;
    result = [database executeQuery:@"select count(*) as count from eproposal_state where statecode='BD'"];
	while ([result next]) {
        count = [result intForColumn:@"count"];
    }
    if (count > 0) {
        bool success = [database executeUpdate:@"delete from eproposal_state where statecode = 'BD'"];
        if (success) {
            NSLog(@"BD foreign state is removed");
        }
        
    }
    
    result = nil;
    result = [database executeQuery:@"select count(*) as count from eproposal_state where statecode='DO'"];
	while ([result next]) {
        count = [result intForColumn:@"count"];
    }
    if (count > 0) {
        bool success = [database executeUpdate:@"delete from eproposal_state where statecode = 'DO'"];
        if (success) {
            NSLog(@"DO foreign state is removed");
        }
        
    }
    
    result = nil;
    result = [database executeQuery:@"select count(*) as count from eproposal_state where statecode='KW'"];
	while ([result next]) {
        count = [result intForColumn:@"count"];
    }
    if (count > 0) {
        bool success = [database executeUpdate:@"delete from eproposal_state where statecode = 'KW'"];
        if (success) {
            NSLog(@"KW foreign state is removed");
        }
        
    }
    
    result = nil;
    result = [database executeQuery:@"select count(*) as count from eproposal_state where statecode='OT'"];
	while ([result next]) {
        count = [result intForColumn:@"count"];
    }
    if (count > 0) {
        bool success = [database executeUpdate:@"delete from eproposal_state where statecode = 'OT'"];
        if (success) {
            NSLog(@"OT foreign state is removed");
        }
        
    }
    
    result = nil;
    result = [database executeQuery:@"select count(*) as count from eproposal_state where statecode='PT'"];
	while ([result next]) {
        count = [result intForColumn:@"count"];
    }
    if (count > 0) {
        bool success = [database executeUpdate:@"delete from eproposal_state where statecode = 'PT'"];
        if (success) {
            NSLog(@"PT foreign state is removed");
        }
        
    }
    
    result = nil;
    result = [database executeQuery:@"select count(*) as count from eproposal_state where statecode='SA'"];
	while ([result next]) {
        count = [result intForColumn:@"count"];
    }
    if (count > 0) {
        bool success = [database executeUpdate:@"delete from eproposal_state where statecode = 'SA'"];
        if (success) {
            NSLog(@"SA foreign state is removed");
        }
        
    }
    
    result = nil;
    result = [database executeQuery:@"select count(*) as count from eproposal_state where statecode='SH'"];
	while ([result next]) {
        count = [result intForColumn:@"count"];
    }
    if (count > 0) {
        bool success = [database executeUpdate:@"delete from eproposal_state where statecode = 'SH'"];
        if (success) {
            NSLog(@"SH foreign state is removed");
        }
            
    }
    
    result = nil;
    result = [database executeQuery:@"select Seq from eProposal_Authorization"];
    if (!result) {
        if ([database executeUpdate:@"alter table eProposal_Authorization add column Seq INTEGER"]) {
            NSLog(@"Update eProposal_Authorization success");
        }
        else {
            NSLog(@"Failed to update eProposal_Authorization");
        }
    }
	
	query = @"SELECT IntermediaryAddrPostcode from eProposal_CFF_Master";
    results = [database executeQuery:query];
    if (!results){
        query = @"ALTER TABLE eProposal_CFF_Master ADD COLUMN IntermediaryAddrPostcode TEXT";
        [database executeUpdate:query];
    }
	
	query = @"SELECT IntermediaryAddrTown from eProposal_CFF_Master";
    results = [database executeQuery:query];
    if (!results){
        query = @"ALTER TABLE eProposal_CFF_Master ADD COLUMN IntermediaryAddrTown TEXT";
        [database executeUpdate:query];
    }
	
	query = @"SELECT IntermediaryAddrState from eProposal_CFF_Master";
    results = [database executeQuery:query];
    if (!results){
        query = @"ALTER TABLE eProposal_CFF_Master ADD COLUMN IntermediaryAddrState TEXT";
        [database executeUpdate:query];
    }
	
	query = @"SELECT IntermediaryAddrCountry from eProposal_CFF_Master";
    results = [database executeQuery:query];
    if (!results){
        query = @"ALTER TABLE eProposal_CFF_Master ADD COLUMN IntermediaryAddrCountry TEXT";
        [database executeUpdate:query];
    }
	
	query = @"SELECT isForeignAddress from eProposal_Trustee_Details";
    results = [database executeQuery:query];
    if (!results){
        query = @"ALTER TABLE eProposal_Trustee_Details ADD COLUMN isForeignAddress TEXT";
        [database executeUpdate:query];
    }
	
	query = @"SELECT NMTrustStatus from eProposal_NM_Details";
    results = [database executeQuery:query];
    if (!results){
        query = @"ALTER TABLE eProposal_NM_Details ADD COLUMN NMTrustStatus TEXT";
        [database executeUpdate:query];
    }
	
	query = @"SELECT NMChildAlive from eProposal_NM_Details";
    results = [database executeQuery:query];
    if (!results){
        query = @"ALTER TABLE eProposal_NM_Details ADD COLUMN NMChildAlive TEXT";
        [database executeUpdate:query];
    }
	
	query = @"SELECT POProfileID from eApp_Listing";
    results = [database executeQuery:query];
    if (!results){
        query = @"ALTER TABLE eApp_Listing ADD COLUMN POProfileID TEXT";
        [database executeUpdate:query];
    }
	
	query = @"SELECT ClientProfileID from eProposal_CFF_Family_Details";
    results = [database executeQuery:query];
    if (!results){
        query = @"ALTER TABLE eProposal_CFF_Family_Details ADD COLUMN ClientProfileID TEXT";
        [database executeUpdate:query];
    }
	
	query = @"SELECT eProposalNo from eProposal_CFF_Protection_Details";
    results = [database executeQuery:query];
    if (!results){
        query = @"ALTER TABLE eProposal_CFF_Protection_Details ADD COLUMN eProposalNo TEXT";
        [database executeUpdate:query];
    }
	query = @"SELECT EPP from eProposal";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal add column EPP TEXT";
        [database executeUpdate:query];
    }

	//## START Alter table for FT
	query = @"SELECT SameAsFT from eProposal";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal add column SameAsFT TEXT";
        [database executeUpdate:query];
    }
	
	query = @"SELECT FTPTypeCode from eProposal";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal add column FTPTypeCode TEXT";
        [database executeUpdate:query];
    }
	
    query = @"SELECT FTCreditCardBank from eProposal";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal add column FTCreditCardBank TEXT";
        [database executeUpdate:query];
    }
	
    query = @"SELECT FTCreditCardType from eProposal";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal add column FTCreditCardType TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT FTCardMemberAccountNo from eProposal";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal add column FTCardMemberAccountNo TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT FTCardExpiredDate from eProposal";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal add column FTCardExpiredDate TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT FTCardMemberName from eProposal";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal add column FTCardMemberName TEXT";
        [database executeUpdate:query];
    }
	
    query = @"SELECT FTCardMemberSex from eProposal";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal add column FTCardMemberSex TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT FTCardMemberDOB from eProposal";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal add column FTCardMemberDOB TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT FTCardMemberNewICNo from eProposal";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal add column FTCardMemberNewICNo TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT FTCardMemberOtherIDType from eProposal";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal add column FTCardMemberOtherIDType TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT FTCardMemberOtherID from eProposal";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal add column FTCardMemberOtherID TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT FTCardMemberContactNo from eProposal";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal add column FTCardMemberContactNo TEXT";
        [database executeUpdate:query];
    }
    
    query = @"SELECT FTCardMemberRelationship from eProposal";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal add column FTCardMemberRelationship TEXT";
        [database executeUpdate:query];
    }

	//##END
	
    query = @"SELECT Prospect_IsGrouping from prospect_profile";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table prospect_profile add column Prospect_IsGrouping TEXT";
        [database executeUpdate:query];
    }
	
    query = @"SELECT SubmitDate from eApp_Listing";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eApp_Listing add column SubmitDate DATETIME";
        [database executeUpdate:query];
    }
		
    query = @"CREATE TABLE IF NOT EXISTS eProposal_Error_Listing (ID INTEGER PRIMARY KEY, RefNo TEXT, ErrorCode TEXT, ErrorDesc TEXT, CreateDate TEXT)";
    [database executeUpdate:query];
    	
    // Create new Table for Patch Control. This table is use for checking if the patch is already done.	
    
	query = @"CREATE TABLE IF NOT EXISTS 'Patch_Control' ('PatchType' TEXT,'PatchDesc' TEXT,'Status' TEXT)";
	[database executeUpdate:query];    
    
	//Prospect table: add column
	
	query = @"SELECT CountryOfBirth from prospect_profile";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table prospect_profile add column CountryOfBirth VARCHAR";
        [database executeUpdate:query];
    }
	
	query = @"SELECT LABirthCountry from eProposal_LA_Details";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal_LA_Details add column LABirthCountry VARCHAR";
        [database executeUpdate:query];
    }
	
	//POBOX Address
	
	query = @"SELECT MalaysianWithPOBox from eProposal_LA_Details";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal_LA_Details add column MalaysianWithPOBox VARCHAR";
        [database executeUpdate:query];
    }
	
	query = @"SELECT Residence_POBOX from eProposal_LA_Details";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal_LA_Details add column Residence_POBOX VARCHAR";
        [database executeUpdate:query];
    }
	
	query = @"SELECT Office_POBOX from eProposal_LA_Details";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal_LA_Details add column Office_POBOX VARCHAR";
        [database executeUpdate:query];
    }

	query = @"SELECT isDeleted from eApp_Listing";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eApp_Listing add column isDeleted VARCHAR";
        [database executeUpdate:query];
    }
	
	query = @"SELECT TotalGSTAmt from eProposal";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal add column TotalGSTAmt INT";
        [database executeUpdate:query];
    }
	
	query = @"SELECT TotalPayableAmt from eProposal";
    results = [database executeQuery:query];
    if (!results){
        query = @"alter table eProposal add column TotalPayableAmt INT";
        [database executeUpdate:query];
    }
	
	[database close];
    return YES;

}

+(BOOL)createTableSalesActivity:(NSString *)path {
	FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
	
	NSString *query = @"CREATE TABLE IF NOT EXISTS SalesAct_contact (ID INTEGER PRIMARY KEY AUTOINCREMENT, NIP TEXT, KodeCabang TEXT, KCU TEXT, NamaReferral TEXT, NamaCabang TEXT, Kanwil TEXT, SumberReferal TEXT, TipeReferral TEXT, NamaLengkap TEXT, JenisKelamin TEXT, TanggalLahir DATE, TempatLahir TEXT, NoKTP_KITAS TEXT, Warganegara TEXT, NoHP TEXT, CreateAt DATETIME, UpdateAt DATETIME)";
	[database executeUpdate:query];
	
//	query = @"CREATE TABLE IF NOT EXISTS SalesAct_Schedule (ID INTEGER PRIMARY KEY AUTOINCREMENT, SalesActivity_ID INT, Tanggal DATETIME, Waktu TIME, Catatan TEXT, CreateAt DATETIME, UpdateAt DATETIME)";
//	[database executeUpdate:query];
//	
//	query = @"CREATE TABLE IF NOT EXISTS SalesAct_Lokasi (ID INTEGER PRIMARY KEY AUTOINCREMENT, SalesActivity_ID INT, anggal DATETIME, Waktu TIME, Catatan TEXT, Lokasi TEXT, CreateAt DATETIME, UpdateAt DATETIME)";
//	[database executeUpdate:query];
	
	
	query = @"CREATE TABLE IF NOT EXISTS SalesAct_LogActivity (ID INTEGER PRIMARY KEY AUTOINCREMENT, SalesActivity_ID INT, Lokasi TEXT, Type TEXT, Activity TEXT, Status TEXT, CreateAt DATETIME, UpdateAt DATETIME)";
	[database executeUpdate:query];
	
	
//	query = @"CREATE TABLE IF NOT EXISTS SalesAct_Log (ID INTEGER PRIMARY KEY AUTOINCREMENT, SalesActivity_ID INT, Nama TEXT, Age TEXT, Type TEXT, Activity TEXT, Status TEXT, CreateAt DATETIME, UpdateAt DATETIME)";
//	[database executeUpdate:query];
	
	[database close];
	return YES;
	
}

+(BOOL)UPDATETrad_Sys_Medical_Comb:(NSString *)path
{
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    NSString *query = [NSString stringWithFormat:@"UPDATE Trad_Sys_Medical_Comb SET \"LIMIT\" = '400' where OccpCode like '%%UNEMP%%'"];
    [database executeUpdate:query];
    
    [database close];
    return YES;
}


+(void) createSI_Temp_BenefitTable:(FMDatabase*)database
{
    NSString * query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'SI_Temp_Benefit' ('col1' varchar,'col2' varchar,'col3' varchar,'col4' varchar,'col5' varchar,'col6' varchar,'col7' varchar,'col8' varchar,'col9' varchar,'col10' varchar,'col11' varchar,'col12' varchar,'col13' varchar,'col14' varchar,'col15' varchar,'col16' varchar)"];
    [database executeUpdate:query];
}


/**
 Wealth Plan @ Edwin 07-05-2014
 */
+(void)InstallWP:(NSString *)path{
    NSString *query;
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    [self addColumnTable:@"SI_STORE_PREMIUM" column:@"PremiumWithoutHLoading" type:@"VARCHAR" dbpath:path];
    [self addColumnTable:@"Trad_rider_Details" column:@"PayingTerm" type:@"INTERGER" dbpath:path];
    [self addColumnTable:@"SI_Temp_Trad_Details" column:@"RiderCode" type:@"VARCHAR" dbpath:path];
    [self createSI_Temp_BenefitTable:database];

    
    NSString *WPRider = @"'EDUWR','WB30R','WB50R','WBI6R30','WBD10R30','WP30R','WP50R','WPTPD30R','WPTPD50R'";
    
    query = [NSString stringWithFormat:@"delete from TRAD_SYS_RIDER_MTN where ridercode in (%@)",WPRider];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"delete from Trad_Sys_RiderComb where ridercode in (%@)",WPRider];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"delete from TRAD_SYS_RIDER_PROFILE where ridercode in (%@)",WPRider];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"delete from TRAD_SYS_RIDER_LABEL where ridercode in (%@)",WPRider];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"delete from Trad_Sys_mtn where planCode = 'HLAWP'"];    
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"update trad_sys_medical_comb set 'limit' = 400 where occpcode = 'UNEMP'"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"update trad_sys_medical_comb set 'limit' = 600 where occpcode in ('HSEWIFE', 'JUV', 'STU' )"];
    [database executeUpdate:query];

    query = [NSString stringWithFormat:@"update trad_sys_medical_comb set 'limit' = 800 where occpcode = 'EMP'"];
    [database executeUpdate:query];
    
    [self addColumnTable:@"Trad_Details" column:@"GIRR" type:@"BOOL" dbpath:path];
    
    // here all insert again (Y) , a little fun is good in work
    /*******************TRAD_SYS_PROFILE***********************/
    NSUInteger countProf = [database intForQuery:@"SELECT count(*) from Trad_sys_profile where planCode='HLAWP'"];
    BOOL toContProf = false;
    if (countProf<1){
        toContProf = true;
    }
    if(toContProf)
    {
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Profile ('PlanCode','PlanName','PlanDesc','MPlanDesc','Status') VALUES(\"HLAWP\", \"HLA Wealth Plan\", \"Participating Whole Life Plan with Guaranteed Yearly Income\", \"Pelan Penyertaan Sepanjang Hayat dengan Pendapatan Tahunan Terjamin\", \"1\" )"];
        [database executeUpdate:query];
    }
    /**********************************************************/
    
    /*********************TRAD_SYS_MTN*************************/
    NSUInteger countMtn = [database intForQuery:@"SELECT count(*) from Trad_Sys_mtn where planCode='HLAWP'"];
    BOOL toContMtn = false;
    if (countMtn<1){
        toContMtn = true;
    }
    //    if(toContMtn)
    {
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_mtn VALUES(\"HLAWP\", 0, 65, 90, 90, 25, 90, 1500, 99999000, \"If you terminate this basic plan prematurely, you may get less than the amount you have paid in.\", \"Jika anda menamatkan pelan asas ini sebelum tempoh matang, anda akan mendapat kurang daripada jumlah yang telah anda bayar.\", null, \"FALSE\" )"];
        [database executeUpdate:query];
    }
    /**********************************************************/
    
    /*****************Trad_Sys_RiderComb*****************/
    NSUInteger countRid = [database intForQuery:@"SELECT count(*) from Trad_Sys_RiderComb where PlanCode='HLAWP'"];
    BOOL toContRid = false;
    if (countRid!=31){
        toContRid = true;
    }
    //    if(toContRid)
    {
        query = [NSString stringWithFormat:@"delete from trad_sys_riderComb where planCode='HLAWP'"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"C+\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"CCTR\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"CIR\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"CIWP\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"CPA\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"HB\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"HMM\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"HSP_II\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"ICR\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"LCPR\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"MG_II\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"MG_IV\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"PA\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"EDUWR\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"TPDYLA\" )"];
        [database executeUpdate:query];
        //        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"WA50R\" )"];
        //        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"WB30R\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"WB50R\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"WBI6R30\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"WBD10R30\" )"];
        [database executeUpdate:query];
        //        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"WE30R\" )"];
        //        [database executeUpdate:query];
        //        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"WE50R\" )"];
        //        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"WP30R\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"WP50R\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"WPTPD30R\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"1\", \"WPTPD50R\" )"];
        [database executeUpdate:query];
        
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"2\", \"LCWP\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"2\", \"PR\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"2\", \"SP_PRE\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"LA\", \"2\", \"SP_STD\" )"];
        [database executeUpdate:query];
        
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"PY\", \"1\", \"LCWP\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"PY\", \"1\", \"PLCP\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"PY\", \"1\", \"PR\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"HLAWP\", \"PY\", \"1\", \"PTR\" )"];
        [database executeUpdate:query];
        
    }
    /****************************************************/
    
    
    
    /*******************TRAD_SYS_RIDER_MTN********************/
    {
        NSUInteger count = [database intForQuery:@"SELECT count(*) from Trad_sys_rider_mtn where RiderCode='EDUWR'"];
        BOOL toCont = false;
        if (count<1){
            toCont = true;
        }
        if(toCont)
        {
            query = [NSString stringWithFormat:@"INSERT INTO Trad_sys_rider_mtn VALUES(\"EDUWR\", \"0\", \"5\", \"21\", \"20\", \"21\", \"100\", \"999999999\", \"0\", \"If you terminate this rider prematurely, you may get less than the amount you have paid in.\", \"Jika anda menamatkan rider ini sebelum tempoh matang, anda akan mendapat kurang daripada jumlah yang telah anda bayar.\", null )"];
            [database executeUpdate:query];
        }
    }
    
    
    NSUInteger countWA30R = [database intForQuery:@"SELECT count(*) from Trad_sys_rider_mtn where RiderCode='WBI6R30'"];
    BOOL toContWA30R = false;
    if (countWA30R<1){
        toContWA30R = true;
    }
    if(toContWA30R)
    {
        query = [NSString stringWithFormat:@"INSERT INTO Trad_sys_rider_mtn VALUES(\"WBI6R30\", \"0\", \"65\", \"95\", \"30\", \"30\", \"100\", \"999999999\", \"0\", \"If you terminate this rider prematurely, you may get less than the amount you have paid in.\", \"Jika anda menamatkan rider ini sebelum tempoh matang, anda akan mendapat kurang daripada jumlah yang telah anda bayar.\", null )"];
        [database executeUpdate:query];
    }
    
    NSUInteger countWA50R = [database intForQuery:@"SELECT count(*) from Trad_sys_rider_mtn where RiderCode='WBD10R30'"];
    BOOL toContWA50R = false;
    if (countWA50R<1){
        toContWA50R = true;
    }
    if(toContWA50R)
    {
        query = [NSString stringWithFormat:@"INSERT INTO Trad_sys_rider_mtn VALUES(\"WBD10R30\", \"0\", \"65\", \"95\", \"30\", \"30\", \"100\", \"999999999\", \"0\", \"If you terminate this rider prematurely, you may get less than the amount you have paid in.\", \"Jika anda menamatkan rider ini sebelum tempoh matang, anda akan mendapat kurang daripada jumlah yang telah anda bayar.\", null )"];
        [database executeUpdate:query];
    }
    
    
    
    NSUInteger countWB30R = [database intForQuery:@"SELECT count(*) from Trad_sys_rider_mtn where RiderCode='WB30R'"];
    BOOL toContWB30R = false;
    if (countWB30R<1){
        toContWB30R = true;
    }
    if(toContWB30R)
    {
        query = [NSString stringWithFormat:@"INSERT INTO Trad_sys_rider_mtn VALUES(\"WB30R\", \"0\", \"65\", \"95\", \"30\", \"30\", \"100\", \"999999999\", \"0\", \"If you terminate this rider prematurely, you may get less than the amount you have paid in.\", \"Jika anda menamatkan rider ini sebelum tempoh matang, anda akan mendapat kurang daripada jumlah yang telah anda bayar.\", null )"];
        [database executeUpdate:query];
    }
    
    NSUInteger countWB50R = [database intForQuery:@"SELECT count(*) from Trad_sys_rider_mtn where RiderCode='WB50R'"];
    BOOL toContWB50R = false;
    if (countWB50R<1){
        toContWB50R = true;
    }
    if(toContWB50R) 
    {
        query = [NSString stringWithFormat:@"INSERT INTO Trad_sys_rider_mtn VALUES(\"WB50R\", \"0\", \"65\", \"95\", \"50\", \"50\", \"100\", \"999999999\", \"0\", \"If you terminate this rider prematurely, you may get less than the amount you have paid in.\", \"Jika anda menamatkan rider ini sebelum tempoh matang, anda akan mendapat kurang daripada jumlah yang telah anda bayar.\", null )"];
        [database executeUpdate:query];
    }
        
    NSUInteger countWE50R = [database intForQuery:@"SELECT count(*) from Trad_sys_rider_mtn where RiderCode='WE50R'"];
    BOOL toContWE50R = false;
    if (countWE50R<1){
        toContWE50R = true;
    }
    if(toContWE50R)
    {
        query = [NSString stringWithFormat:@"INSERT INTO Trad_sys_rider_mtn VALUES(\"WE50R\", \"0\", \"65\", \"95\", \"50\", \"50\", \"500\", \"999999999\", \"0\", \"If you terminate this rider prematurely, you may get less than the amount you have paid in.\", \"Jika anda menamatkan rider ini sebelum tempoh matang, anda akan mendapat kurang daripada jumlah yang telah anda bayar.\", null )"];
        [database executeUpdate:query];
    }
    
    
    NSUInteger countWER = [database intForQuery:@"SELECT count(*) from Trad_sys_rider_mtn where RiderCode='WER'"];
    BOOL toContWER = false;
    if (countWER<1){
        toContWER = true;
    }
    if(toContWER)
    {
        query = [NSString stringWithFormat:@"INSERT INTO Trad_sys_rider_mtn VALUES(\"WER\", \"0\", \"60\", \"90\", \"0\", \"64\", \"10000\", \"999999999\", \"0\", \"If you terminate this rider prematurely, you may get less than the amount you have paid in.\", \"Jika anda menamatkan rider ini sebelum tempoh matang, anda akan mendapat kurang daripada jumlah yang telah anda bayar.\", null )"];
        [database executeUpdate:query];
    }
    
    
    NSUInteger countWP30R = [database intForQuery:@"SELECT count(*) from Trad_sys_rider_mtn where RiderCode='WP30R'"];
    BOOL toContWP30R = false;
    if (countWP30R<1){
        toContWP30R = true;
    }
    if(toContWP30R)
    {
        query = [NSString stringWithFormat:@"INSERT INTO Trad_sys_rider_mtn VALUES(\"WP30R\", \"0\", \"65\", \"30\", \"30\", \"30\", \"10000\", \"999999999\", \"0\", \"If you terminate this rider prematurely, you may get less than the amount you have paid in.\", \"Jika anda menamatkan rider ini sebelum tempoh matang, anda akan mendapat kurang daripada jumlah yang telah anda bayar.\", null )"];
        [database executeUpdate:query];
    }
    
    
    NSUInteger countWP50R = [database intForQuery:@"SELECT count(*) from Trad_sys_rider_mtn where RiderCode='WP50R'"];
    BOOL toContWP50R = false;
    if (countWP50R<1){
        toContWP50R = true;
    }
    if(toContWP50R)
    {
        query = [NSString stringWithFormat:@"INSERT INTO Trad_sys_rider_mtn VALUES(\"WP50R\", \"0\", \"65\", \"50\", \"50\", \"50\", \"10000\", \"999999999\", \"0\", \"If you terminate this rider prematurely, you may get less than the amount you have paid in.\", \"Jika anda menamatkan rider ini sebelum tempoh matang, anda akan mendapat kurang daripada jumlah yang telah anda bayar.\", null )"];
        [database executeUpdate:query];
    }
    
    NSUInteger countWPTPD30R = [database intForQuery:@"SELECT count(*) from Trad_sys_rider_mtn where RiderCode='WPTPD30R'"];
    BOOL toContWPTPD30R = false;
    if (countWPTPD30R<1){
        toContWPTPD30R = true;
    }
    if(toContWPTPD30R)
    {
        query = [NSString stringWithFormat:@"INSERT INTO Trad_sys_rider_mtn VALUES(\"WPTPD30R\", \"0\", \"65\", \"30\", \"30\", \"30\", \"10000\", \"3500000\", \"0\", \"If you terminate this rider prematurely, you may get less than the amount you have paid in.\", \"Jika anda menamatkan rider ini sebelum tempoh matang, anda akan mendapat kurang daripada jumlah yang telah anda bayar.\", null )"];
        [database executeUpdate:query];
    }
    
    NSUInteger countWPTPD50R = [database intForQuery:@"SELECT count(*) from Trad_sys_rider_mtn where RiderCode='WPTPD50R'"];
    BOOL toContWPTPD50R = false;
    if (countWPTPD50R<1){
        toContWPTPD50R = true;
    }
    if(toContWPTPD50R)
    {
        query = [NSString stringWithFormat:@"INSERT INTO Trad_sys_rider_mtn VALUES(\"WPTPD50R\", \"0\", \"65\", \"50\", \"50\", \"50\", \"10000\", \"3500000\", \"0\", \"If you terminate this rider prematurely, you may get less than the amount you have paid in.\", \"Jika anda menamatkan rider ini sebelum tempoh matang, anda akan mendapat kurang daripada jumlah yang telah anda bayar.\", null )"];
        [database executeUpdate:query];
    }
    
    
    /**********************************************************/
    
    
    /*******************TRAD_SYS_RIDER_PROFILE********************/
    {
        NSUInteger countWA30R = [database intForQuery:@"SELECT count(*) from Trad_sys_rider_profile where RiderCode='EDUWR'"];
        BOOL toContWA30R = false;
        if (countWA30R<1){
            toContWA30R = true;
        }
        if(toContWA30R)
        {
            query = [NSString stringWithFormat:@"INSERT INTO Trad_sys_rider_profile VALUES(\"EDUWR\", \"EduWealth Rider \", \"\", \"0\", \"1\", \"\", \"\", \"\", \"\", \"0\", \"01-Jan-99\" )"];
            [database executeUpdate:query];
        }
    }
    
    
    {
        NSUInteger countWA30R = [database intForQuery:@"SELECT count(*) from Trad_sys_rider_profile where RiderCode='WBI6R30'"];
        BOOL toContWA30R = false;
        if (countWA30R<1){
            toContWA30R = true;
        }
        if(toContWA30R)
        {
            query = [NSString stringWithFormat:@"INSERT INTO Trad_sys_rider_profile VALUES(\"WBI6R30\", \"Wealth Booster-i6 Rider (30 year term)\", \"\", \"0\", \"1\", \"\", \"\", \"\", \"\", \"0\", \"01-Jan-99\" )"];
            [database executeUpdate:query];
        }
    }
    
    
    {
        NSUInteger countWB30R = [database intForQuery:@"SELECT count(*) from Trad_sys_rider_profile where RiderCode='WB30R'"];
        BOOL toContWB30R = false;
        if (countWB30R<1){
            toContWB30R = true;
        }
        if(toContWB30R)
        {
            query = [NSString stringWithFormat:@"INSERT INTO Trad_sys_rider_profile VALUES(\"WB30R\", \"Wealth Booster Rider (30 year term)\", \"\", \"0\", \"1\", \"\", \"\", \"\", \"\", \"0\", \"01-Jan-99\" )"];
            [database executeUpdate:query];
        }
    }
    
    
    {
        NSUInteger countWB50R = [database intForQuery:@"SELECT count(*) from Trad_sys_rider_profile where RiderCode='WB50R'"];
        BOOL toContWB50R = false;
        if (countWB50R<1){
            toContWB50R = true;
        }
        if(toContWB50R)
        {
            query = [NSString stringWithFormat:@"INSERT INTO Trad_sys_rider_profile VALUES(\"WB50R\", \"Wealth Booster Rider (50 year term)\", \"\", \"0\", \"1\", \"\", \"\", \"\", \"\", \"0\", \"01-Jan-99\" )"];
            [database executeUpdate:query];
        }
    }
        
    {
        NSUInteger countWE30R = [database intForQuery:@"SELECT count(*) from Trad_sys_rider_profile where RiderCode='WBD10R30'"];
        BOOL toContWE30R = false;
        if (countWE30R<1){
            toContWE30R = true;
        }
        if(toContWE30R)
        {
            query = [NSString stringWithFormat:@"INSERT INTO Trad_sys_rider_profile VALUES(\"WBD10R30\", \"Wealth Booster-d10 Rider (30 year term)\", \"\", \"0\", \"1\", \"\", \"\", \"\", \"\", \"0\", \"01-Jan-99\" )"];
            [database executeUpdate:query];
        }
    }
        
    {
        NSUInteger countWER = [database intForQuery:@"SELECT count(*) from Trad_sys_rider_profile where RiderCode='WER'"];
        BOOL toContWER = false;
        if (countWER<1){
            toContWER = true;
        }
        if(toContWER)
        {
            query = [NSString stringWithFormat:@"INSERT INTO Trad_sys_rider_profile VALUES(\"WER\", \"Wealth Enhancer\", \"\", \"0\", \"0\", \"\", \"\", \"\", \"\", \"0\", \"01-Jan-99\" )"];
            [database executeUpdate:query];
        }
    }    
    
    {
        NSUInteger countWP30R = [database intForQuery:@"SELECT count(*) from Trad_sys_rider_profile where RiderCode='WP30R'"];
        BOOL toContWP30R = false;
        if (countWP30R<1){
            toContWP30R = true;
        }
        if(toContWP30R)
        {
            query = [NSString stringWithFormat:@"INSERT INTO Trad_sys_rider_profile VALUES(\"WP30R\", \"Wealth Protector Rider (30 year term)\", \"\", \"0\", \"1\", \"\", \"\", \"\", \"\", \"0\", \"01-Jan-99\" )"];
            [database executeUpdate:query];
        }
    }
        
    {
        NSUInteger countWP50R = [database intForQuery:@"SELECT count(*) from Trad_sys_rider_profile where RiderCode='WP50R'"];
        BOOL toContWP50R = false;
        if (countWP50R<1){
            toContWP50R = true;
        }
        if(toContWP50R)
        {
            query = [NSString stringWithFormat:@"INSERT INTO Trad_sys_rider_profile VALUES(\"WP50R\", \"Wealth Protector Rider (50 year term)\", \"\", \"0\", \"1\", \"\", \"\", \"\", \"\", \"0\", \"01-Jan-99\" )"];
            [database executeUpdate:query];
        }
    }
    
    
    {
        NSUInteger countWPTPD30R = [database intForQuery:@"SELECT count(*) from Trad_sys_rider_profile where RiderCode='WPTPD30R'"];
        BOOL toContWPTPD30R = false;
        if (countWPTPD30R<1){
            toContWPTPD30R = true;
        }
        if(toContWPTPD30R)
        {
            query = [NSString stringWithFormat:@"INSERT INTO Trad_sys_rider_profile VALUES(\"WPTPD30R\", \"Wealth TPD Protector Rider (30 year term)\", \"\", \"0\", \"1\", \"\", \"\", \"\", \"\", \"0\", \"01-Jan-99\" )"];
            [database executeUpdate:query];
        }
    }
    
    
    {
        NSUInteger countWPTPD50R = [database intForQuery:@"SELECT count(*) from Trad_sys_rider_profile where RiderCode='WPTPD50R'"];
        BOOL toContWPTPD50R = false;
        if (countWPTPD50R<1){
            toContWPTPD50R = true;
        }
        if(toContWPTPD50R)
        {
            query = [NSString stringWithFormat:@"INSERT INTO Trad_sys_rider_profile VALUES(\"WPTPD50R\", \"Wealth TPD Protector Rider (50 year term)\", \"\", \"0\", \"1\", \"\", \"\", \"\", \"\", \"0\", \"01-Jan-99\" )"];
            [database executeUpdate:query];
        }
    }
    
    /*************************************************************/
    
    
    /*****************TRAD_SYS_RIDER_LABEL*****************/
    {
        NSUInteger count = [database intForQuery:@"SELECT count(*) from Trad_Sys_Rider_Label where RiderCode='EDUWR' and LabelCode in ('GYIRM','HL1K','HL1KT')"];
        BOOL toCont = false;
        if (count<3){
            toCont = true;
        }
        //        if(toCont)
        {        
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"GYIRM\", \"Guaranteed Cash Payments (RM)\", \"EDUWR\", \"EduWealth Rider\", \"TF\" )"];
            [database executeUpdate:query];
            
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"HL1KT\", \"Health Loading (Per 1K SA) Term\", \"EDUWR\", \"EduWealth Rider\", \"TF\" )"];
            [database executeUpdate:query];
            
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"EDUWR\", \"EduWealth Rider\", \"TF\" )"];
            [database executeUpdate:query];
        }
    }
    
    
    {
        NSUInteger count = [database intForQuery:@"SELECT count(*) from Trad_Sys_Rider_Label where RiderCode='WBI6R30' and LabelCode in ('GYIRM','HL1K','HL1KT')"];
        BOOL toCont = false;
        if (count<3){
            toCont = true;
        }
        //        if(toCont)
        {        
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"GYIRM\", \"Guaranteeed Yearly Cash Coupons (RM)\", \"WBI6R30\", \"Wealth Booster-i6 Rider\", \"TF\" )"];
            [database executeUpdate:query];
            
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"HL1KT\", \"Health Loading (Per 1K SA) Term\", \"WBI6R30\", \"Wealth Booster-i6 Rider\", \"TF\" )"];
            [database executeUpdate:query];
            
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"WBI6R30\", \"Wealth Booster-i6 Rider\", \"TF\" )"];
            [database executeUpdate:query];
        }
    }
        
    {
        NSUInteger count = [database intForQuery:@"SELECT count(*) from Trad_Sys_Rider_Label where RiderCode='WB30R' and LabelCode in ('GYIRM','HL1K','HL1KT')"];
        BOOL toCont = false;
        if (count<3){
            toCont = true;
        }
        //        if(toCont)
        {        
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"GYIRM\", \"Guaranteeed Yearly Cash Coupons (RM)\", \"WB30R\", \"Wealth Booster Rider\", \"TF\" )"];
            [database executeUpdate:query];
            
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"HL1KT\", \"Health Loading (Per 1K SA) Term\", \"WB30R\", \"Wealth Booster Rider\", \"TF\" )"];
            [database executeUpdate:query];
            
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"WB30R\", \"Wealth Booster Rider\", \"TF\" )"];
            [database executeUpdate:query];
        }
    }
    
    
    {
        NSUInteger count = [database intForQuery:@"SELECT count(*) from Trad_Sys_Rider_Label where RiderCode='WB50R' and LabelCode in ('GYIRM','HL1K','HL1KT')"];
        BOOL toCont = false;
        if (count<3){
            toCont = true;
        }
        //        if(toCont)
        {        
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"GYIRM\", \"Guaranteeed Yearly Cash Coupons (RM)\", \"WB50R\", \"Wealth Booster Rider\", \"TF\" )"];
            [database executeUpdate:query];
            
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"HL1KT\", \"Health Loading (Per 1K SA) Term\", \"WB50R\", \"Wealth Booster Rider\", \"TF\" )"];
            [database executeUpdate:query];
            
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"WB50R\", \"Wealth Booster Rider\", \"TF\" )"];
            [database executeUpdate:query];
        }
    }
    
    
    {
        NSUInteger count = [database intForQuery:@"SELECT count(*) from Trad_Sys_Rider_Label where RiderCode='WBD10R30' and LabelCode in ('GYIRM','HL1K','HL1KT')"];
        BOOL toCont = false;
        if (count<3){
            toCont = true;
        }
        //        if(toCont)
        {        
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"GYIRM\", \"Guaranteeed Yearly Cash Coupons (RM)\", \"WBD10R30\", \"Wealth Booster-d10 Rider\", \"TF\" )"];
            [database executeUpdate:query];
            
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"HL1KT\", \"Health Loading (Per 1K SA) Term\", \"WBD10R30\", \"Wealth Booster-d10 Rider\", \"TF\" )"];
            [database executeUpdate:query];
            
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"WBD10R30\", \"Wealth Booster-d10 Rider\", \"TF\" )"];
            [database executeUpdate:query];
        }
    }
    
    {
        NSUInteger count = [database intForQuery:@"SELECT count(*) from Trad_Sys_Rider_Label where RiderCode='WP30R' and LabelCode in ('SUMA','HL1K','HL1KT')"];
        BOOL toCont = false;
        if (count<3){
            toCont = true;
        }
        if(toCont)
        {        
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"SUMA\", \"Sum Assured (RM)\", \"WP30R\", \"Wealth Protector Rider\", \"TF\" )"];
            [database executeUpdate:query];
            
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"HL1KT\", \"Health Loading (Per 1K SA) Term\", \"WP30R\", \"Wealth Protector Rider\", \"TF\" )"];
            [database executeUpdate:query];
            
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"WP30R\", \"Wealth Protector Rider\", \"TF\" )"];
            [database executeUpdate:query];
        }
    }
    
    {
        NSUInteger count = [database intForQuery:@"SELECT count(*) from Trad_Sys_Rider_Label where RiderCode='WP50R' and LabelCode in ('SUMA','HL1K','HL1KT')"];
        BOOL toCont = false;
        if (count<3){
            toCont = true;
        }
        if(toCont)
        {        
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"SUMA\", \"Sum Assured (RM)\", \"WP50R\", \"Wealth Protector Rider\", \"TF\" )"];
            [database executeUpdate:query];
            
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"HL1KT\", \"Health Loading (Per 1K SA) Term\", \"WP50R\", \"Wealth Protector Rider\", \"TF\" )"];
            [database executeUpdate:query];
            
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"WP50R\", \"Wealth Protector Rider\", \"TF\" )"];
            [database executeUpdate:query];
        }
    }
    
    {
        NSUInteger count = [database intForQuery:@"SELECT count(*) from Trad_Sys_Rider_Label where RiderCode='WPTPD30R' and LabelCode in ('SUMA','HL1K','HL1KT')"];
        BOOL toCont = false;
        if (count<3){
            toCont = true;
        }
        if(toCont)
        {        
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"SUMA\", \"Sum Assured (RM)\", \"WPTPD30R\", \"Wealth Protector (TPD) Rider\", \"TF\" )"];
            [database executeUpdate:query];
            
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"HL1KT\", \"Health Loading (Per 1K SA) Term\", \"WPTPD30R\", \"Wealth Protector (TPD) Rider\", \"TF\" )"];
            [database executeUpdate:query];
            
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"WPTPD30R\", \"Wealth Protector (TPD) Rider\", \"TF\" )"];
            [database executeUpdate:query];
        }
    }
    
    {
        NSUInteger count = [database intForQuery:@"SELECT count(*) from Trad_Sys_Rider_Label where RiderCode='WPTPD50R' and LabelCode in ('SUMA','HL1K','HL1KT')"];
        BOOL toCont = false;
        if (count<3){
            toCont = true;
        }
        if(toCont)
        {        
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"SUMA\", \"Sum Assured (RM)\", \"WPTPD50R\", \"Wealth Protector (TPD) Rider\", \"TF\" )"];
            [database executeUpdate:query];
            
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"HL1KT\", \"Health Loading (Per 1K SA) Term\", \"WPTPD50R\", \"Wealth Protector (TPD) Rider\", \"TF\" )"];
            [database executeUpdate:query];
            
            query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"WPTPD50R\", \"Wealth Protector (TPD) Rider\", \"TF\" )"];
            [database executeUpdate:query];
        }
    }
    
    
    /******************************************************/
    
    [database close];
}



+(void)InstallLife100:(NSString *)path{
    NSString *query;
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    /*********************TRAD_SYS_MTN*************************/
    NSUInteger countMtn = [database intForQuery:@"SELECT count(*) from Trad_Sys_mtn where planCode='L100'"];
    BOOL toContMtn = false;
    if (countMtn<1){
        toContMtn = true;
    }
    if(toContMtn)
    {
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_mtn VALUES(\"L100\", 0, 65, 100, null, 35, null, 20000, 99999000, null, null, null )"];
        
        [database executeUpdate:query];
    }
    /**********************************************************/
    
    /*****************TRAD_SYS_PRODUCT_MAPPING*****************/
    NSUInteger countMap = [database intForQuery:@"SELECT count(*) from Trad_Sys_Product_mapping where SIPlanCode='L100'"];
    BOOL toContMap = false;
    if (countMap<1){
        toContMap = true;
    }
    if(toContMap)
    {
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Product_mapping ('Channel','PlanType','SIPlanCode','PentaPlanCode') VALUES(\"AGT\", \"B\", \"L100\", \"CL10001PWN\" )"];
        
        [database executeUpdate:query];
    }
    /**********************************************************/    
    
    /*****************Trad_Sys_RiderComb*****************/
    NSUInteger countRid = [database intForQuery:@"SELECT count(*) from Trad_Sys_RiderComb where PlanCode='L100'"];
    BOOL toContRid = false;
    if (countRid!=21){
        toContRid = true;
    }
    if(toContRid)
    {
        query = [NSString stringWithFormat:@"delete from trad_sys_riderComb where planCode='L100'"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"L100\", \"LA\", \"1\", \"ACIR_MPP\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"L100\", \"LA\", \"1\", \"C+\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"L100\", \"LA\", \"1\", \"CCTR\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"L100\", \"LA\", \"1\", \"CIR\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"L100\", \"LA\", \"1\", \"CIWP\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"L100\", \"LA\", \"1\", \"CPA\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"L100\", \"LA\", \"1\", \"TPDYLA\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"L100\", \"LA\", \"1\", \"HB\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"L100\", \"LA\", \"1\", \"HMM\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"L100\", \"LA\", \"1\", \"HSP_II\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"L100\", \"LA\", \"1\", \"ICR\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"L100\", \"LA\", \"1\", \"LCPR\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"L100\", \"LA\", \"1\", \"MG_II\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"L100\", \"LA\", \"1\", \"MG_IV\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"L100\", \"LA\", \"1\", \"PA\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"L100\", \"LA\", \"2\", \"SP_PRE\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"L100\", \"LA\", \"2\", \"SP_STD\" )"];
        [database executeUpdate:query];
        
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"L100\", \"PY\", \"1\", \"LCWP\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"L100\", \"PY\", \"1\", \"PLCP\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"L100\", \"PY\", \"1\", \"PR\" )"];
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_RiderComb VALUES(\"L100\", \"PY\", \"1\", \"PTR\" )"];
        [database executeUpdate:query];
        
    }
    /****************************************************/
    
    /*****************TRAD_SYS_RIDER_LABEL*****************/
    NSUInteger countLabel = [database intForQuery:@"SELECT count(*) from Trad_Sys_Rider_Label where RiderCode='ACIR_MPP' and LabelCode in ('RITM','SUMA','HL1KT','HL1K')"];
    BOOL toContLAbel = false;
    if (countLabel<4){
        toContLAbel = true;
    }
    if(toContLAbel)
    {
        query = [NSString stringWithFormat:@"Delete from Trad_Sys_Rider_Label where RiderCode='ACIR_MPP'"];
        [database executeUpdate:query];
        
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"RITM\", \"Rider Term\", \"ACIR_MPP\", \"Accelerated Critical Illness Rider\", \"TF\" )"];
        
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"SUMA\", \"Sum Assured\", \"ACIR_MPP\", \"Accelerated Critical Illness Rider\", \"TF\" )"];
        
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"HL1KT\", \"Health Loading (Per 1K SA) Term\", \"ACIR_MPP\", \"Accelerated Critical Illness Rider\", \"TF\" )"];
        
        [database executeUpdate:query];
        query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Rider_Label('labelcode', 'labeldesc', 'ridercode', 'ridername', 'inputcode') VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"ACIR_MPP\", \"Accelerated Critical Illness Rider\", \"TF\" )"];
        
        [database executeUpdate:query];
    }
    /******************************************************/
        
    [database close];
}

+(BOOL)InstallUpdate:(NSString *)path
{
	NSString * AppsVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    
	sqlite3_stmt *statement;
    NSString *QuerySQL;
	NSString *CurrenVersion = @"";
	
    // checking of SI Version
	if (sqlite3_open([path UTF8String], &contactDB) == SQLITE_OK){
		
		QuerySQL = [ NSString stringWithFormat:@"select SIVersion FROM Trad_Sys_SI_version_Details"];
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW) {
				CurrenVersion = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
	
	//[self InstallVersion1dot3:path];
	if (![AppsVersion isEqualToString:CurrenVersion]) {
		
		[self InstallVersion1dot3:path];
		if (sqlite3_open([path UTF8String], &contactDB) == SQLITE_OK){
			
			QuerySQL = [ NSString stringWithFormat:@"Update Trad_Sys_SI_version_Details set SIVersion = '%@'", AppsVersion];
			if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
				if (sqlite3_step(statement) == SQLITE_DONE) {
					
				}
				sqlite3_finalize(statement);
			}
			sqlite3_close(contactDB);
		}
		
	}
    
	sqlite3_stmt *statement2;
    NSString *QuerySQL2;
	NSString *CurrenVersion2 = @"";

    // checking of eApps Version
	if (sqlite3_open([path UTF8String], &contactDB) == SQLITE_OK){
		
		QuerySQL2 = [ NSString stringWithFormat:@"select eAppVersion FROM eProposal_Version_Details"];
		if(sqlite3_prepare_v2(contactDB, [QuerySQL2 UTF8String], -1, &statement2, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement2) == SQLITE_ROW) {
				CurrenVersion2 = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 0)];
			}
			sqlite3_finalize(statement2);
		}
		sqlite3_close(contactDB);
	}
	
	
	//[self InstallVersion1dot3:path];
	if (![AppsVersion isEqualToString:CurrenVersion2]) {
		
		[self InstallVersion1dot3:path];
		if (sqlite3_open([path UTF8String], &contactDB) == SQLITE_OK){
			
			QuerySQL2 = [ NSString stringWithFormat:@"Update eProposal_Version_Details set eAppVersion = '%@'", AppsVersion];
			if(sqlite3_prepare_v2(contactDB, [QuerySQL2 UTF8String], -1, &statement2, NULL) == SQLITE_OK) {
				if (sqlite3_step(statement2) == SQLITE_DONE) {
					
				}
				sqlite3_finalize(statement2);
			}
			sqlite3_close(contactDB);
		}		
	}
    
	//added in on 8/1/14 to remove the duplicate rows
	FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
	
	NSString *query;
	
	query = [NSString stringWithFormat:@"delete from adm_occp where id in ('2','3','4','5','6') "];
	[database executeUpdate:query];
    
	query = [NSString stringWithFormat:@"DELETE from adm_occp_loading_Penta where occpcode = 'OCC01717'"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO adm_occp_loading_Penta VALUES ('OCC01717', 'PROFESSIONAL ATHLETE', '4', 'A', 'EM', '4', '0', '0')  "];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"Update adm_occp SET Occpdesc = 'PROFESSIONAL ATHLETE' where occpcode = 'OCC01717' "];
	[database executeUpdate:query];
    
	[database close];
	
    return YES;
}


+(void)ClearAllDBData :(NSString *)path{
	FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
	
	NSString *query;
    query = [NSString stringWithFormat:@"Drop table UL_Temp_Rider"];
    [database executeUpdate:query];
    
	query = [NSString stringWithFormat:@"Delete from UL_Rider_Mtn"];
	[database executeUpdate:query];
	query = [NSString stringWithFormat:@"Delete from UL_Rider_Profile"];
	[database executeUpdate:query];
	query = [NSString stringWithFormat:@"Delete from UL_Rider_Label"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"Delete from Trad_sys_profile where plancode in ('UV', 'UP') "];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"delete from adm_occp where id in ('2','3','4','5','6') "];
	[database executeUpdate:query];
	
    [self addColumnTable:@"ul_details" column:@"VUSmart" type:@"VARCHAR" dbpath:path];
    [self addColumnTable:@"ul_details" column:@"VUSmartTo" type:@"VARCHAR" dbpath:path];
    [self addColumnTable:@"ul_details" column:@"VUSmartOpt" type:@"VARCHAR" dbpath:path];
    [self addColumnTable:@"ul_details" column:@"VUSmartToOpt" type:@"VARCHAR" dbpath:path];
    [self addColumnTable:@"ul_details" column:@"VUVenture" type:@"VARCHAR" dbpath:path];
    [self addColumnTable:@"ul_details" column:@"VUVentureTp" type:@"VARCHAR" dbpath:path];
    [self addColumnTable:@"ul_details" column:@"VUVentureOpt" type:@"VARCHAR" dbpath:path];
    [self addColumnTable:@"ul_details" column:@"VUVentureToOpt" type:@"VARCHAR" dbpath:path];
    [self addColumnTable:@"ul_rider_details" column:@"PaymentChoice" type:@"VARCHAR" dbpath:path];
    [self addColumnTable:@"ul_rider_details" column:@"PreDeductible" type:@"VARCHAR" dbpath:path];
    [self addColumnTable:@"ul_rider_details" column:@"PostDeductible" type:@"VARCHAR" dbpath:path];
    [self addColumnTable:@"ul_rider_details" column:@"Premium2" type:@"VARCHAR" dbpath:path];
    [self addColumnTable:@"ul_rider_details" column:@"Premium3" type:@"VARCHAR" dbpath:path];
    [self addColumnTable:@"ul_fund_maturity_option" column:@"SmartFund" type:@"DOUBLE" dbpath:path];
    [self addColumnTable:@"ul_fund_maturity_option" column:@"VentureFund" type:@"DOUBLE" dbpath:path];
    
    //4.2 VUVentureGrowth,VUVentureBlueChip,VUVentureDana,VUVentureManaged,VUVentureIncome
    [self addColumnTable:@"ul_details" column:@"VUVentureGrowth" type:@"VARCHAR" dbpath:path];
    [self addColumnTable:@"ul_details" column:@"VUVentureBlueChip" type:@"VARCHAR" dbpath:path];
    [self addColumnTable:@"ul_details" column:@"VUVentureDana" type:@"VARCHAR" dbpath:path];
    [self addColumnTable:@"ul_details" column:@"VUVentureManaged" type:@"VARCHAR" dbpath:path];
    [self addColumnTable:@"ul_details" column:@"VUVentureIncome" type:@"VARCHAR" dbpath:path];
    [self addColumnTable:@"ul_details" column:@"VUVentureOptGrowth" type:@"VARCHAR" dbpath:path];
    [self addColumnTable:@"ul_details" column:@"VUVentureOptBlueChip" type:@"VARCHAR" dbpath:path];
    [self addColumnTable:@"ul_details" column:@"VUVentureOptDana" type:@"VARCHAR" dbpath:path];
    [self addColumnTable:@"ul_details" column:@"VUVentureOptManaged" type:@"VARCHAR" dbpath:path];
    [self addColumnTable:@"ul_details" column:@"VUVentureOptIncome" type:@"VARCHAR" dbpath:path];
    
    [self addColumnTable:@"ul_fund_maturity_option" column:@"VentureGrowth" type:@"DOUBLE" dbpath:path];
    [self addColumnTable:@"ul_fund_maturity_option" column:@"VentureBlueChip" type:@"DOUBLE" dbpath:path];
    [self addColumnTable:@"ul_fund_maturity_option" column:@"VentureDana" type:@"DOUBLE" dbpath:path];
    [self addColumnTable:@"ul_fund_maturity_option" column:@"VentureManaged" type:@"DOUBLE" dbpath:path];
    [self addColumnTable:@"ul_fund_maturity_option" column:@"VentureIncome" type:@"DOUBLE" dbpath:path];

    
	[database close];
	
    NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *DBerror;
    BOOL success;
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *TRAD_RatesDatabasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"HLA_Rates.sqlite"]];
    NSString *CommDatabasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Rates.json"]];
    
    [fileManager removeItemAtPath:TRAD_RatesDatabasePath error:Nil];
	
	if([fileManager fileExistsAtPath:TRAD_RatesDatabasePath] == FALSE ){
		NSString *TRADRatesPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"HLA_Rates.sqlite"];
		success = [fileManager copyItemAtPath:TRADRatesPath toPath:TRAD_RatesDatabasePath error:&DBerror];
		if (!success) {
			NSAssert1(0, @"Failed to create UL Rates file with message '%@'.", [DBerror localizedDescription]);
		}
		TRADRatesPath= Nil;
	}
    
    if([fileManager fileExistsAtPath:CommDatabasePath] == FALSE ){
		NSString *RatesFromBundle = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Rates.json"];
		success = [fileManager copyItemAtPath:RatesFromBundle toPath:CommDatabasePath error:&DBerror];
		if (!success) {
			NSAssert1(0, @"Failed to create UL Rates file with message '%@'.", [DBerror localizedDescription]);
		}
        RatesFromBundle= Nil;
	}	
}

+(void)InstallVersion1dot3:(NSString *)path{
	
	[self ClearAllDBData:path]; //to avoid duplicate records
	
	FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
	
	NSString *query;
    
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'UL_Temp_Pages' ('htmlName' TEXT,'PageNum' NUMERIC,'PageDesc' TEXT,'riders' VARCHAR)"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'UL_Temp_Rider' ('SINo' VARCHAR, 'SeqNo' VARCHAR, 'DataType' VARCHAR, 'col0_1' VARCHAR, "
			 "'col0_2' VARCHAR, 'col1' VARCHAR, 'col2' VARCHAR, 'col3' VARCHAR, 'col4' VARCHAR, 'col5' VARCHAR, 'col6' VARCHAR, "
			 "'col7' VARCHAR, 'col8' VARCHAR, 'col9' VARCHAR, 'col10' VARCHAR, 'col11' VARCHAR, 'col12' VARCHAR, 'col13' VARCHAR, 'col14' VARCHAR, 'col15' VARCHAR)"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'UL_Temp_Trad_Basic' ('SINo' VARCHAR, 'SeqNo' INTEGER, 'DataType' VARCHAR, 'col0_1' INTEGER, "
			 "'col0_2' INTEGER, 'col1' VARCHAR, 'col2' VARCHAR, 'col3' VARCHAR, 'col4' VARCHAR, 'col5' VARCHAR, 'col6' "
			 "VARCHAR, 'col7' VARCHAR, 'col8' VARCHAR, 'col9' VARCHAR, 'col10' VARCHAR, 'col11' VARCHAR, 'col12' VARCHAR, "
			 "'col13' VARCHAR, 'col14' VARCHAR, 'col15' VARCHAR, 'col16' VARCHAR, 'col17' VARCHAR, 'col18' VARCHAR, 'col19' VARCHAR, "
			 "'col20' VARCHAR, 'col21' VARCHAR, 'col22' VARCHAR, 'col23' VARCHAR, 'col24' VARCHAR, 'col25' VARCHAR, 'col26' VARCHAR, 'col27' VARCHAR, "
			 "'col28' VARCHAR, 'col29' VARCHAR, 'col30' VARCHAR, 'col31' VARCHAR)"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'UL_Temp_Summary' ('SINo' VARCHAR, 'SeqNo' INTEGER, 'DataType' VARCHAR, 'col0_1' INTEGER, "
			 "'col0_2' INTEGER, 'col1' VARCHAR, 'col2' VARCHAR, 'col3' VARCHAR, 'col4' VARCHAR, 'col5' VARCHAR, 'col6' "
			 "VARCHAR, 'col7' VARCHAR, 'col8' VARCHAR, 'col9' VARCHAR, 'col10' VARCHAR, 'col11' VARCHAR, 'col12' VARCHAR, "
			 "'col13' VARCHAR, 'col14' VARCHAR, 'col15' VARCHAR, 'col16' VARCHAR, 'col17' VARCHAR, 'col18' VARCHAR, 'col19' VARCHAR, "
			 "'col20' VARCHAR, 'col21' VARCHAR, 'col22' VARCHAR, 'col23' VARCHAR, 'col24' VARCHAR, 'col25' VARCHAR, 'col26' VARCHAR, 'col27' VARCHAR, "
			 "'col28' VARCHAR, 'col29' VARCHAR, 'col30' VARCHAR, 'col31' VARCHAR)"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'UL_Temp_Fund' ('SINo' VARCHAR, "
			 "'col1' VARCHAR, 'col2' VARCHAR, 'col3' VARCHAR, 'col4' VARCHAR, 'col5' VARCHAR, 'col6' "
			 "VARCHAR, 'col7' VARCHAR, 'col8' VARCHAR, 'col9' VARCHAR, 'col10' VARCHAR)"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'UL_Temp_Trad_Details' ('SINo' VARCHAR, 'SeqNo' VARCHAR, 'DataType' VARCHAR, 'col0_1' VARCHAR, "
			 "'col0_2' VARCHAR, 'col1' VARCHAR, 'col2' VARCHAR, 'col3' VARCHAR, 'col4' VARCHAR, 'col5' VARCHAR, 'col6' VARCHAR, "
			 "'col7' VARCHAR, 'col8' VARCHAR, 'col9' VARCHAR, 'col10' VARCHAR, 'col11' VARCHAR)"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'UL_Temp_Trad_Overall' ('SINo' VARCHAR,'SurrenderValueHigh1' VARCHAR,'SurrenderValueLow1' VARCHAR, "
			 "'TotPremPaid1' VARCHAR,'TotYearlyIncome1' VARCHAR,'SurrenderValueHigh2' VARCHAR,'SurrenderValueLow2' VARCHAR, "
			 "'TotPremPaid2' VARCHAR,'TotYearlyIncome2' VARCHAR)"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'UL_Temp_Trad_Rider' ('SINo' VARCHAR,'SeqNo' VARCHAR,'DataType' VARCHAR,'PageNo' VARCHAR,'col0_1' "
			 "VARCHAR,'col0_2' VARCHAR,'col1' VARCHAR,'col2' VARCHAR,'col3' VARCHAR,'col4' VARCHAR,'col5' VARCHAR,'col6' VARCHAR,'col7' "
			 "VARCHAR,'col8' VARCHAR,'col9' VARCHAR,'col10' VARCHAR,'col11' VARCHAR,'col12' VARCHAR,'col13' VARCHAR,'col14' VARCHAR)"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'UL_Temp_trad_LA' ('SINo' VARCHAR, 'LADesc' VARCHAR, 'PTypeCode' VARCHAR, 'Seq' VARCHAR, 'Name' VARCHAR, "
			 "'Age' VARCHAR, 'Sex' VARCHAR, 'Smoker' VARCHAR, 'LADescM' VARCHAR)"];
	[database executeUpdate:query];
    
	query = [NSString stringWithFormat:@"CREATE TABLE 'UL_Temp_RPUO' ('SINo' VARCHAR, \"SeqNo\" INTEGER, \"col1\" VARCHAR, "
			 "\"col2\" VARCHAR, \"col3\" VARCHAR, \"col4\" VARCHAR, \"col5\" VARCHAR, \"col6\" VARCHAR, \"col7\" VARCHAR, \"col8\" VARCHAR, \"col9\" VARCHAR, \"col10\" VARCHAR, "
			 "\"col11\" VARCHAR, \"col12\" VARCHAR, \"col13\" VARCHAR, \"col14\" VARCHAR, \"col15\" VARCHAR, \"col16\" VARCHAR, \"col17\" VARCHAR, \"col18\" VARCHAR, \"col19\" VARCHAR, "
			 "\"col20\" VARCHAR, \"col21\" VARCHAR, \"col22\" VARCHAR )"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE 'UL_Temp_ECAR' ('SINo' VARCHAR, \"SeqNo\" INTEGER, \"DataType\" VARCHAR, \"col0_1\" INTEGER, \"col0_2\" INTEGER, \"col1\" VARCHAR, "
			 "\"col2\" VARCHAR, \"col3\" VARCHAR, \"col4\" VARCHAR, \"col5\" VARCHAR, \"col6\" VARCHAR, \"col7\" VARCHAR, \"col8\" VARCHAR, \"col9\" VARCHAR, \"col10\" VARCHAR, "
			 "\"col11\" VARCHAR, \"col12\" VARCHAR, \"col13\" VARCHAR, \"col14\" VARCHAR, \"col15\" VARCHAR, \"col16\" VARCHAR, \"col17\" VARCHAR, \"col18\" VARCHAR, \"col19\" VARCHAR, "
			 "\"col20\" VARCHAR, \"col21\" VARCHAR, \"col22\" VARCHAR )"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE 'UL_Temp_ECAR6' ('SINo' VARCHAR, \"SeqNo\" INTEGER, \"DataType\" VARCHAR, \"col0_1\" INTEGER, \"col0_2\" INTEGER, \"col1\" VARCHAR, "
			 "\"col2\" VARCHAR, \"col3\" VARCHAR, \"col4\" VARCHAR, \"col5\" VARCHAR, \"col6\" VARCHAR, \"col7\" VARCHAR, \"col8\" VARCHAR, \"col9\" VARCHAR, \"col10\" VARCHAR, "
			 "\"col11\" VARCHAR, \"col12\" VARCHAR, \"col13\" VARCHAR, \"col14\" VARCHAR, \"col15\" VARCHAR, \"col16\" VARCHAR, \"col17\" VARCHAR, \"col18\" VARCHAR, \"col19\" VARCHAR, "
			 "\"col20\" VARCHAR, \"col21\" VARCHAR, \"col22\" VARCHAR )"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE 'UL_Temp_ECAR55' ('SINo' VARCHAR, \"SeqNo\" INTEGER, \"DataType\" VARCHAR, \"col0_1\" INTEGER, \"col0_2\" INTEGER, \"col1\" VARCHAR, "
			 "\"col2\" VARCHAR, \"col3\" VARCHAR, \"col4\" VARCHAR, \"col5\" VARCHAR, \"col6\" VARCHAR, \"col7\" VARCHAR, \"col8\" VARCHAR, \"col9\" VARCHAR, \"col10\" VARCHAR, "
			 "\"col11\" VARCHAR, \"col12\" VARCHAR, \"col13\" VARCHAR, \"col14\" VARCHAR, \"col15\" VARCHAR, \"col16\" VARCHAR, \"col17\" VARCHAR, \"col18\" VARCHAR, \"col19\" VARCHAR, "
			 "\"col20\" VARCHAR, \"col21\" VARCHAR, \"col22\" VARCHAR )"];
	[database executeUpdate:query];
	
	
	query = [NSString stringWithFormat:@"CREATE TABLE 'UL_Temp_ECAR60' ('SINo' VARCHAR, \"SeqNo\" INTEGER, \"DataType\" VARCHAR, \"col0_1\" INTEGER, \"col0_2\" INTEGER, \"col1\" VARCHAR, "
			 "\"col2\" VARCHAR, \"col3\" VARCHAR, \"col4\" VARCHAR, \"col5\" VARCHAR, \"col6\" VARCHAR, \"col7\" VARCHAR, \"col8\" VARCHAR, \"col9\" VARCHAR, \"col10\" VARCHAR, "
			 "\"col11\" VARCHAR, \"col12\" VARCHAR, \"col13\" VARCHAR, \"col14\" VARCHAR, \"col15\" VARCHAR, \"col16\" VARCHAR, \"col17\" VARCHAR, \"col18\" VARCHAR, \"col19\" VARCHAR, "
			 "\"col20\" VARCHAR, \"col21\" VARCHAR, \"col22\" VARCHAR )"];
	[database executeUpdate:query];
    
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_Details (\"SINO\" VARCHAR, \"PlanCode\" VARCHAR, \"CovTypeCode\" INTEGER, \"ATPrem\" "
			 "DOUBLE, \"BasicSA\" DOUBLE, \"CovPeriod\" INTEGER, \"OccpCode\" VARCHAR, \"OccLoading\" DOUBLE, \"CPA\" INTEGER, "
			 "\"PA\" INTEGER, \"HLoading\" DOUBLE, \"HloadingTerm\" INTEGER, \"HloadingPct\" VARCHAR, \"HloadingPctTerm\" VARCHAR "
			 ", \"MedicalReq\" VARCHAR, \"ComDate\" VARCHAR, \"HLGES\" VARCHAR, \"ATU\" VARCHAR, \"BUMPMode\" VARCHAR "
			 ", \"InvCode\" VARCHAR, \"InvHorizon\" VARCHAR, \"RiderRTU\" VARCHAR, \"RiderRTUTerm\" VARCHAR, \"PolicySustainYear\" VARCHAR"
			 ", \"Package\" VARCHAR, \"TotATPrem\" VARCHAR, \"TotUpPrem\" VARCHAR, \"VU2023\" VARCHAR, \"VU2023To\" VARCHAR"
			 ", \"VU2025\" VARCHAR, \"VU2025To\" VARCHAR, \"VU2028\" VARCHAR, \"VU2028To\" VARCHAR, \"VU2030\" VARCHAR"
			 ", \"VU2030To\" VARCHAR, \"VU2035\" VARCHAR, \"VU2035To\" VARCHAR, \"VUCash\" VARCHAR, \"VUCashTo\" VARCHAR"
			 ", \"ReinvestYI\" VARCHAR, \"FullyPaidUp6Year\" VARCHAR, \"FullyPaidUp10Year\" VARCHAR, \"ReduceBSA\" VARCHAR"
			 ", \"SpecialVersion\" VARCHAR, \"VURet\" VARCHAR, \"VURetTo\" VARCHAR, \"VURetOpt\" VARCHAR, \"VURetToOpt\" VARCHAR"
			 ", \"VUDana\" VARCHAR, \"VUDanaTo\" VARCHAR, \"VUDanaOpt\" VARCHAR, \"VUDanaToOpt\" VARCHAR "
             ", \"VUSmart\" VARCHAR, \"VUSmartTo\" VARCHAR, \"VUSmartOpt\" VARCHAR, \"VUSmartToOpt\" VARCHAR "
             ", \"VUVenture\" VARCHAR, \"VUVentureTo\" VARCHAR, \"VUVentureOpt\" VARCHAR, \"VUVentureToOpt\" VARCHAR "
			 ", \"VUCashOpt\" VARCHAR, \"VUCashToOpt\" VARCHAR, \"SIVersion\" VARCHAR, \"SIStatus\" VARCHAR, \"QuotationLang\" VARCHAR,  \"DateCreated\" DATETIME, "
			 "\"CreatedBy\" VARCHAR, \"DateModified\" DATETIME, \"ModifiedBy\" VARCHAR)"];
	
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_LAPayor (\"SINO\" VARCHAR, \"CustCode\"	VARCHAR, \"PTypeCode\" "
			 "VARCHAR, \"Seq\" INTEGER, \"DateCreated\" DATETIME, \"CreatedBy\" VARCHAR, \"DateModified\" DATETIME, \"ModifiedBy\" VARCHAR) "];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_ReducedPaidUp (\"SINO\" VARCHAR, \"ReducedYear\" INTEGER, \"Amount\" "
			 "DOUBLE) "];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_RegTopUp (\"SINO\" VARCHAR, \"FromYear\" VARCHAR, \"ToYear\" "
			 "VARCHAR, \"Amount\" DOUBLE)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_Rider_Details (\"SINO\" VARCHAR, \"RiderCode\" VARCHAR, \"PTypeCode\" "
			 "VARCHAR, \"Seq\" INTEGER, \"RiderTerm\" INTEGER, \"SumAssured\" DOUBLE, \"Units\" INTEGER, \"PlanOption\" VARCHAR, "
			 "\"HLoading\" DOUBLE, \"HLoadingTerm\" INTEGER, \"HLoadingPCt\" INTEGER, \"HLoadingPCtTerm\" INTEGER, \"Premium\" DOUBLE, "
			 "\"Deductible\" VARCHAR, \"PaymentTerm\" INTEGER, \"ReinvestGYI\" VARCHAR, \"GYIYear\" INTEGER, \"RRTUOFromYear\" INTEGER, "
			 "\"RRTUOYear\" INTEGER, \"RiderDesc\" VARCHAR, \"RiderLoadingPremium\" VARCHAR, \"PaymentChoice\" VARCHAR) "];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_TopupPrem (\"SINO\" VARCHAR, \"PolYear\" INTEGER, \"Amount\" "
			 "DOUBLE) "];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_TPExcess (\"SINO\" VARCHAR, \"FromYear\" INTEGER, \"YearInt\" INTEGER, \"Amount\" "
			 "DOUBLE, \"ForYear\" INTEGER) "];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_TPIncrease (\"SINO\" VARCHAR, \"FromYear\" INTEGER, \"YearInt\" INTEGER, \"Amount\" "
			 "DOUBLE) "];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_Fund_Maturity_Option (\"SINO\" VARCHAR, \"Fund\" VARCHAR, \"Option\" VARCHAR, "
			 "\"Partial_withd_Pct\" DOUBLE, \"EverGreen2025\" DOUBLE, \"EverGreen2028\" DOUBLE, \"EverGreen2030\" DOUBLE, "
			 "\"EverGreen2035\" DOUBLE, \"CashFund\" DOUBLE, \"RetireFund\" DOUBLE, \"DanaFund\" DOUBLE, \"SmartFund\" DOUBLE, \"VentureFund\" DOUBLE ) "];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_Rider_mtn (\"RiderCode\" VARCHAR, \"isEDD\" INTEGER, \"MinAge\" INTEGER, "
			 "\"MaxAge\" INTEGER, \"ExpiryAge\" INTEGER, \"MinSA\" DOUBLE, \"MaxSA\" DOUBLE, "
			 "\"MinTerm\" INTEGER, \"MaxTerm\" INTEGER, \"PlanCode\" VARCHAR, \"PTypeCode\" VARCHAR, \"Seq\" INTEGER)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_Rider_Profile ('RiderCode' VARCHAR, 'RiderDesc' VARCHAR, 'LifePlan' INTEGER, "
			 "'Status' INTEGER)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_Rider_Label (\"LabelCode\" VARCHAR, \"LabelDesc\" VARCHAR, \"RiderCode\" VARCHAR, "
			 "\"RiderName\" VARCHAR, \"InputCode\" VARCHAR, \"TableName\" VARCHAR, \"FieldName\" VARCHAR, \"Condition\" VARCHAR, "
			 "\"DateCreated\" DATETIME, \"CreatedBy\" VARCHAR, \"DateModified\" DATETIME, \"ModifiedBy\" VARCHAR)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_RegWithdrawal('SINO' VARCHAR, 'FromAge' VARCHAR, 'ToAge' INTEGER, "
			 "'YearInt' INTEGER, 'Amount' VARCHAR )"];
    [database executeUpdate:query];
	/*
     query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_RiderComb('PlanCode' VARCHAR, 'PTypeCode' VARCHAR, 'Seq' INTEGER, 'RiderCode' VARCHAR )"];
     [database executeUpdate:query];
     */
	//
	
	query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Profile ('PlanCode', 'PlanName') VALUES(\"UV\", 'HLA EverLife Plus')"];
    [database executeUpdate:query];
    
	query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Profile ('PlanCode', 'PlanName') VALUES(\"UP\", 'HLA EverGain Plus')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"ACIR\", 0, 0, 65, -100, 10000, 4000000, 10, 100, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"ACIR\", 0, 0, 65, -100, 10000, 4000000, 10, 100, \"UP\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"CIRD\", 0, 30, 55, 65, 20000, 100000, 10 , 10, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"CIRD\", 0, 30, 55, 65, 20000, 100000, 10 , 10, \"UP\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"CIWP\", 0, 0, 70, -80, 0.00, 0.00, 3 , 25, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"CIWP\", 0, 0, 70, -80, 0.00, 0.00, 3 , 25, \"UP\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"DCA\", 0, 0, 70, -75, 10000, 0.00, 5 , 75, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"DCA\", 0, 0, 70, -75, 10000, 0.00, 5 , 75, \"UP\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"DHI\", 0, 0, 70, -75, 50, 0.00, 5 , 75, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"DHI\", 0, 0, 70, -75, 50, 0.00, 5 , 75, \"UP\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"ECAR\", 0, 0, 65, 80, 600, 0.00, 20 , 25, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"ECAR\", 0, 0, 65, 80, 600, 0.00, 20 , 25, \"UP\", \"LA\", 1 )"];
    [database executeUpdate:query];
	    
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"ECAR60\", 0, 16, 55, -100, 50.00, 0.00, 0 , 100, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"ECAR6\", 0, 0, 65, 80, 600, 0.00, 20 , 25, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
	    
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"LCWP\", 0, 16, 65, 80, 0.00, 0.00, 3 , 25, \"UV\", \"PY\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"LCWP\", 0, 16, 65, 80, 0.00, 0.00, 3 , 25, \"UV\", \"LA\", 2 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"LSR\", 0, 0, 70, -100, 20000, 0.00, 0 , 100, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"MR\", 0, 0, 70, 75, 1000, 5000, 5, 75, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"MR\", 0, 0, 70, 75, 1000, 5000, 5, 75, \"UP\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"PA\", 0, 0, 70, 75, 10000, 0.00, 5 , 75, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];

	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"PR\", 0, 16, 65, 80, 0.00, 0.00, 3 , 25, \"UV\", \"PY\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"PR\", 0, 16, 65, 80, 0.00, 0.00, 3 , 25, \"UV\", \"LA\", 2 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"RRTUO\", 0, 0, 100, 100, 1.00, 10000, 1 , 100, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"RRTUO\", 0, 0, 100, 100, 1.00, 10000, 1 , 100, \"UP\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"MCFR\", 0, 0, 100, 100, 1.00, 10000, 0 , 100, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"MCFR\", 0, 0, 100, 100, 1.00, 10000, 0 , 100, \"UP\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"TPDMLA\", 0, 0, 70, 75, 500, 10000, 5 , 75, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"TPDMLA\", 0, 0, 70, 75, 500, 10000, 5 , 75, \"UP\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"TPDWP\", 0, 0, 65, 80, 0.00, 0.00, 3 , 80, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"WI\", 0, 20, 65, 70, 100, 8000, 5 , 70, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"WI\", 0, 20, 65, 70, 100, 8000, 5 , 70, \"UP\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"TSR\", 0, 0, 70, 80, 20000, 100000000, 1 , 75, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"TSER\", 0, 0, 55, 80, 20000, 100000000, 1 , 79, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"ECAR6\", 0, 0, 65, 80, 600, 0.00, 20 , 25, \"UP\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"PR\", 0, 16, 65, 80, 0.00, 0.00, 3 , 25, \"UP\", \"PY\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"PR\", 0, 16, 65, 80, 0.00, 0.00, 3 , 25, \"UP\", \"LA\", 2 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"LCWP\", 0, 0, 100, 80, 1.00, 10000, 1 , 100, \"UP\", \"PY\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"LCWP\", 0, 0, 100, 80, 1.00, 10000, 1 , 100, \"UP\", \"LA\", 2 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"TPDWP\", 0, 0, 65, 80, 0.00, 0.00, 3 , 80, \"UP\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"TSR\", 0, 0, 70, 80, 20000, 100000000, 1 , 75, \"UP\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"TPDYLA\", 0, 0, 63, 65, 5000, 2000000, 2 , 65, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"TPDYLA\", 0, 0, 63, 65, 5000, 2000000, 2 , 65, \"UP\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"MDSR1\", 0, 0, 70, 100, 0.00, 0.00, 1 , 100, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"MDSR1\", 0, 0, 70, 100, 0.00, 0.00, 1 , 100, \"UP\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"MDSR2\", 0, 0, 70, 100, 0.00, 0.00, 1 , 100, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"MDSR2\", 0, 0, 70, 100, 0.00, 0.00, 1 , 100, \"UP\", \"LA\", 1 )"];
    [database executeUpdate:query];

    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"LDYR\", 0, 16, 60, 100, 20000, 300000, 1 , 100, \"UP\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"LDYR\", 0, 16, 60, 100, 20000, 300000, 1 , 100, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"MSR\", 0, 16, 60, 100, 20000, 300000, 1 , 100, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"MSR\", 0, 16, 60, 100, 20000, 300000, 1 , 100, \"UP\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"LSER\", 0, 0, 70, 100, 20000, 10000000, 1 , 100, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];

    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"CCR\", 0, 0, 70, 100, 10000, 1500000, 1 , 100, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"TCCR\", 0, 0, 70, 100, 10000, 1500000, 1 , 100, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"JCCR\", 0, 0, 10, 100, 10000, 1500000, 1 , 100, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"CCR\", 0, 0, 70, 100, 10000, 1500000, 1 , 100, \"UP\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"TCCR\", 0, 0, 70, 100, 10000, 1500000, 1 , 100, \"UP\", \"LA\", 1 )"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"JCCR\", 0, 0, 10, 100, 10000, 1500000, 1 , 100, \"UP\", \"LA\", 1 )"];
    [database executeUpdate:query];
    	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES('ACIR', 'Accelerated Critical Illness Rider', 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES('CIRD', 'Diabetes Wellness Care Rider', 0 , 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES('CIWP', 'Critical Illness Waiver of Premium Rider', 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES('DCA', 'Acc. Death & Compassionate Allowance Rider', 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"DHI\", \"Acc. Daily Hospitalisation Income Rider\", 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"ECAR\", \"EverCash 1 Rider\", 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"ECAR6\", \"EverCash Rider\", 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"ECAR55\", \"EverCash 55 Rider\", 0, 0)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"ECAR60\", \"EverCash 60 Rider\", 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES('LCWP', 'Living Care Waiver of Premium Rider', 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"LSR\", \"LifeShield Rider\", 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"MR\", \"Acc. Medical Reimbursement Rider\", 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES('PA', 'Personal Accident Rider', 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES('PR', 'Waiver of Premium Rider', 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"RRTUO\", \"Rider Regular Top Up Option\", 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"TPDMLA\", \"Acc. TPD Monthly Living Allowance Rider\", 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"TPDWP\", \"TPD Waiver of Premium Rider\", 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"WI\", \"Acc. Weekly Indemnity Rider\", 0, 1)"];
    [database executeUpdate:query];
	
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"TSR\", \"TermShield Rider \", 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"TSER\", \"TermShield Extra Rider\", 0, 1)"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"TPDYLA\", \"TPD Yearly Living Allowance Rider\", 0, 1)"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"MDSR1\", \"HLA MediShield Rider (1st Rider)\", 0, 1)"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"MDSR1-ALW\", \"HLA MediShield Rider 1 Annual Limit Waiver\", 0, 1)"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"MDSR1-OT\", \"HLA MediShield Rider 1 Oversea Treatment for selected surgery\", 0, 1)"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"MDSR2\", \"HLA MediShield Rider (2nd Rider)\", 0, 1)"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"MDSR2-ALW\", \"HLA MediShield Rider 2 Annual Limit Waiver\", 0, 1)"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"MDSR2-OT\", \"HLA MediShield Rider 2 Oversea Treatment for selected surgery\", 0, 1)"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"MCFR\", \"MediCare Funding Rider\", 0, 1)"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"LDYR\", \"LadyShield Rider\", 0, 1)"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"LDYR-PCB\", \"LadyShield Rider Pregnancy Care Benefit\", 0, 1)"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"LDYR-BBB\", \"LadyShield Rider Baby Bonus Benefit\", 0, 1)"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"MSR\", \"MenShield Rider\", 0, 1)"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"TCCR\", \"Total CI Care Rider\", 0, 1)"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"JCCR\", \"Junior CI Care Rider\", 0, 1)"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"CCR\", \"CI Care Rider\", 0, 1)"];
    [database executeUpdate:query];
    
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"ACIR\", \"Accelerated Critical Illness Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"ACIR\", \"Accelerated Critical Illness Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"ACIR\", \"Accelerated Critical Illness Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"ACIR\", \"Accelerated Critical Illness Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"CIRD\", \"Diabetes Wellness Care Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"CIRD\", \"Diabetes Wellness Care Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
	[database executeUpdate:query];
    
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"CIRD\", \"Diabetes Wellness Care Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"CIWP\", \"Critical Illness Waiver of Premium Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"CIWP\", \"Critical Illness Waiver of Premium Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"DCA\", \"Acc. Death & Compassionate Allowance Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"DCA\", \"Acc. Death & Compassionate Allowance Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"PAYT\", \"Payment Term\", \"DCA\", \"Acc. Death & Compassionate Allowance Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"DCA\", \"Acc. Death & Compassionate Allowance Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"DCA\", \"Acc. Death & Compassionate Allowance Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"DHI\", \"Acc. Daily Hospitalisation Income Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"DHI\", \"Acc. Daily Hospitalisation Income Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"PAYT\", \"Payment Term\", \"DHI\", \"Acc. Daily Hospitalisation Income Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"DHI\", \"Acc. Daily Hospitalisation Income Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"DHI\", \"Acc. Daily Hospitalisation Income Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"ECAR\", \"EverCash 1 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"YINC\", \"Yearly Income\", \"ECAR\", \"EverCash 1 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"PAYT\", \"Payment Term\", \"ECAR\", \"EverCash 1 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"REYI\", \"Reinvestment of Yearly Income\", \"ECAR\", \"EverCash 1 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"ECAR\", \"EverCash 1 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"ECAR6\", \"EverCash 6 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"YINC\", \"Yearly Income\", \"ECAR6\", \"EverCash 6 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"PAYT\", \"Payment Term\", \"ECAR6\", \"EverCash 6 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"REYI\", \"Reinvestment of Yearly Income\", \"ECAR6\", \"EverCash 6 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"ECAR6\", \"EverCash 6 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"TSR\", \"TermShield Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"TSR\", \"TermShield Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"TSR\", \"TermShield Extra Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];

    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"TSER\", \"TermShield Extra Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"TSER\", \"TermShield Extra Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
        
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"MINC\", \"Monthly Income\", \"ECAR60\", \"EverCash 60 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"PAYT\", \"Payment Term\", \"ECAR60\", \"EverCash 60 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"REMI\", \"Reinvestment of Month Income\", \"ECAR60\", \"EverCash 60 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"ECAR60\", \"EverCash 60 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"LCWP\", \"Living CAre Waiver of Premium Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"LCWP\", \"Living Care Waiver of Premium Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"LSR\", \"LifeShield Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"LSR\", \"LifeShield Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"MR\", \"Acc. Medical Reimbursement Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"MR\", \"Acc. Medical Reimbursement Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"MR\", \"Acc. Medical Reimbursement Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"MR\", \"Acc. Medical Reimbursement Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"PA\", \"Personal Accident Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"PA\", \"Personal Accident Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"PA\", \"Personal Accident Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"PA\", \"Personal Accident Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"PR\", \"Waiver of Premium Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"PR\", \"Waiver of Premium Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"CFPA\", \"Commencing From (pol. anniversary)\", \"RRTUO\", \"Rider Regular Top Up Option\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"FORY\", \"for(year)\", \"RRTUO\", \"Rider Regular Top Up Option\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"PREM\", \"Premium\", \"RRTUO\", \"Rider Regular Top Up Option\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];	
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"TPDMLA\", \"Acc. TPD Monthly Living Allowance Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"TPDMLA\", \"Acc. TPD Monthly Living Allowance Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"TPDMLA\", \"Acc. TPD Monthly Living Allowance Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"TPDMLA\", \"Acc. TPD Monthly Living Allowance Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"TPDWP\", \"TPD Waiver of Premium Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"TPDWP\", \"TPD Waiver of Premium Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"WI\", \"Acc. Weekly Indemnity Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"WI\", \"Acc. Weekly Indemnity Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"WI\", \"Acc. Weekly Indemnity Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"WI\", \"Acc. Weekly Indemnity Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"TPDYLA\", \"TPD Yearly Living Allowance Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"TPDYLA\", \"TPD Yearly Living Allowance Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"TPDYLA\", \"TPD Yearly Living Allowance Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"TPDYLA\", \"TPD Yearly Living Allowance Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"CCR\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"CCR\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"CCR\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"CCR\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"TCCR\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"TCCR\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"TCCR\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"TCCR\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"JCCR\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"JCCR\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"JCCR\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"JCCR\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
        
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"LDYR\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"LDYR\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"LDYR\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"PCB\", \"Pregnancy Care Benefit\", \"LDYR\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"BBB\", \"Baby Bonus Benefit\", \"LDYR\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"MSR\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"MSR\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"MSR\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];

    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"PLCH\", \"Plan Choice\", \"MDSR1\", \"\", \"DD\", "
			 "\"\", \"\", \"PlanChoiceMDSR1\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"DEDUC\", \"Deductible\", \"MDSR1\", \"\", \"DD\", "
			 "\"\", \"\", \"DeductibleMDSR1\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"POST\", \"Post-retirement\", \"MDSR1\", \"\", \"DD\", "
			 "\"\", \"\", \"DeductibleMDSR1\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"MDSR1\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"ALW\", \"Annual Limit Waiver\", \"MDSR1\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"OT\", \"Oversea Treatment for selected surgery\", \"MDSR1\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"PLCH\", \"Plan Choice\", \"MDSR2\", \"\", \"DD\", "
			 "\"\", \"\", \"PlanChoiceMDSR2\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"DEDUC\", \"Deductible\", \"MDSR2\", \"\", \"DD\", "
			 "\"\", \"\", \"DeductibleMDSR2\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"POST\", \"Post-retirement\", \"MDSR2\", \"\", \"DD\", "
			 "\"\", \"\", \"DeductibleMDSR2\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"MDSR2\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"ALW\", \"Annual Limit Waiver\", \"MDSR2\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
    query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"OT\", \"Oversea Treatment for selected surgery\", \"MDSR2\", \"\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"CFPA\", \"Commencing From (pol. anniversary)\", \"MCFR\", \"MediCare Funding Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"FORY\", \"for(year)\", \"MCFR\", \"MediCare Funding Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"PREM\", \"Premium\", \"MCFR\", \"MediCare Funding Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
    
	[database close];
    
}

+(void)runQuery:(NSString *)path withQuery:(NSString *)query {
    
	FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    [database executeUpdate:query];
    
    [database close];
}


+(NSString *)WSLogin{
	
     return @"http://echannel.dev/";
//		return @"http://www.hla.com.my:2880/";
}

@end
