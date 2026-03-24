/*
 * Copyright (c) 2022, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
@IsTest
private class MockResetAll {
  @IsTest
  static void recipe() {
    // Arrange
    Mock deliveryServiceMock = Mock.forType(DeliveryService.class);
    MethodSpy planDeliverySpy = deliveryServiceMock.spyOn('planDelivery');
    Bakery myBakery = new Bakery((DeliveryService) deliveryServiceMock.stub);

    myBakery.order(new Pastry('Croissant'));
    Expect.that(planDeliverySpy).hasBeenCalledTimes(1);

    // Act — reset all spies (clears call logs and configurations, keeps registrations)
    deliveryServiceMock.resetAll();

    // Assert — all spies cleared, registrations kept
    Expect.that(planDeliverySpy).hasNotBeenCalled();
    Assert.isNotNull(deliveryServiceMock.getSpy('planDelivery'));
  }
}
