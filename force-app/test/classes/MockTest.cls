/*
 * Copyright (c) 2022, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
@IsTest
private class MockTest {
  // Integration test
  @IsTest
  static void givenAType_whenSpyinOnWithReturn_callingTheMethodReturnsTheConfiguredOutput() {
    // Arrange
    final String expected = 'expected';
    final Mock mock = Mock.forType(DummyInterface.class);
    final MethodSpy dummyMethod = mock.spyOn('dummyMethod');
    dummyMethod.returns(expected);
    DummyInterface sut = (DummyInterface) mock.stub;

    // Act
    final String result = sut.dummyMethod();

    // Assert
    Assert.areEqual(expected, result);
  }

  @IsTest
  static void givenAType_whenSpyinOnWithoutReturn_callingTheMethodReturnsNull() {
    // Arrange
    final Mock mock = Mock.forType(DummyInterface.class);
    final MethodSpy dummyMethod = mock.spyOn('dummyMethod');
    dummyMethod.returns(null);

    DummyInterface sut = (DummyInterface) mock.stub;

    // Act
    final Object result = sut.dummyMethod();

    // Assert
    Assert.areEqual(null, result);
  }

  // Unit test
  @IsTest
  static void givenAMethodName_thenSpyOnReturnsMethodSpy() {
    // Arrange
    final String expected = 'methodName';
    final Mock sut = Mock.forType(DummyInterface.class);

    // Act
    final MethodSpy result = sut.spyOn(expected);

    // Assert
    Assert.areEqual(expected, result.methodName);
  }

  @IsTest
  static void givenAMethodName_whenCallingSpyOnMultipleTimes_thenReturnsSameMethodSpy() {
    // Arrange
    final String methodName = 'methodName';
    final Mock sut = Mock.forType(DummyInterface.class);
    final MethodSpy expected = sut.spyOn(methodName);

    // Act
    final MethodSpy result = sut.spyOn(methodName);

    // Assert
    Assert.areEqual(expected, result);
  }

  @IsTest
  static void givenAMethodName_whenNotSpiedOn_thenGetSpyReturnsNull() {
    // Arrange
    final String methodName = 'methodName';
    final Mock sut = Mock.forType(DummyInterface.class);

    // Act
    final MethodSpy result = sut.getSpy(methodName);

    // Assert
    Assert.areEqual(null, result);
  }

  @IsTest
  static void givenAMethodName_whenSpiedOn_thenGetSpyReturnsMethodSpy() {
    // Arrange
    final String methodName = 'methodName';
    final Mock sut = Mock.forType(DummyInterface.class);
    final MethodSpy expected = sut.spyOn(methodName);

    // Act
    final MethodSpy result = sut.getSpy(methodName);

    // Assert
    Assert.areEqual(expected, result);
  }

  @IsTest
  static void givenAType_forTypeReturnsMock() {
    // Arrange
    final Type param = DummyInterface.class;

    // Act
    final Mock result = Mock.forType(param);

    // Assert
    Assert.areNotEqual(null, result);
  }

  @IsTest
  static void givenNull_forTypeThrows() {
    // Arrange
    final Type param = null;

    // Act
    try {
      final Mock result = Mock.forType(param);
      // Assert
      Assert.fail('Expected exception was not thrown');
    } catch (Exception ex) {
      Assert.areNotEqual(null, ex);
    }
  }
}