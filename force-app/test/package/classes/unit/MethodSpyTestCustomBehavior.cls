/*
 * Copyright (c) 2022, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

@IsTest
private class MethodSpyTestCustomBehavior {
  class ReturnParam implements MethodSpy.SpyBehavior {
    public Object execute(final List<Object> params) {
      return params;
    }
  }

  @IsTest
  static void givenSpyConfiguredWithBehavior_whenCalled_thenExecuteTheBehavior() {
    // Arrange
    MethodSpy sut = new MethodSpy('methodName');
    sut.behaves(new ReturnParam());
    final String valueParameter = 'str';

    // Act
    final List<Object> result = (List<Object>) sut.call(new List<Type>{ String.class }, new List<String>{ 'param' }, new List<Object>{ valueParameter });

    // Assert
    Assert.areEqual(new List<Object>{ valueParameter }, result);
    Assert.isTrue(valueParameter === result[0]);
  }

  @IsTest
  static void givenSpyConfiguredWithMatcherWithBehavior_whenCalledWithMatching_thenExecuteTheBehavior() {
    // Arrange
    MethodSpy sut = new MethodSpy('methodName');
    sut.whenCalledWith('str').thenBehave(new ReturnParam());
    final String valueParameter = 'str';

    // Act
    final List<Object> result = (List<Object>) sut.call(new List<Type>{ String.class }, new List<String>{ 'param' }, new List<Object>{ valueParameter });

    // Assert
    Assert.areEqual(new List<Object>{ valueParameter }, result);
    Assert.isTrue(valueParameter === result[0]);
  }

  @IsTest
  static void givenSpyConfiguredWithBehaviorOnce_whenCalled_thenExecuteTheBehaviorOnce() {
    // Arrange
    MethodSpy sut = new MethodSpy('methodName');
    sut.behavesOnce(new ReturnParam());
    final String valueParameter = 'str';

    // Act
    final List<Object> result = (List<Object>) sut.call(new List<Type>{ String.class }, new List<String>{ 'param' }, new List<Object>{ valueParameter });
    Assert.areEqual(new List<Object>{ valueParameter }, result);
    Assert.isTrue(valueParameter === result[0]);

    final Object secondResult = sut.call(new List<Type>{ String.class }, new List<String>{ 'param' }, new List<Object>{ 'str' });
    Assert.isNull(secondResult);
  }

  @IsTest
  static void givenSpyConfiguredWithMatcherWithBehaviorOnce_whenCalledWithMatching_thenExecuteTheBehaviorOnce() {
    // Arrange
    MethodSpy sut = new MethodSpy('methodName');
    sut.whenCalledWith('str').thenBehaveOnce(new ReturnParam());
    final String valueParameter = 'str';

    // Act
    final List<Object> result = (List<Object>) sut.call(new List<Type>{ String.class }, new List<String>{ 'param' }, new List<Object>{ valueParameter });
    Assert.areEqual(new List<Object>{ valueParameter }, result);
    Assert.isTrue(valueParameter === result[0]);

    final Object secondResult = sut.call(new List<Type>{ String.class }, new List<String>{ 'param' }, new List<Object>{ 'str' });
    Assert.isNull(secondResult);
  }

  @IsTest
  static void givenSpyConfiguredWithBehaviorTimes_whenCalled_thenExecuteTheBehaviorTimes() {
    // Arrange
    MethodSpy sut = new MethodSpy('methodName');
    sut.behaves(new ReturnParam(), 2);
    final String valueParameter = 'str';

    // Act
    final List<Object> result = (List<Object>) sut.call(new List<Type>{ String.class }, new List<String>{ 'param' }, new List<Object>{ valueParameter });
    Assert.areEqual(new List<Object>{ valueParameter }, result);
    Assert.isTrue(valueParameter === result[0]);

    Object secondResult = sut.call(new List<Type>{ String.class }, new List<String>{ 'param' }, new List<Object>{ 'str' });
    Assert.areEqual(new List<Object>{ valueParameter }, secondResult);

    secondResult = sut.call(new List<Type>{ String.class }, new List<String>{ 'param' }, new List<Object>{ 'str' });
    Assert.isNull(secondResult);
  }

  @IsTest
  static void givenSpyConfiguredWithMatcherWithBehaviorTimes_whenCalledWithMatching_thenExecuteTheBehaviorTimes() {
    // Arrange
    MethodSpy sut = new MethodSpy('methodName');
    sut.whenCalledWith('str').thenBehave(new ReturnParam(), 2);
    final String valueParameter = 'str';

    // Act
    final List<Object> result = (List<Object>) sut.call(new List<Type>{ String.class }, new List<String>{ 'param' }, new List<Object>{ valueParameter });
    Assert.areEqual(new List<Object>{ valueParameter }, result);
    Assert.isTrue(valueParameter === result[0]);

    Object secondResult = sut.call(new List<Type>{ String.class }, new List<String>{ 'param' }, new List<Object>{ 'str' });

    secondResult = sut.call(new List<Type>{ String.class }, new List<String>{ 'param' }, new List<Object>{ 'str' });
    Assert.isNull(secondResult);
  }

  @IsTest
  static void givenSpyConfiguredWithMutatingBehavior_whenCalledWithObjectAndUpdateAttribute_thenObjectAttributeIsMutated() {
    // Arrange
    MethodSpy sut = new MethodSpy('methodName');
    final Person aPerson = new Person('Name');
    sut.behaves(new MutateParam());

    // Act
    sut.call(new List<Type>{ String.class }, new List<String>{ 'param' }, new List<Object>{ aPerson });

    // Assert
    Assert.areEqual('Mutated Name', aPerson.name);
  }

  class MutateParam implements MethodSpy.SpyBehavior {
    public Object execute(final List<Object> params) {
      final Person aPerson = (Person) params[0];
      aPerson.name = 'Mutated ' + aPerson.name;
      return null;
    }
  }

  class Person {
    public String name { get; set; }
    public Person(final String name) {
      this.name = name;
    }
  }
}
