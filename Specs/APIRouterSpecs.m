//
//  APIRouterSpecs.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 14-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "SpecHelper.h"

#import "APIRouter.h"

SpecBegin(APIRouterSpecs)

describe(@"APIRouter", ^{
    describe(@"initialization", ^{
        it(@"uses a default inflector if none is provided", ^{
            APIRouter *router = [[APIRouter alloc] init];
            expect(router.inflector).notTo.beNil();
        });

        it(@"accepts other inflectors", ^{
            APIInflector *inflector = [[APIInflector alloc] init];
            APIRouter *router = [[APIRouter alloc] initWithInflector:inflector];
            expect(router.inflector).to.equal(inflector);
        });
    });

    describe(@"routing", ^{
        it(@"routes index actions to the pluralized resource name", ^{
            id inflector = [OCMockObject mockForProtocol:@protocol(APIInflector)];
            [[[inflector expect] andReturn:@"objects"] pluralize:@"object"];
            APIRouter *router = [[APIRouter alloc] initWithInflector:inflector];
            expect([router pathForAction:@"index" onResource:[NSObject class]]).to.equal(@"/objects");
            [inflector verify];
        });
    });
});

SpecEnd