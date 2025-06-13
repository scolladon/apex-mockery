/*
 * Copyright (c) 2022, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
@IsTest
private class ApexMockeryOverview {
  @IsTest
  static void recipe() {
    // Arrange
    mockery.Mock deliveryServiceMock = mockery.Mock.forType(DeliveryService.class, new StubBuilderImpl());
    mockery.MethodSpy planDeliverySpy = deliveryServiceMock.spyOn('planDelivery');
    Bakery myBakery = new Bakery((DeliveryService) deliveryServiceMock.stub);
    planDeliverySpy.whenCalledWith(new Pastry('Chocolatine')).thenReturn(Date.today().addDays(3)).thenReturnOnce(Date.today().addDays(2));
    planDeliverySpy.whenCalledWith(new OperaPastryMatchable()).thenThrow(new RecipeException());
    planDeliverySpy.returns(Date.today().addDays(4));

    mockery.Expect.that(planDeliverySpy).hasNotBeenCalled();
    mockery.Expect.that(planDeliverySpy).hasBeenCalledTimes(0);

    // Act & Assert
    // Once matcher (imagine first command is delivered early)
    OrderConfirmation order = myBakery.order(new Pastry('Chocolatine'));
    mockery.Expect.that(planDeliverySpy).hasBeenCalled();
    mockery.Expect.that(planDeliverySpy).hasBeenCalledWith(new Pastry('Chocolatine'));
    mockery.Expect.that(planDeliverySpy).hasBeenLastCalledWith(new Pastry('Chocolatine'));
    mockery.Expect.that(planDeliverySpy).hasBeenCalledTimes(1);
    Assert.areEqual(Date.today().addDays(2), order.deliveryDate);

    // Matcher
    order = myBakery.order(new Pastry('Chocolatine'));
    mockery.Expect.that(planDeliverySpy).hasBeenCalled();
    mockery.Expect.that(planDeliverySpy).hasBeenCalledWith(new Pastry('Chocolatine'));
    mockery.Expect.that(planDeliverySpy).hasBeenLastCalledWith(new Pastry('Chocolatine'));
    mockery.Expect.that(planDeliverySpy).hasBeenCalledTimes(2);
    Assert.areEqual(Date.today().addDays(3), order.deliveryDate);

    order = myBakery.order(new Pastry('Croissant'));
    mockery.Expect.that(planDeliverySpy).hasBeenCalled();
    mockery.Expect.that(planDeliverySpy).hasBeenCalledWith(mockery.Argument.jsonEquals(new Pastry('Chocolatine')));
    mockery.Expect.that(planDeliverySpy).hasBeenCalledWith(new Pastry('Croissant'));
    mockery.Expect.that(planDeliverySpy).hasBeenLastCalledWith(new Pastry('Croissant'));
    mockery.Expect.that(planDeliverySpy).hasBeenCalledTimes(3);
    Assert.areEqual(Date.today().addDays(4), order.deliveryDate);

    try {
      order = myBakery.order(new Pastry('Opera'));
      Assert.fail('Expected exception was not thrown');
    } catch (Exception ex) {
      Assert.isInstanceOfType(ex, RecipeException.class);
    }
  }

  private class OperaPastryMatchable implements mockery.Argument.Matchable {
    public Boolean matches(Object callArgument) {
      Pastry p = (Pastry) callArgument;
      return p.name == 'Opera';
    }
  }
}
