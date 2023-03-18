//
//  ParsingResult.m
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 18/03/2023.
//

#import <Foundation/Foundation.h>
#import "ParsingResult.h"

@interface ParsingResult()
@property(readwrite) ParsingResultCode code;
@property(readwrite) NSArray<Frame> *frames;
@end

@implementation ParsingResult

- (nonnull instancetype)initWithCode:(ParsingResultCode)code frames:(nonnull NSArray<Frame> *)frames {
    self = [super init];
    if (self != nil) {
        self.code = code;
        self.frames = frames;
    }
    return self;
}

@end

