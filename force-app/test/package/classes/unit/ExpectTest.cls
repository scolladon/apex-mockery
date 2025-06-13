/*
 * Copyright (c) 2022, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
@IsTest
private class ExpectTest {
  // As Assert.* methods throws are not catchable
  // Test are white box (implementation test instead of behavioural test)
  // We implemented a FakeAsserter class for the occasion

  @IsTest
  static void givenMethodSpyInstance_thatReturnsMethodSpyAssertInstance() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');

    // Act
    Expect.MethodSpyExpectable result = Expect.that(spy);

    // Assert
    Assert.isNotNull(result);
  }

  @IsTest
  static void hasNotBeenCalled_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);

    // Act
    sut.hasNotBeenCalled();

    // Assert
    Assert.areEqual(1, fakeAsserter.callCount);
    Assert.isFalse(fakeAsserter.failed);
  }

  @IsTest
  static void hasBeenCalled_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);

    // Act
    sut.hasBeenCalled();

    // Assert
    Assert.areEqual(1, fakeAsserter.callCount);
    Assert.isTrue(fakeAsserter.failed);
    Assert.areEqual('Method method was not called', fakeAsserter.errorMessage);
  }

  @IsTest
  static void givenObject_hasBeenCalledWith_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);

    // Act
    sut.hasBeenCalledWith(new Account());

    // Assert
    Assert.areEqual(2, fakeAsserter.callCount);
    Assert.isTrue(fakeAsserter.failed);
    Assert.areEqual('Method method was not called with (Account:{})', fakeAsserter.errorMessage);
  }

  @IsTest
  static void givenObjectList_hasBeenCalledWith_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);

    // Act
    sut.hasBeenCalledWith(Argument.ofList(new List<Object>{ new Account(), new Opportunity() }));

    // Assert
    Assert.areEqual(2, fakeAsserter.callCount);
    Assert.isTrue(fakeAsserter.failed);
    Assert.areEqual('Method method was not called with (Account:{}, Opportunity:{})', fakeAsserter.errorMessage);
  }

  @IsTest
  static void givenMixList_hasBeenCalledWith_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);

    // Act
    sut.hasBeenCalledWith(new Account(), Argument.equals('test'));

    // Assert
    Assert.areEqual(2, fakeAsserter.callCount);
    Assert.isTrue(fakeAsserter.failed);
    Assert.areEqual('Method method was not called with (Account:{}, test)', fakeAsserter.errorMessage);
  }

  @IsTest
  static void givenArgumentsEmpty_hasBeenCalledWith_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);

    // Act
    sut.hasBeenCalledWith(Argument.empty());

    // Assert
    Assert.areEqual(2, fakeAsserter.callCount);
    Assert.isTrue(fakeAsserter.failed);
    Assert.areEqual('Method method was not called with ()', fakeAsserter.errorMessage);
  }

  @IsTest
  static void givenNoParameter_hasBeenCalledWith_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);

    // Act
    sut.hasBeenCalledWith();

    // Assert
    Assert.areEqual(2, fakeAsserter.callCount);
    Assert.isTrue(fakeAsserter.failed);
    Assert.areEqual('Method method was not called with ()', fakeAsserter.errorMessage);
  }

  @IsTest
  static void given1Arguments_hasBeenCalledWith_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    spy.returns('anything');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);
    spy.call(new List<Type>{ String.class }, new List<String>{ 'name' }, new List<Object>{ 'param' });

    // Act
    sut.hasBeenCalledWith(Argument.of('param'));

    // Assert
    Assert.areEqual(2, fakeAsserter.callCount);
    Assert.isFalse(fakeAsserter.failed);
  }

  @IsTest
  static void given2Arguments_hasBeenCalledWith_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    spy.returns('anything');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);
    spy.call(new List<Type>{ Integer.class, String.class }, new List<String>{ 'count', 'name' }, new List<Object>{ '2', 'param' });

    // Act
    sut.hasBeenCalledWith('2', 'param');

    // Assert
    Assert.areEqual(2, fakeAsserter.callCount);
    Assert.isFalse(fakeAsserter.failed);
  }

  @IsTest
  static void given3Arguments_hasBeenCalledWith_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    spy.returns('anything');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);
    spy.call(
      new List<Type>{ Integer.class, String.class, String.class },
      new List<String>{ 'count', 'name', 'otherName' },
      new List<Object>{ '3', 'param', 'test' }
    );

    // Act
    sut.hasBeenCalledWith('3', 'param', 'test');

    // Assert
    Assert.areEqual(2, fakeAsserter.callCount);
    Assert.isFalse(fakeAsserter.failed);
  }

  @IsTest
  static void given4Arguments_hasBeenCalledWith_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    spy.returns('anything');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);
    spy.call(
      new List<Type>{ Integer.class, String.class, String.class, String.class },
      new List<String>{ 'count', 'name', 'otherName', 'yetAnotherName' },
      new List<Object>{ '4', 'param', 'unit', 'test' }
    );

    // Act
    sut.hasBeenCalledWith('4', 'param', 'unit', 'test');

    // Assert
    Assert.areEqual(2, fakeAsserter.callCount);
    Assert.isFalse(fakeAsserter.failed);
  }

  @IsTest
  static void given5Arguments_hasBeenCalledWith_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    spy.returns('anything');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);
    spy.call(
      new List<Type>{ Integer.class, String.class, String.class, String.class, String.class },
      new List<String>{ 'count', 'name', 'otherName', 'yetAnotherName', 'latestArgument' },
      new List<Object>{ '5', 'param', 'unit', 'test', 'scenario' }
    );

    // Act
    sut.hasBeenCalledWith('5', 'param', 'unit', 'test', 'scenario');

    // Assert
    Assert.areEqual(2, fakeAsserter.callCount);
    Assert.isFalse(fakeAsserter.failed);
  }

  @IsTest
  static void givenMatchables_hasBeenCalledWith_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    spy.returns('anything');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);
    spy.call(new List<Type>{ String.class }, new List<String>{ 'name' }, new List<Object>{ 'param' });

    // Act
    sut.hasBeenCalledWith(Argument.equals('param'));

    // Assert
    Assert.areEqual(2, fakeAsserter.callCount);
    Assert.isFalse(fakeAsserter.failed);
  }

  @IsTest
  static void givenNullParam_hasBeenCalledWith_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);
    spy.call(new List<Type>{}, new List<String>{}, new List<Object>{});

    // Act
    sut.hasBeenCalledWith(null);

    Assert.areEqual(2, fakeAsserter.callCount);
    Assert.isTrue(fakeAsserter.failed);
    Assert.areEqual('Method method was not called with (null)\nmethod call history:\n\t#1 method(())\n', fakeAsserter.errorMessage);
  }

  @IsTest
  static void givenNullParam_hasBeenLastCalledWith_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);

    // Act
    sut.hasBeenLastCalledWith(null);

    // Assert
    Assert.areEqual(2, fakeAsserter.callCount);
    Assert.isTrue(fakeAsserter.failed);
    Assert.areEqual('Method method was not last called with (null)', fakeAsserter.errorMessage);
  }

  @IsTest
  static void givenObject_hasBeenLastCalledWith_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);

    // Act
    sut.hasBeenLastCalledWith(new Account());

    // Assert
    Assert.areEqual(2, fakeAsserter.callCount);
    Assert.isTrue(fakeAsserter.failed);
    Assert.areEqual('Method method was not last called with (Account:{})', fakeAsserter.errorMessage);
  }

  @IsTest
  static void givenMixList_hasBeenLastCalledWith_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);

    // Act
    sut.hasBeenLastCalledWith(new Account(), Argument.equals('test'));

    // Assert
    Assert.areEqual(2, fakeAsserter.callCount);
    Assert.isTrue(fakeAsserter.failed);
    Assert.areEqual('Method method was not last called with (Account:{}, test)', fakeAsserter.errorMessage);
  }

  @IsTest
  static void givenNoParameter_hasBeenLastCalledWith_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);

    // Act
    sut.hasBeenLastCalledWith();

    // Assert
    Assert.areEqual(2, fakeAsserter.callCount);
    Assert.isTrue(fakeAsserter.failed);
    Assert.areEqual('Method method was not last called with ()', fakeAsserter.errorMessage);
  }

  @IsTest
  static void given1Arguments_hasBeenLastCalledWith_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    spy.returns('anything');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);
    spy.call(new List<Type>{ String.class }, new List<String>{ 'name' }, new List<Object>{ 'param' });

    // Act
    sut.hasBeenLastCalledWith(Argument.of('param'));

    // Assert
    Assert.areEqual(2, fakeAsserter.callCount);
    Assert.isFalse(fakeAsserter.failed);
  }

  @IsTest
  static void given2Arguments_hasBeenLastCalledWith_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    spy.returns('anything');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);
    spy.call(new List<Type>{ Integer.class, String.class }, new List<String>{ 'count', 'name' }, new List<Object>{ '2', 'param' });

    // Act
    sut.hasBeenLastCalledWith('2', 'param');

    // Assert
    Assert.areEqual(2, fakeAsserter.callCount);
    Assert.isFalse(fakeAsserter.failed);
  }

  @IsTest
  static void given3Arguments_hasBeenLastCalledWith_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    spy.returns('anything');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);
    spy.call(
      new List<Type>{ Integer.class, String.class, String.class },
      new List<String>{ 'count', 'name', 'anotherName' },
      new List<Object>{ '3', 'param', 'test' }
    );

    // Act
    sut.hasBeenLastCalledWith('3', 'param', 'test');

    // Assert
    Assert.areEqual(2, fakeAsserter.callCount);
    Assert.isFalse(fakeAsserter.failed);
  }

  @IsTest
  static void given4Arguments_hasBeenLastCalledWith_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    spy.returns('anything');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);
    spy.call(
      new List<Type>{ Integer.class, String.class, String.class, String.class },
      new List<String>{ 'count', 'name', 'anotherName', 'yetAnotherName' },
      new List<Object>{ '4', 'param', 'unit', 'test' }
    );

    // Act
    sut.hasBeenLastCalledWith('4', 'param', 'unit', 'test');

    // Assert
    Assert.areEqual(2, fakeAsserter.callCount);
    Assert.isFalse(fakeAsserter.failed);
  }

  @IsTest
  static void given5Arguments_hasBeenLastCalledWith_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    spy.returns('anything');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);
    spy.call(
      new List<Type>{ Integer.class, String.class, String.class, String.class, String.class },
      new List<String>{ 'count', 'name', 'anotherName', 'yetAnotherName', 'lastParameter' },
      new List<Object>{ '5', 'param', 'unit', 'test', 'scenario' }
    );

    // Act
    sut.hasBeenLastCalledWith('5', 'param', 'unit', 'test', 'scenario');

    // Assert
    Assert.areEqual(2, fakeAsserter.callCount);
    Assert.isFalse(fakeAsserter.failed);
  }

  @IsTest
  static void givenMatchables_hasBeenLastCalledWith_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    spy.returns('anything');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);
    spy.call(new List<Type>{ String.class }, new List<String>{ 'name' }, new List<Object>{ 'param' });

    // Act
    sut.hasBeenLastCalledWith(Argument.equals('param'));

    // Assert
    Assert.areEqual(2, fakeAsserter.callCount);
    Assert.isFalse(fakeAsserter.failed);
  }

  @IsTest
  static void givenNullMatchables_hasBeenLastCalledWithNull_callsAssertEquals() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);
    spy.call(new List<Type>{}, new List<String>{}, new List<Object>());

    // Act
    sut.hasBeenLastCalledWith(null);

    Assert.areEqual(2, fakeAsserter.callCount);
    Assert.isTrue(fakeAsserter.failed);
    Assert.areEqual('Method method was not last called with (null)\nmethod call history:\n\t#1 method(())\n', fakeAsserter.errorMessage);
  }

  @IsTest
  static void givenCall_hasBeenCalledTimes_returnsCalledTimes() {
    // Arrange
    MethodSpy spy = new MethodSpy('method');
    FakeAsserter fakeAsserter = new FakeAsserter();
    Expect.MethodSpyExpectable sut = Expect.that(spy, fakeAsserter);
    spy.call(new List<Type>{}, new List<String>{}, new List<Object>{});

    // Act & Assert
    sut.hasBeenCalledTimes(1);
    Assert.isFalse(fakeAsserter.failed);

    sut.hasBeenCalledTimes(0);
    Assert.isTrue(fakeAsserter.failed);
    Assert.areEqual('Method method was not called 0 times\nmethod call history:\n\t#1 method(())\n', fakeAsserter.errorMessage);

    sut.hasBeenCalledTimes(2);
    Assert.isTrue(fakeAsserter.failed);
    Assert.areEqual('Method method was not called 2 times\nmethod call history:\n\t#1 method(())\n', fakeAsserter.errorMessage);
  }

  @IsTest
  static void givenExpectedEqualsAssert_MethodSpyAsserter_doNotThrow() {
    // Arrange
    Expect.Asserter sut = new Expect.MethodSpyAsserter();

    // Act
    sut.isTrue(true, new FakeErrorMessage('it works'));
    sut.isFalse(false, new FakeErrorMessage('it works too'));

    // Assert
    Assert.isTrue(true, 'This assertions should be reached');
  }

  class FakeErrorMessage implements Expect.ErrorMessage {
    private String message;
    FakeErrorMessage(String message) {
      this.message = message;
    }
    public override String toString() {
      return message;
    }
  }

  class FakeAsserter implements Expect.Asserter {
    public Integer callCount = 0;
    public Boolean failed = false;
    public String errorMessage;

    public void isTrue(Boolean value, Expect.ErrorMessage message) {
      this.callCount++;
      if (!value) {
        this.failed = true;
        this.errorMessage = message.toString();
      }
    }

    public void isFalse(Boolean value, Expect.ErrorMessage message) {
      this.callCount++;
      if (value) {
        this.failed = true;
        this.errorMessage = message.toString();
      }
    }
  }
}
