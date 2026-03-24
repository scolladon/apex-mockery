/*
 * Copyright (c) 2022, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
@IsTest
private class MockClear {
  @IsTest
  static void recipe() {
    // Arrange
    Mock deliveryServiceMock = Mock.forType(DeliveryService.class);
    deliveryServiceMock.spyOn('planDelivery');

    // Act — clear removes all spy registrations entirely
    deliveryServiceMock.clear();

    // Assert — spy is no longer registered
    Assert.isNull(deliveryServiceMock.getSpy('planDelivery'));
  }
}
