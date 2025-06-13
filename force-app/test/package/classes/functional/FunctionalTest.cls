/*
 * Copyright (c) 2022, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
@IsTest
private class FunctionalTest {
  @IsTest
  static void whenCreatingNewCompany_itShouldInsertAccount() {
    // Arrange
    Mock dmlDelegateMock = Mock.forType(DMLDelegate.class);
    MethodSpy insertSObjectSpy = dmlDelegateMock.spyOn('insertSObject');
    BusinessService sut = new BusinessService((DMLDelegate) dmlDelegateMock.stub);

    // Act
    sut.createNewCompany(10);

    // Assert
    Expect.that(insertSObjectSpy).hasBeenCalledWith(Argument.of(new Account(NumberOfEmployees = 10)));
  }

  @IsTest
  static void whenCreatingNewCompanyWithOpportunity_itShouldInsertAccountAndOpportunity() {
    // Arrange
    Mock dmlDelegateMock = Mock.forType(DMLDelegate.class);
    MethodSpy insertSObjectSpy = dmlDelegateMock.spyOn('insertSObject');

    insertSObjectSpy.whenCalledWith(Argument.of(Argument.ofType(Account.getSObjectType()))).thenReturn(succeed('001000000000000AAA'));

    insertSObjectSpy.whenCalledWith(Argument.of(Argument.ofType(Opportunity.getSObjectType()))).thenReturnOnce(succeed('006000000000000AAA'));

    BusinessService sut = new BusinessService((DMLDelegate) dmlDelegateMock.stub);

    // Act
    sut.createNewCompanyWithOpportunity(10);

    // Assert
    Account expectedAccount = new Account(NumberOfEmployees = 10);
    Expect.that(insertSObjectSpy).hasBeenCalledWith(Argument.of(expectedAccount));
    Expect.that(insertSObjectSpy).hasBeenCalledWith(Argument.of(new Opportunity(AccountId = '001000000000000AAA')));
    Expect.that(insertSObjectSpy).hasBeenCalledTimes(2);
  }

  @IsTest
  static void whenCreatingNewCompanyWith1BEmployees_itThrows() {
    // Arrange
    Mock dmlDelegateMock = Mock.forType(DMLDelegate.class);
    MethodSpy insertSObjectSpy = dmlDelegateMock.spyOn('insertSObject');
    insertSObjectSpy.throwsException(new DmlException('1 billion person cannot work in the same company'));

    BusinessService sut = new BusinessService((DMLDelegate) dmlDelegateMock.stub);

    // Act
    try {
      sut.createNewCompany(1000000000);

      // Assert
      Assert.fail('it shoud not reach this line');
    } catch (DmlException dex) {
      Expect.that(insertSObjectSpy).hasBeenCalledWith(Argument.of(new Account(NumberOfEmployees = 1000000000)));
    }
  }

  @IsTest
  static void whenCreatingNewCompaniesWithAllOrNoneFalseAndPartialSuccess_itReturnsSaveResult() {
    // Arrange
    Mock dmlDelegateMock = Mock.forType(DMLDelegate.class);
    MethodSpy insertSObjectsSpy = dmlDelegateMock.spyOn('insertSObjects');
    MethodSpy rollbackSpy = dmlDelegateMock.spyOn('rollBack');

    insertSObjectsSpy.returns(
      partial(new List<Id>{ '001000000000000AAA' }, new List<DBError>{ new DBError('Error is located approximately between the chair and the monitor', '30') })
    );

    BusinessService sut = new BusinessService((DMLDelegate) dmlDelegateMock.stub);

    // Act
    sut.createNewCompanies(new List<Integer>{ 10, 10 });

    // Assert
    Database.DMLOptions dmlOptions = new Database.DMLOptions();
    dmlOptions.optAllOrNone = false;
    Account expectedAccount = new Account(NumberOfEmployees = 10);
    Expect.that(insertSObjectsSpy)
      .hasBeenCalledWith(Argument.of(Argument.jsonEquals(new List<Account>{ expectedAccount, expectedAccount }), Argument.jsonEquals(dmlOptions)));
    Expect.that(rollbackSpy).hasBeenCalled();
  }

  static Database.SaveResult succeed(Id recordId) {
    return (Database.SaveResult) JSON.deserialize('{"success":true,"id":"' + recordId + '"}', Database.SaveResult.class);
  }

  static Database.SaveResult[] succeed(List<Id> recordIds) {
    List<Database.SaveResult> results = new List<Database.SaveResult>();
    for (Id recordId : recordIds) {
      results.add(succeed(recordId));
    }
    return results;
  }

  static Database.SaveResult failed(DBError dbError) {
    return (Database.SaveResult) JSON.deserialize(
      '{"success":false,"errors":[{"message":"' + dbError.message + '","statusCode":"' + dbError.statusCode + '"}]}',
      Database.SaveResult.class
    );
  }

  static Database.SaveResult[] failed(List<DBError> dbErrors) {
    List<Database.SaveResult> results = new List<Database.SaveResult>();
    for (DBError dbError : dbErrors) {
      results.add(failed(dbError));
    }
    return results;
  }

  static Database.SaveResult[] partial(List<Id> successIds, List<DBError> dbErrors) {
    List<Database.SaveResult> results = new List<Database.SaveResult>();

    results.addall(succeed(successIds));
    results.addall(failed(dbErrors));

    return results;
  }

  class DBError {
    public String message;
    public String statusCode;

    public DBError(String message, String statusCode) {
      this.message = message;
      this.statusCode = statusCode;
    }
  }
}
