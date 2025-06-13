/*
 * Copyright (c) 2022, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
@IsTest
private class HasBeenCalledWithJSONMatchable {
  @IsTest
  static void recipe() {
    // Arrange
    Mock deliveryServiceMock = Mock.forType(DeliveryService.class);
    MethodSpy planDeliverySpy = deliveryServiceMock.spyOn('planDelivery');
    Bakery myBakery = new Bakery((DeliveryService) deliveryServiceMock.stub);

    // Act
    myBakery.order(new Pastry('Chocolatine'));
    myBakery.order(new Pastry('Croissant'));

    // Assert
    Expect.that(planDeliverySpy).hasBeenCalledWith(Argument.jsonEquals(new Pastry('Chocolatine'))); // Match not serializable types
    Expect.that(planDeliverySpy).hasBeenCalledWith(new Pastry('Croissant'));
  }
}
