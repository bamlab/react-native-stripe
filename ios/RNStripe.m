#import "RNStripe.h"

@implementation RNStripe
{
    NSString *publishableKey;
    NSString *merchantId;

    BOOL requestIsCompleted;
}

- (instancetype)init {
  if ((self = [super init])) {
    requestIsCompleted = YES;
  }
  return self;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(init:(NSDictionary *)options) {
    publishableKey = options[@"publishableKey"];
    merchantId = options[@"merchantId"];
    [[STPPaymentConfiguration sharedConfiguration] setPublishableKey:options[@"publishableKey"]];
    [Stripe setDefaultPublishableKey:options[@"publishableKey"]];
}

RCT_EXPORT_METHOD(createTokenWithCard:(NSDictionary *)params
                             resolver:(RCTPromiseResolveBlock)resolve
                             rejecter:(RCTPromiseRejectBlock)reject) {
    if(!requestIsCompleted) {
        NSError *error = [NSError
          errorWithDomain:@"com.reactlibrary.RNStripe"
          code:-2
          userInfo:@{NSLocalizedDescriptionKey: @"Previous request is not completed"}
        ];
        reject([NSString stringWithFormat:@"%ld", error.code], error.localizedDescription, error);
        return;
    }

    requestIsCompleted = NO;
    STPCardParams* card = [self createCardParamFromDictionary:params];

    STPAPIClient *stripeAPIClient = [self createAPIClient];

    [stripeAPIClient createTokenWithCard:card completion:^(STPToken *token, NSError *error) {
        requestIsCompleted = YES;

        if (error) {
            reject(nil, nil, error);
        } else {
            resolve([self convertTokenObject:token]);
        }
    }];
}

- (STPAPIClient *)createAPIClient {
    return [[STPAPIClient alloc] initWithPublishableKey:[Stripe defaultPublishableKey]];
}

- (STPCardParams *)createAddressFromDictionary:(NSDictionary *)params {
    STPAddress *address = [[STPAddress alloc] init];

    [address setName: params[@"name"]];
    [address setLine1: params[@"line1"]];
    [address setLine2: params[@"line2"]];
    [address setCity: params[@"city"]];
    [address setState: params[@"state"]];
    [address setCountry: params[@"country"]];
    [address setPhone: params[@"phone"]];
    [address setEmail: params[@"email"]];
    [address setPostalCode: params[@"postalCode"]];

    return address;
}

- (STPCardParams *)createCardParamFromDictionary:(NSDictionary *)params {
    STPCardParams *card = [[STPCardParams alloc] init];

    [card setNumber: params[@"number"]];
    [card setExpMonth: [params[@"expMonth"] integerValue]];
    [card setExpYear: [params[@"expYear"] integerValue]];
    [card setCvc: params[@"cvc"]];

    [card setName: params[@"name"]];
    [card setCurrency: params[@"currency"]];
    [card setAddress: [self createAddressFromDictionary:params[@"address"]]];

    return card;
}

- (NSDictionary *)convertTokenObject:(STPToken*)token {
    NSMutableDictionary *result = [@{} mutableCopy];

    // Token
    [result setValue:token.tokenId forKey:@"tokenId"];
    [result setValue:@([token.created timeIntervalSince1970]) forKey:@"created"];
    [result setValue:@(token.livemode) forKey:@"livemode"];

    // Card
    if (token.card) {
        NSMutableDictionary *card = [@{} mutableCopy];
        [result setValue:card forKey:@"card"];

        [card setValue:token.card.cardId forKey:@"cardId"];

        [card setValue:token.card.last4 forKey:@"last4"];
        [card setValue:token.card.dynamicLast4 forKey:@"dynamicLast4"];
        [card setValue:@(token.card.isApplePayCard) forKey:@"isApplePayCard"];
        [card setValue:@(token.card.expMonth) forKey:@"expMonth"];
        [card setValue:@(token.card.expYear) forKey:@"expYear"];
        [card setValue:token.card.country forKey:@"country"];
        [card setValue:token.card.currency forKey:@"currency"];

        [card setValue:token.card.name forKey:@"name"];
        [card setValue:token.card.addressLine1 forKey:@"addressLine1"];
        [card setValue:token.card.addressLine2 forKey:@"addressLine2"];
        [card setValue:token.card.addressCity forKey:@"addressCity"];
        [card setValue:token.card.addressState forKey:@"addressState"];
        [card setValue:token.card.addressCountry forKey:@"addressCountry"];
        [card setValue:token.card.addressZip forKey:@"addressZip"];
    }
    return result;
}
@end

