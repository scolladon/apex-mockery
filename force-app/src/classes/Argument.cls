/*
 * Copyright (c) 2022, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

/**
 * Matchable offers public static methods to build out-of-the-box matchers to be used with Expect
 *    - Argument.any()
 *    - Argument.notNull()
 *    - Argument.negate(Argument.Matchable matchable)
 *    - Argument.allOf(List<Argument.Matchable> matchables)
 *    - Argument.anyOf(List<Argument.Matchable> matchables)
 *    - Argument.equals(Object object)
 *    - Argument.jsonEquals(Object object)
 *    - Argument.ofType(String typeName)
 *    - Argument.ofType(Type type)
 *    - Argument.ofType(Schema.SObjectType sobjectType)
 *    - Argument.stringContaining(String substring)
 *    - Argument.stringStartingWith(String prefix)
 *    - Argument.stringEndingWith(String suffix)
 *    - Argument.stringMatching(String regex)
 *    - Argument.collectionContaining(Object value)
 *    - Argument.hasSize(Integer size)
 */
@IsTest
@SuppressWarnings('PMD.EmptyStatementBlock, PMD.AvoidGlobalModifier')
global class Argument {
  global interface Matchable {
    Boolean matches(Object callArgument);
  }

  private Argument() {
  }

  public static boolean matches(final List<Argument.Matchable> matchableArguments, final List<Object> callArguments) {
    if (matchableArguments == null || callArguments == null) {
      // If both equals null then return true
      return matchableArguments == callArguments;
    }

    if (matchableArguments.size() != callArguments.size()) {
      return false;
    }

    for (Integer i = 0; i < matchableArguments.size(); ++i) {
      if (!matchableArguments[i].matches(callArguments[i])) {
        return false;
      }
    }

    return true;
  }

  global static List<Argument.Matchable> empty() {
    return new List<Argument.Matchable>();
  }

  // SYNC POINT: The 1-5 argument overloads below are duplicated in:
  //   - MethodSpy.whenCalledWith()  (MethodSpy.cls)
  //   - Expect.hasBeenCalledWith()  (Expect.cls)
  // If you add a 6th overload here, add it in the other two locations too.
  global static List<Argument.Matchable> of(final Object arg) {
    return Argument.ofList(new List<Object>{ arg });
  }

  global static List<Argument.Matchable> of(final Object arg1, final Object arg2) {
    return Argument.ofList(new List<Object>{ arg1, arg2 });
  }

  global static List<Argument.Matchable> of(final Object arg1, final Object arg2, final Object arg3) {
    return Argument.ofList(new List<Object>{ arg1, arg2, arg3 });
  }

  global static List<Argument.Matchable> of(final Object arg1, final Object arg2, final Object arg3, final Object arg4) {
    return Argument.ofList(new List<Object>{ arg1, arg2, arg3, arg4 });
  }

  global static List<Argument.Matchable> of(final Object arg1, final Object arg2, final Object arg3, final Object arg4, final Object arg5) {
    return Argument.ofList(new List<Object>{ arg1, arg2, arg3, arg4, arg5 });
  }

  global static List<Argument.Matchable> ofList(final List<Object> listOfArgs) {
    final List<Argument.Matchable> listOfMatchableArgs = Argument.empty();
    if (listOfArgs == null) {
      return listOfMatchableArgs;
    }
    for (Object callArgument : listOfArgs) {
      if (callArgument instanceof Argument.Matchable) {
        listOfMatchableArgs.add((Argument.Matchable) callArgument);
      } else {
        listOfMatchableArgs.add(Argument.equals(callArgument));
      }
    }
    return listOfMatchableArgs;
  }

  global static Argument.Matchable any() {
    return new AnyMatchable();
  }

  global static Argument.Matchable notNull() {
    return new NotNullMatchable();
  }

  global static Argument.Matchable negate(final Argument.Matchable negated) {
    if (negated == null) {
      throw new IllegalArgumentException('matchable must not be null');
    }
    return new NotMatchable(negated);
  }

  global static Argument.Matchable allOf(final List<Argument.Matchable> matchables) {
    if (matchables == null) {
      throw new IllegalArgumentException('matchables must not be null');
    }
    return new AllOfMatchable(matchables);
  }

  global static Argument.Matchable allOf(final Argument.Matchable m1) {
    return Argument.allOf(new List<Argument.Matchable>{ m1 });
  }

  global static Argument.Matchable allOf(final Argument.Matchable m1, final Argument.Matchable m2) {
    return Argument.allOf(new List<Argument.Matchable>{ m1, m2 });
  }

  global static Argument.Matchable allOf(final Argument.Matchable m1, final Argument.Matchable m2, final Argument.Matchable m3) {
    return Argument.allOf(new List<Argument.Matchable>{ m1, m2, m3 });
  }

  global static Argument.Matchable allOf(final Argument.Matchable m1, final Argument.Matchable m2, final Argument.Matchable m3, final Argument.Matchable m4) {
    return Argument.allOf(new List<Argument.Matchable>{ m1, m2, m3, m4 });
  }

  global static Argument.Matchable allOf(
    final Argument.Matchable m1,
    final Argument.Matchable m2,
    final Argument.Matchable m3,
    final Argument.Matchable m4,
    final Argument.Matchable m5
  ) {
    return Argument.allOf(new List<Argument.Matchable>{ m1, m2, m3, m4, m5 });
  }

  global static Argument.Matchable anyOf(final List<Argument.Matchable> matchables) {
    if (matchables == null) {
      throw new IllegalArgumentException('matchables must not be null');
    }
    return new AnyOfMatchable(matchables);
  }

  global static Argument.Matchable anyOf(final Argument.Matchable m1) {
    return Argument.anyOf(new List<Argument.Matchable>{ m1 });
  }

  global static Argument.Matchable anyOf(final Argument.Matchable m1, final Argument.Matchable m2) {
    return Argument.anyOf(new List<Argument.Matchable>{ m1, m2 });
  }

  global static Argument.Matchable anyOf(final Argument.Matchable m1, final Argument.Matchable m2, final Argument.Matchable m3) {
    return Argument.anyOf(new List<Argument.Matchable>{ m1, m2, m3 });
  }

  global static Argument.Matchable anyOf(final Argument.Matchable m1, final Argument.Matchable m2, final Argument.Matchable m3, final Argument.Matchable m4) {
    return Argument.anyOf(new List<Argument.Matchable>{ m1, m2, m3, m4 });
  }

  global static Argument.Matchable anyOf(
    final Argument.Matchable m1,
    final Argument.Matchable m2,
    final Argument.Matchable m3,
    final Argument.Matchable m4,
    final Argument.Matchable m5
  ) {
    return Argument.anyOf(new List<Argument.Matchable>{ m1, m2, m3, m4, m5 });
  }

  global static Argument.Matchable equals(final Object callArgument) {
    return new EqualsMatchable(callArgument);
  }

  global static Argument.Matchable jsonEquals(final Object callArgument) {
    return new JSONMatchable(callArgument);
  }

  global static Argument.Matchable ofType(final String matchingType) {
    return new TypeMatchable(matchingType);
  }

  global static Argument.Matchable ofType(final Schema.SObjectType callArgument) {
    return new TypeMatchable(callArgument);
  }

  global static Argument.Matchable ofType(final Type callArgument) {
    return new TypeMatchable(callArgument);
  }

  global static Argument.Matchable stringContaining(final String substring) {
    return new StringContainingMatchable(substring);
  }

  global static Argument.Matchable stringStartingWith(final String prefix) {
    return new StringStartingWithMatchable(prefix);
  }

  global static Argument.Matchable stringEndingWith(final String suffix) {
    return new StringEndingWithMatchable(suffix);
  }

  global static Argument.Matchable stringMatching(final String regex) {
    return new StringMatchingMatchable(regex);
  }

  global static Argument.Matchable collectionContaining(final Object value) {
    return new CollectionContainingMatchable(value);
  }

  global static Argument.Matchable hasSize(final Integer size) {
    return new HasSizeMatchable(size);
  }

  private class AnyMatchable implements Argument.Matchable {
    public Boolean matches(final Object callArgument) {
      return true;
    }

    public override String toString() {
      return 'any';
    }

    public Boolean equals(Object obj) {
      return obj != null && obj instanceof AnyMatchable;
    }
  }

  private class NotNullMatchable implements Argument.Matchable {
    public Boolean matches(final Object callArgument) {
      return callArgument != null;
    }

    public override String toString() {
      return 'notNull';
    }

    public Boolean equals(Object obj) {
      return obj != null && obj instanceof NotNullMatchable;
    }
  }

  private class NotMatchable implements Argument.Matchable {
    private final Argument.Matchable delegate;

    public NotMatchable(final Argument.Matchable delegate) {
      this.delegate = delegate;
    }

    public Boolean matches(final Object callArgument) {
      return !this.delegate.matches(callArgument);
    }

    public override String toString() {
      return 'not(' + this.delegate + ')';
    }

    public Boolean equals(Object obj) {
      if (obj == null || !(obj instanceof NotMatchable)) {
        return false;
      }
      NotMatchable other = (NotMatchable) obj;
      return this.delegate.equals(other.delegate);
    }
  }

  private class AllOfMatchable implements Argument.Matchable {
    private final List<Argument.Matchable> delegates;

    public AllOfMatchable(final List<Argument.Matchable> delegates) {
      this.delegates = delegates;
    }

    public Boolean matches(final Object callArgument) {
      for (Argument.Matchable delegate : this.delegates) {
        if (!delegate.matches(callArgument)) {
          return false;
        }
      }
      return true;
    }

    public override String toString() {
      return 'allOf(' + this.delegates + ')';
    }

    public Boolean equals(Object obj) {
      if (obj == null || !(obj instanceof AllOfMatchable)) {
        return false;
      }
      AllOfMatchable other = (AllOfMatchable) obj;
      if (this.delegates.size() != other.delegates.size()) {
        return false;
      }
      for (Integer i = 0; i < this.delegates.size(); i++) {
        if (!this.delegates[i].equals(other.delegates[i])) {
          return false;
        }
      }
      return true;
    }
  }

  private class AnyOfMatchable implements Argument.Matchable {
    private final List<Argument.Matchable> delegates;

    public AnyOfMatchable(final List<Argument.Matchable> delegates) {
      this.delegates = delegates;
    }

    public Boolean matches(final Object callArgument) {
      for (Argument.Matchable delegate : this.delegates) {
        if (delegate.matches(callArgument)) {
          return true;
        }
      }
      return false;
    }

    public override String toString() {
      return 'anyOf(' + this.delegates + ')';
    }

    public Boolean equals(Object obj) {
      if (obj == null || !(obj instanceof AnyOfMatchable)) {
        return false;
      }
      AnyOfMatchable other = (AnyOfMatchable) obj;
      if (this.delegates.size() != other.delegates.size()) {
        return false;
      }
      for (Integer i = 0; i < this.delegates.size(); i++) {
        if (!this.delegates[i].equals(other.delegates[i])) {
          return false;
        }
      }
      return true;
    }
  }

  private class EqualsMatchable implements Argument.Matchable {
    private Object callArgumentToMatch;

    public EqualsMatchable(final Object callArgumentToMatch) {
      this.callArgumentToMatch = callArgumentToMatch;
    }

    public Boolean matches(final Object callArgument) {
      if (this.callArgumentToMatch == null) {
        return callArgument == null;
      }

      // case-sensitive check for string
      if (this.callArgumentToMatch instanceof String) {
        return this.callArgumentToMatch.equals(callArgument);
      }

      // native platform equality check for anything else
      return this.callArgumentToMatch == callArgument;
    }

    public override String toString() {
      return String.valueOf(this.callArgumentToMatch);
    }

    public Boolean equals(Object obj) {
      if (obj == null || !(obj instanceof EqualsMatchable)) {
        return false;
      }
      EqualsMatchable other = (EqualsMatchable) obj;
      return this.matches(other.callArgumentToMatch);
    }
  }

  private class JSONMatchable implements Argument.Matchable {
    private String jsonValue;

    public JSONMatchable(final Object callArgumentToMatch) {
      // Serialized once at configuration time — the expected value never changes.
      this.jsonValue = JSON.serialize(callArgumentToMatch);
    }

    public Boolean matches(final Object callArgument) {
      // The call argument must be serialized fresh each time — it varies per invocation.
      return String.valueOf(this.jsonValue).equals(String.valueOf(JSON.serialize(callArgument)));
    }

    override public String toString() {
      return 'json(' + this.jsonValue + ')';
    }

    public Boolean equals(Object obj) {
      if (obj == null || !(obj instanceof JSONMatchable)) {
        return false;
      }
      JSONMatchable other = (JSONMatchable) obj;
      return this.jsonValue.equals(other.jsonValue);
    }
  }

  private class TypeMatchable implements Argument.Matchable {
    private String typeNameToMatch;

    public TypeMatchable(final Schema.SObjectType callArgumentToMatch) {
      this.typeNameToMatch = callArgumentToMatch.getDescribe().getName();
    }

    public TypeMatchable(final String callArgumentToMatch) {
      this.typeNameToMatch = callArgumentToMatch;
    }

    public TypeMatchable(final Type callArgumentToMatch) {
      this.typeNameToMatch = callArgumentToMatch.getName();
    }

    public Boolean matches(final Object callArgument) {
      String typeName = Argument.getTypeName(callArgument);
      if (typeName == null) {
        return false;
      }
      if (this.typeNameToMatch == typeName) {
        return true;
      }

      Type actualType = Type.forName(typeName);
      Type expectedType = Type.forName(this.typeNameToMatch);
      if (expectedType != null && actualType != null) {
        return expectedType.isAssignableFrom(actualType);
      }
      return false;
    }

    override public String toString() {
      return this.typeNameToMatch + '.Type';
    }

    public Boolean equals(Object obj) {
      if (obj == null || !(obj instanceof TypeMatchable)) {
        return false;
      }
      TypeMatchable other = (TypeMatchable) obj;
      return this.typeNameToMatch == other.typeNameToMatch;
    }
  }

  private class StringContainingMatchable implements Argument.Matchable {
    private final String pattern;

    public StringContainingMatchable(final String pattern) {
      this.pattern = pattern;
    }

    public Boolean matches(final Object callArgument) {
      if (!(callArgument instanceof String)) {
        return false;
      }
      return ((String) callArgument).contains(this.pattern);
    }

    public override String toString() {
      return 'stringContaining(' + this.pattern + ')';
    }

    public Boolean equals(Object obj) {
      if (obj == null || !(obj instanceof StringContainingMatchable)) {
        return false;
      }
      return this.pattern == ((StringContainingMatchable) obj).pattern;
    }
  }

  private class StringStartingWithMatchable implements Argument.Matchable {
    private final String pattern;

    public StringStartingWithMatchable(final String pattern) {
      this.pattern = pattern;
    }

    public Boolean matches(final Object callArgument) {
      if (!(callArgument instanceof String)) {
        return false;
      }
      return ((String) callArgument).startsWith(this.pattern);
    }

    public override String toString() {
      return 'stringStartingWith(' + this.pattern + ')';
    }

    public Boolean equals(Object obj) {
      if (obj == null || !(obj instanceof StringStartingWithMatchable)) {
        return false;
      }
      return this.pattern == ((StringStartingWithMatchable) obj).pattern;
    }
  }

  private class StringEndingWithMatchable implements Argument.Matchable {
    private final String pattern;

    public StringEndingWithMatchable(final String pattern) {
      this.pattern = pattern;
    }

    public Boolean matches(final Object callArgument) {
      if (!(callArgument instanceof String)) {
        return false;
      }
      return ((String) callArgument).endsWith(this.pattern);
    }

    public override String toString() {
      return 'stringEndingWith(' + this.pattern + ')';
    }

    public Boolean equals(Object obj) {
      if (obj == null || !(obj instanceof StringEndingWithMatchable)) {
        return false;
      }
      return this.pattern == ((StringEndingWithMatchable) obj).pattern;
    }
  }

  private class StringMatchingMatchable implements Argument.Matchable {
    private final String regex;

    public StringMatchingMatchable(final String regex) {
      this.regex = regex;
    }

    public Boolean matches(final Object callArgument) {
      if (!(callArgument instanceof String)) {
        return false;
      }
      return Pattern.matches(this.regex, (String) callArgument);
    }

    public override String toString() {
      return 'stringMatching(' + this.regex + ')';
    }

    public Boolean equals(Object obj) {
      if (obj == null || !(obj instanceof StringMatchingMatchable)) {
        return false;
      }
      return this.regex == ((StringMatchingMatchable) obj).regex;
    }
  }

  private static List<Object> toIterableList(final Object callArgument) {
    if (callArgument instanceof List<Object>) {
      return (List<Object>) callArgument;
    }
    String typeName = Argument.getTypeName(callArgument);
    if (typeName != null && typeName.startsWith('Set<')) {
      return (List<Object>) JSON.deserializeUntyped(JSON.serialize(callArgument));
    }
    return null;
  }

  private class CollectionContainingMatchable implements Argument.Matchable {
    private final Object expected;

    public CollectionContainingMatchable(final Object expected) {
      this.expected = expected;
    }

    public Boolean matches(final Object callArgument) {
      List<Object> items = Argument.toIterableList(callArgument);
      if (items == null) {
        return false;
      }
      Argument.Matchable equalsMatcher = Argument.equals(this.expected);
      for (Object item : items) {
        if (equalsMatcher.matches(item)) {
          return true;
        }
      }
      return false;
    }

    public override String toString() {
      return 'collectionContaining(' + this.expected + ')';
    }

    public Boolean equals(Object obj) {
      if (obj == null || !(obj instanceof CollectionContainingMatchable)) {
        return false;
      }
      return Argument.equals(this.expected).matches(((CollectionContainingMatchable) obj).expected);
    }
  }

  private class HasSizeMatchable implements Argument.Matchable {
    private final Integer expectedSize;

    public HasSizeMatchable(final Integer expectedSize) {
      this.expectedSize = expectedSize;
    }

    public Boolean matches(final Object callArgument) {
      if (callArgument instanceof List<Object>) {
        return ((List<Object>) callArgument).size() == this.expectedSize;
      }
      String typeName = Argument.getTypeName(callArgument);
      if (typeName == null) {
        return false;
      }
      if (typeName.startsWith('Set<')) {
        List<Object> items = (List<Object>) JSON.deserializeUntyped(JSON.serialize(callArgument));
        return items.size() == this.expectedSize;
      }
      if (typeName.startsWith('Map<')) {
        Map<String, Object> mapItems = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(callArgument));
        return mapItems.size() == this.expectedSize;
      }
      return false;
    }

    public override String toString() {
      return 'hasSize(' + this.expectedSize + ')';
    }

    public Boolean equals(Object obj) {
      if (obj == null || !(obj instanceof HasSizeMatchable)) {
        return false;
      }
      return this.expectedSize == ((HasSizeMatchable) obj).expectedSize;
    }
  }

  private static String getTypeName(final Object callArgument) {
    if (callArgument == null) {
      return null;
    }
    // Apex does not expose Object.getClass() or any reflection API to get
    // the runtime type of an arbitrary Object. The only available technique
    // is to attempt a cast to a known type and parse the resulting
    // TypeException message, which Salesforce embeds the actual type name in:
    //   "Invalid conversion from runtime type <ActualType> to Date"
    // This relies on an undocumented message format. If Salesforce changes it,
    // this method will silently return 'Date' for all non-Date, non-null types.
    String result = 'Date';
    try {
      Date typeCheck = (Date) callArgument;
    } catch (System.TypeException te) {
      String message = te.getMessage().substringAfter('Invalid conversion from runtime type ');
      result = message.substringBefore(' to Date');
    }
    return result;
  }

  public static Type getType(final Object callArgument) {
    final String typeName = getTypeName(callArgument);
    if (typeName == null) {
      return null;
    }
    return Type.forName(typeName);
  }

  global static Boolean areListsEqual(final List<Argument.Matchable> list1, final List<Argument.Matchable> list2) {
    if (list1 == null || list2 == null) {
      return list1 == list2;
    }

    final Integer size = list1.size();
    if (size != list2.size()) {
      return false;
    }

    for (Integer i = 0; i < size; ++i) {
      if (list1[i] != list2[i]) {
        return false;
      }
    }
    return true;
  }
}
