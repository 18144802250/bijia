//
//  NSString+WREncode.h
//  比价
//
//  Created by apple-jd28 on 15/11/11.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WREncode)

- (NSString *)encodeToPercentEscapeString:(NSString*)input;;

- (NSString *)decodeFromPercentEscapeString:(NSString*)input;

@end
