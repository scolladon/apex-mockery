/*
 * Copyright (c) 2022, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
@IsTest
private class WhenCalledWithoutMatchingConfiguration {
  @IsTest
  static void recipe() {
    // Arrange
    Mock deliveryServiceMock = Mock.forType(DeliveryService.class);
    MethodSpy planDeliverySpy = deliveryServiceMock.spyOn('planDelivery');
    Bakery myBakery = new Bakery((DeliveryService) deliveryServiceMock.stub);
    planDeliverySpy.whenCalledWith(new Pastry('Croissant')).thenReturn(Date.today().addDays(3));
    planDeliverySpy.whenCalledWith(new Pastry('Chocolatine')).thenReturn(Date.today().addDays(2));

    // Act
    try {
      OrderConfirmation order = myBakery.order(new Pastry('Opera'));

      // Assert
      Assert.fail('Expected exception was not thrown');
    } catch (Exception ex) {
      Assert.isInstanceOfType(ex, MethodSpy.ConfigurationException.class);
    }
  }
}
