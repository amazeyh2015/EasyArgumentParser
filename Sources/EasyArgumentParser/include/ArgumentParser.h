//
//  ArgumentParser.h
//  
//
//  Created by yuhan on 2024/6/19.
//

#import <Foundation/Foundation.h>
#import "ArgumentParseResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArgumentParser : NSObject

- (ArgumentParseResult *)parse:(NSArray<NSString *> *)words;

@end

NS_ASSUME_NONNULL_END
