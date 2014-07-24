//
//  RSSFeed.h
//  RecipeApp
//
//  Created by Emilien Sanchez on 30/06/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSFeed : NSObject

@property (assign) NSDate *Date;
@property (retain, nonatomic) NSString *Content;
@property (retain, nonatomic) NSString *Source;
@property (retain, nonatomic) NSString *Title;
@property (retain, nonatomic) NSString *URL;

@end
