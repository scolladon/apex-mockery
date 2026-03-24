/*
 * Copyright (c) 2022, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
@IsTest
private class GetArguments {
  @IsTest
  static void recipe() {
    // Arrange
    Mock deliveryServiceMock = Mock.forType(DeliveryService.class);
    MethodSpy planDeliverySpy = deliveryServiceMock.spyOn('planDelivery');
    Bakery myBakery = new Bakery((DeliveryService) deliveryServiceMock.stub);

    myBakery.order(new Pastry('Croissant'));
    myBakery.order(new Pastry('Chocolatine'));

    // Access arguments from a specific call (0-based index)
    List<Object> firstCallArgs = planDeliverySpy.getArguments(0);
    Assert.areEqual(new Pastry('Croissant'), firstCallArgs[0]);

    // Access the last call's arguments
    List<Object> lastCallArgs = planDeliverySpy.getLastArguments();
    Assert.areEqual(new Pastry('Chocolatine'), lastCallArgs[0]);

    // Access a specific argument from a specific call
    Pastry firstArg = (Pastry) planDeliverySpy.getArgument(0, 0);
    Assert.areEqual(new Pastry('Croissant'), firstArg);

    // Access a specific argument from the last call
    Pastry lastArg = (Pastry) planDeliverySpy.getLastArgument(0);
    Assert.areEqual(new Pastry('Chocolatine'), lastArg);
  }
}
