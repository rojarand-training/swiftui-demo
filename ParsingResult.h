//
//  ParsingResult.h
//  SwiftUITipsAndTricks
//
//  Created by Robert Andrzejczyk on 18/03/2023.
//

#ifndef ParsingResult_h
#define ParsingResult_h

#import "SensorAdvertisementFrame.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ParsingResultCode) {
    Success = 0,
    BadCRC,
    FrameTooShort,
    FrameNotFound
};

@interface ParsingResult: NSObject
@property(nonatomic, readonly) ParsingResultCode code;
@property(nonatomic, readonly) NSArray<Frame> *frames;
-(instancetype) initWithCode:(ParsingResultCode)code frames:(NSArray<Frame> *)frames;
@end

NS_ASSUME_NONNULL_END

#endif /* ParsingResult_h */
