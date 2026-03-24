/*
 * Copyright (c) 2022, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
@IsTest
private class SpyReset {
  @IsTest
  static void recipe() {
    // Arrange
    Mock deliveryServiceMock = Mock.forType(DeliveryService.class);
    MethodSpy planDeliverySpy = deliveryServiceMock.spyOn('planDelivery');
    Bakery myBakery = new Bakery((DeliveryService) deliveryServiceMock.stub);

    myBakery.order(new Pastry('Croissant'));
    Expect.that(planDeliverySpy).hasBeenCalledTimes(1);

    // Act — reset the spy to clear call history and configuration
    planDeliverySpy.reset();

    // Assert — spy is back to initial state
    Expect.that(planDeliverySpy).hasNotBeenCalled();
  }
}
