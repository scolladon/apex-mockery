/*
 * Copyright (c) 2022, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
@IsTest
private class HasBeenCalledNthWith {
  @IsTest
  static void recipe() {
    // Arrange
    Mock deliveryServiceMock = Mock.forType(DeliveryService.class);
    MethodSpy planDeliverySpy = deliveryServiceMock.spyOn('planDelivery');
    Bakery myBakery = new Bakery((DeliveryService) deliveryServiceMock.stub);

    // Act
    myBakery.order(new Pastry('Croissant'));
    myBakery.order(new Pastry('Chocolatine'));

    // Assert — first call was with Croissant
    Expect.that(planDeliverySpy).hasBeenCalledNthWith(1, new Pastry('Croissant'));
    // Assert — second call was with Chocolatine
    Expect.that(planDeliverySpy).hasBeenCalledNthWith(2, new Pastry('Chocolatine'));
  }
}
