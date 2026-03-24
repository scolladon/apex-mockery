/*
 * Copyright (c) 2022, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
@IsTest
private class HasNoInteractions {
  @IsTest
  static void recipe() {
    // Arrange
    Mock deliveryServiceMock = Mock.forType(DeliveryService.class);
    deliveryServiceMock.spyOn('planDelivery');

    // Assert — no methods were called on the mock
    Expect.that(deliveryServiceMock).hasNoInteractions();
  }
}
