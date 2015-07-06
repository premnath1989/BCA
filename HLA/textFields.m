//
//  textFields.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/25/14.
//  Copyright (c) 2014 InfoConnect Sdn Bhd. All rights reserved.
//

#import "textFields.h"
#import "MBProgressHUD.h"

@implementation textFields

+ (BOOL)validateString:(NSString *)string
{
    NSError *error = nil;
	NSString *pattern = @"[a]{4}|[b]{4}|[c]{4}|[d]{4}|[e]{4}|[f]{4}|[g]{4}|[h]{4}|[i]{4}|[j]{4}|[k]{4}|[l]{4}|[m]{4}|[n]{4}|[o]{4}|[p]{4}|[q]{4}|[r]{4}|[s]{4}|[t]{4}|[u]{4}|[v]{4}|[w]{4}|[x]{4}|[y]{4}|[z]{4}";
	//	NSString *pattern = @"[]{3}";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
	
    NSAssert(regex, @"Unable to create regular expression");
	//	NSLog(@"string: %@", string);
    NSRange textRange = NSMakeRange(0, string.length);
    NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
	
    BOOL didValidate = NO;
	
    // Did we find a matching range
    if (matchRange.location != NSNotFound)
        didValidate = YES;
	
    return didValidate;
}

+ (BOOL)validateString2:(NSString *)string
{
    NSError *error = nil;
	NSString *pattern = @"[0-9]|[!]|[,]|[#]|[$]|[%]|[&]|[?]|[_]|[<]|[>]|[+]|[=]|[:]|[;]|[*]";
	//	NSString *pattern = @"[]{4}";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
	
    NSAssert(regex, @"Unable to create regular expression");
	//	NSLog(@"string: %@", string);
    NSRange textRange = NSMakeRange(0, string.length);
    NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
	
    BOOL didValidate = NO;
	
    // Did we find a matching range
    if (matchRange.location != NSNotFound)
        didValidate = YES;
	
    return didValidate;
}

+ (BOOL)validateString3:(NSString *)string {
    NSError *error = nil;
	//NSString *pattern = @"^[A-Za-z]+[@|-|'|/| |.|)|(]?[A-Za-z]?";
    NSString *pattern;
    pattern = @"[A-Za-z]+";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSRange textRange = NSMakeRange(0, string.length);
    NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
    if (matchRange.location == NSNotFound) {
        return YES;
    }
    
    pattern = @"^\\D+$";
    regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    textRange = NSMakeRange(0, string.length);
    matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
    if (matchRange.location == NSNotFound) {
        return YES;
    }
    
    pattern = @"^[^&?<>!\\*\\^]+$";
    regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    textRange = NSMakeRange(0, string.length);
    matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
    if (matchRange.location == NSNotFound) {
        return YES;
    }
    
    if ([string rangeOfString:@"("].location != NSNotFound || [string rangeOfString:@")"].location != NSNotFound) {
        pattern = @"(\\([^\\(\\)]+\\))";
        regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
        textRange = NSMakeRange(0, string.length);
        matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
        if (matchRange.location == NSNotFound) {
            return YES;
        }
    }
    
    
    pattern = nil;
    pattern = @"^([A-Za-z ]*(\\(([A-Za-z ]+[@|\\-|'|/|\\.| |]*)*\\))*([@|\\-|'|/| |.| |])*)*$";
    regex = nil;
    regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
	
    NSAssert(regex, @"Unable to create regular expression");
    textRange = NSMakeRange(0, string.length);
    matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
	
    BOOL didValidate = NO;
	
    // Did we find a matching range
    if (matchRange.location == NSNotFound)
        didValidate = YES;
    
    if (!didValidate && string.length > 1) {
        pattern = nil;
        pattern = @"[A-Za-z]";
        regex = nil;
        regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
        regex = nil;
        textRange = NSMakeRange(0, string.length);
        matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
        
        didValidate = NO;
        
        if (matchRange.location == NSNotFound)
            didValidate = YES;
    }
	
    return didValidate;
}

+ (BOOL)validateString3withView:(NSString *)string view:(UIView *)view {
    [MBProgressHUD showHUDAddedTo:view animated:YES];
    NSError *error = nil;
	//NSString *pattern = @"^[A-Za-z]+[@|-|'|/| |.|)|(]?[A-Za-z]?";
    NSString *pattern;
    pattern = @"^\\D+$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSRange textRange = NSMakeRange(0, string.length);
    NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
    if (matchRange.location == NSNotFound) {
        return YES;
    }
    
    pattern = @"^[^&?<>!/*\\^]+$";
    regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    textRange = NSMakeRange(0, string.length);
    matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
    if (matchRange.location == NSNotFound) {
        [MBProgressHUD hideAllHUDsForView:view animated:YES];
        return YES;
    }
    
    if ([string rangeOfString:@"("].location != NSNotFound || [string rangeOfString:@")"].location != NSNotFound) {
        pattern = @"(\\([^\\(\\)]+\\))";
        regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
        textRange = NSMakeRange(0, string.length);
        matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
        if (matchRange.location == NSNotFound) {
            [MBProgressHUD hideAllHUDsForView:view animated:YES];
            return YES;
        }
    }
    
    
    pattern = nil;
    pattern = @"^([A-Za-z ]*(\\(([A-Za-z ]+[@|\\-|'|/|\\.| |]*)*\\))*([@|\\-|'|/| |.| |])*)*$";
    regex = nil;
    regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
	
    NSAssert(regex, @"Unable to create regular expression");
    textRange = NSMakeRange(0, string.length);
    matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
	
    BOOL didValidate = NO;
	
    // Did we find a matching range
    if (matchRange.location == NSNotFound)
        didValidate = YES;
    
    if (!didValidate && string.length > 1) {
        pattern = nil;
        pattern = @"[A-Za-z]";
        regex = nil;
        regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
        regex = nil;
        textRange = NSMakeRange(0, string.length);
        matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
        
        didValidate = NO;
        
        if (matchRange.location == NSNotFound)
            didValidate = YES;
    }
	
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
    return didValidate;
}


//+ (BOOL)validateOtherID:(NSString *)string {
//    NSError *error = nil;
//	//NSString *pattern = @"^[A-Za-z]+[@|-|'|/| |.|)|(]?[A-Za-z]?";
//    NSString *pattern;
//    pattern = @"[A-Za-z]|[0-9]";
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
//    NSRange textRange = NSMakeRange(0, string.length);
//    NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
//    if (matchRange.location == NSNotFound) {
//        return YES;
//    }
//    
//    pattern = nil;
//    pattern = @"^([A-Za-z ]*[0-9]*(\\([A-Za-z ]+\\))*(\\([0-9 ]+\\))*([@|\\-|'|/| |.| |]|&|#|@ |(|) )*)";
//    regex = nil;
//    regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
//	
//    NSAssert(regex, @"Unable to create regular expression");
//    textRange = NSMakeRange(0, string.length);
//    matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
//	 
//    BOOL didValidate = NO;
//	
//    // Did we find a matching range
//    if (matchRange.location == NSNotFound)
//        didValidate = YES;
//    
//    
//    return didValidate;
//}

+ (BOOL)validateOtherID:(NSString *)string {
    NSError *error = nil;
	//NSString *pattern = @"^[A-Za-z]+[@|-|'|/| |.|)|(]?[A-Za-z]?";
    NSString *pattern;
    //    pattern = @"[A-Za-z]+";
    //    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    //    NSRange textRange = NSMakeRange(0, string.length);
    //    NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
    //    if (matchRange.location == NSNotFound) {
    //        return YES;
    //    }
    
    //    pattern = @"^\\D+$";
    //    regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    //    textRange = NSMakeRange(0, string.length);
    //    matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
    //    if (matchRange.location == NSNotFound) {
    //        return YES;
    //    }
    
    pattern = @"^[^&?<>!\\*\\^]+$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSRange textRange = NSMakeRange(0, string.length);
    NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
    if (matchRange.location == NSNotFound) {
        return YES;
    }
    
    if ([string rangeOfString:@"("].location != NSNotFound || [string rangeOfString:@")"].location != NSNotFound) {
        pattern = @"(\\([^\\(\\)]+\\))";
        NSRegularExpression *regex  = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
        NSRange textRange = NSMakeRange(0, string.length);
        NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
        if (matchRange.location == NSNotFound) {
            return YES;
        }
    }
    
    
    pattern = @"[A-Za-z]|[0-9]";
    regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    textRange = NSMakeRange(0, string.length);
    matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
    if (matchRange.location == NSNotFound) {
        return YES;
    }
    
    pattern = nil;
    pattern = @"^([A-Za-z ]*[0-9]*(\\([A-Za-z ]+\\))*(\\([0-9 ]+\\))*([@|\\-|'|/| |.| |]|&|#|@ |(|) )*)";
    regex = nil;
    regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
	
    NSAssert(regex, @"Unable to create regular expression");
    textRange = NSMakeRange(0, string.length);
    matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
    
    BOOL didValidate = NO;
	
    // Did we find a matching range
    if (matchRange.location == NSNotFound)
        didValidate = YES;
    
    
    return didValidate;
}
+ (NSString *)trimWhiteSpaces:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

+(BOOL)validateEmail:(NSString *)string {
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:string];
}
@end
