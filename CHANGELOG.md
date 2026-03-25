# Changelog

## [3.0.0](https://github.com/scolladon/apex-mockery/compare/v2.3.0...v3.0.0) (2026-03-25)


### ⚠ BREAKING CHANGES

* encapsulate callLog behind delegation methods on MethodSpy
* remove deprecated MethodSpy.call(List<Object>) overload

### Features

* add "global" and "matching" `once` API ([#69](https://github.com/scolladon/apex-mockery/issues/69)) ([f5bb8d9](https://github.com/scolladon/apex-mockery/commit/f5bb8d936932d11ef7bd425a591737ca4a194717))
* add "global" and "matching" `times` API ([#72](https://github.com/scolladon/apex-mockery/issues/72)) ([6e13d6a](https://github.com/scolladon/apex-mockery/commit/6e13d6a6281ef17ce224f65f1fe58427cdc2791b))
* add auto release communication bot ([#30](https://github.com/scolladon/apex-mockery/issues/30)) ([5cbdb63](https://github.com/scolladon/apex-mockery/commit/5cbdb6316220fb8e5fa05500724186d62f16f1a6))
* add call log history to concerned error messages ([2e2a460](https://github.com/scolladon/apex-mockery/commit/2e2a4602ff232c6f8ef8adaac03f23cdc6d8747a))
* add collection and string argument matchers ([816ae7b](https://github.com/scolladon/apex-mockery/commit/816ae7b8b268149a54ede0c9bae827792bfa3130))
* add Expect.that(mock).hasNoInteractions() ([25072cf](https://github.com/scolladon/apex-mockery/commit/25072cff931b1f9b3c5130482d0525a84072ff07))
* add hasBeenCalledNthWith assertion ([c7d632d](https://github.com/scolladon/apex-mockery/commit/c7d632d9be376c21e86c1279077a9a6e608d7703))
* add hasbeenCalledWith and hasBeenLastCalledWith ([#8](https://github.com/scolladon/apex-mockery/issues/8)) ([98ebbf2](https://github.com/scolladon/apex-mockery/commit/98ebbf26dd701ca168e19c50ef3560ca8033b51b))
* add names and types of method parameters in error output ([#62](https://github.com/scolladon/apex-mockery/issues/62)) ([4c6cc01](https://github.com/scolladon/apex-mockery/commit/4c6cc012b1a90c8b756f08d148a454a25642c84e))
* add notNull, negate, allOf, anyOf composite argument matchers ([afa0996](https://github.com/scolladon/apex-mockery/commit/afa09963844721b7081b36bb4b5cd9eecde24a2f))
* add recipes ([#22](https://github.com/scolladon/apex-mockery/issues/22)) ([745fed6](https://github.com/scolladon/apex-mockery/commit/745fed6566c82e5d9536298178bc17f1366ff460))
* add spy.reset(), mock.resetAll(), and mock.clear() lifecycle methods ([bb8b6c3](https://github.com/scolladon/apex-mockery/commit/bb8b6c3322e9caa883a8338039acbc502f4121ad))
* add test classes ([#4](https://github.com/scolladon/apex-mockery/issues/4)) ([770b00f](https://github.com/scolladon/apex-mockery/commit/770b00f2adabcbf270f2004ebe621e19417e9672))
* add thenThrow API to spy ([#7](https://github.com/scolladon/apex-mockery/issues/7)) ([ff32fbf](https://github.com/scolladon/apex-mockery/commit/ff32fbffe21110f1fbc791f9abdfaa201ace3fdb))
* encapsulate callLog behind delegation methods on MethodSpy ([7525943](https://github.com/scolladon/apex-mockery/commit/7525943c2de1749ee682863b6ef670f6a5586add))
* enhance assertion error messages by including call history ([#17](https://github.com/scolladon/apex-mockery/issues/17)) ([2e2a460](https://github.com/scolladon/apex-mockery/commit/2e2a4602ff232c6f8ef8adaac03f23cdc6d8747a))
* implement custom implementation behavior configuration ([#84](https://github.com/scolladon/apex-mockery/issues/84)) ([d8a4d53](https://github.com/scolladon/apex-mockery/commit/d8a4d531740f3a9ce22bd55d333cd6bb1e6555d3))
* implement whenCalledWithParams using ParameterMatcher ([#10](https://github.com/scolladon/apex-mockery/issues/10)) ([127359c](https://github.com/scolladon/apex-mockery/commit/127359c417a9ac4d164451588f720caa0970bbf9))
* improve configuration error messages ([#21](https://github.com/scolladon/apex-mockery/issues/21)) ([3670ce8](https://github.com/scolladon/apex-mockery/commit/3670ce85e8ea602bad9d4d0ec56c0b31b48aebcb))
* improve existing functional test ([#11](https://github.com/scolladon/apex-mockery/issues/11)) ([f2b5760](https://github.com/scolladon/apex-mockery/commit/f2b576072e26278c019344df3fdd16e22ea55874))
* Improve naming and concept segregation ([#50](https://github.com/scolladon/apex-mockery/issues/50)) ([4e35e09](https://github.com/scolladon/apex-mockery/commit/4e35e09380af8ea8a34462a519a2c6b64bcb4fc2))
* improve README content ([#2](https://github.com/scolladon/apex-mockery/issues/2)) ([64dd0fc](https://github.com/scolladon/apex-mockery/commit/64dd0fc4dbb4c6c90e24a29f195deb0795a8df59))
* introduce convenient API to avoid Params usage ([#25](https://github.com/scolladon/apex-mockery/issues/25)) ([6d9efa4](https://github.com/scolladon/apex-mockery/commit/6d9efa4af9eea1a91fcaf3dc1a1540ec009f0422))
* migrate from `parameter` concept to `argument` ([#45](https://github.com/scolladon/apex-mockery/issues/45)) ([ec16b56](https://github.com/scolladon/apex-mockery/commit/ec16b567cbfffc6391f7ad3d8936b3902f075774))
* remove deprecated MethodSpy.call(List&lt;Object&gt;) overload ([1b2caa8](https://github.com/scolladon/apex-mockery/commit/1b2caa87f666a426b65cc2b9abab13a57d1d9fe5))


### Bug Fixes

* case for IsTest and Datetime ([#86](https://github.com/scolladon/apex-mockery/issues/86)) ([92817cc](https://github.com/scolladon/apex-mockery/commit/92817cc972c805a4fb810544b71093bcc2e3bac9))
* case insensitive matching for mock ([#75](https://github.com/scolladon/apex-mockery/issues/75)) ([37f958e](https://github.com/scolladon/apex-mockery/commit/37f958e3872227b1099bf284a717fb322a839eda))
* enhance docs and samples readability ([#24](https://github.com/scolladon/apex-mockery/issues/24)) ([9fe4611](https://github.com/scolladon/apex-mockery/commit/9fe461107587f5144d4f1bc47103119f46676ec7))
* issue when punctual matchers are consumed ([#77](https://github.com/scolladon/apex-mockery/issues/77)) ([a07d6a1](https://github.com/scolladon/apex-mockery/commit/a07d6a11cfe2448df6783fee36748f33c358605a))
* not usable unlocked package without namespace ([#39](https://github.com/scolladon/apex-mockery/issues/39)) ([41c71df](https://github.com/scolladon/apex-mockery/commit/41c71dffbb61e4fa0a83c04fa740ff1590be890c))
* quality, correctness and maintenance improvements ([06713e6](https://github.com/scolladon/apex-mockery/commit/06713e6cf7d4a0d4357f3fabc40bdedd9ec8099c))
* small cleanup ([#26](https://github.com/scolladon/apex-mockery/issues/26)) ([30aede9](https://github.com/scolladon/apex-mockery/commit/30aede9aa7aaa0e7c779d1cea505dfa07c62de63))
* spy calls with newer SObjects (and misc. updates) ([#63](https://github.com/scolladon/apex-mockery/issues/63)) ([d914655](https://github.com/scolladon/apex-mockery/commit/d91465551026e4034fa7c75fc2ec243c4c595dd1))

## [2.3.0](https://github.com/salesforce/apex-mockery/compare/v2.2.0...v2.3.0) (2025-01-31)


### Features

* implement custom implementation behavior configuration ([#84](https://github.com/salesforce/apex-mockery/issues/84)) ([d8a4d53](https://github.com/salesforce/apex-mockery/commit/d8a4d531740f3a9ce22bd55d333cd6bb1e6555d3))


### Bug Fixes

* case for IsTest and Datetime ([#86](https://github.com/salesforce/apex-mockery/issues/86)) ([92817cc](https://github.com/salesforce/apex-mockery/commit/92817cc972c805a4fb810544b71093bcc2e3bac9))

## [2.2.0](https://github.com/salesforce/apex-mockery/compare/v2.1.0...v2.2.0) (2024-11-29)


### Features

* add "global" and "matching" `once` API ([#69](https://github.com/salesforce/apex-mockery/issues/69)) ([f5bb8d9](https://github.com/salesforce/apex-mockery/commit/f5bb8d936932d11ef7bd425a591737ca4a194717))
* add "global" and "matching" `times` API ([#72](https://github.com/salesforce/apex-mockery/issues/72)) ([6e13d6a](https://github.com/salesforce/apex-mockery/commit/6e13d6a6281ef17ce224f65f1fe58427cdc2791b))
* add names and types of method parameters in error output ([#62](https://github.com/salesforce/apex-mockery/issues/62)) ([4c6cc01](https://github.com/salesforce/apex-mockery/commit/4c6cc012b1a90c8b756f08d148a454a25642c84e))


### Bug Fixes

* case insensitive matching for mock ([#75](https://github.com/salesforce/apex-mockery/issues/75)) ([37f958e](https://github.com/salesforce/apex-mockery/commit/37f958e3872227b1099bf284a717fb322a839eda))
* issue when punctual matchers are consumed ([#77](https://github.com/salesforce/apex-mockery/issues/77)) ([a07d6a1](https://github.com/salesforce/apex-mockery/commit/a07d6a11cfe2448df6783fee36748f33c358605a))
* spy calls with newer SObjects (and misc. updates) ([#63](https://github.com/salesforce/apex-mockery/issues/63)) ([d914655](https://github.com/salesforce/apex-mockery/commit/d91465551026e4034fa7c75fc2ec243c4c595dd1))

## [2.1.0](https://github.com/salesforce/apex-mockery/compare/v2.0.0...v2.1.0) (2023-05-12)


### Features

* Improve naming and concept segregation ([#50](https://github.com/salesforce/apex-mockery/issues/50)) ([4e35e09](https://github.com/salesforce/apex-mockery/commit/4e35e09380af8ea8a34462a519a2c6b64bcb4fc2))

## [2.0.0](https://github.com/salesforce/apex-mockery/compare/v1.1.0...v2.0.0) (2023-05-05)


### Features

* migrate from `parameter` concept to `argument` ([#45](https://github.com/salesforce/apex-mockery/issues/45)) ([ec16b56](https://github.com/salesforce/apex-mockery/commit/ec16b567cbfffc6391f7ad3d8936b3902f075774))

### Refactorings

* rename `Assertions.assertThat` in `Expect.that` ([#47](https://github.com/salesforce/apex-mockery/issues/47)) ([7d74eb8](https://github.com/salesforce/apex-mockery/commit/7d74eb8a7644ef181dcb83eeb1811397cf3d0ac4))

## [1.1.0](https://github.com/salesforce/apex-mockery/compare/v1.0.0...v1.1.0) (2023-03-09)


### Bug Fixes

* not usable unlocked package without namespace ([#39](https://github.com/salesforce/apex-mockery/issues/39)) ([41c71df](https://github.com/salesforce/apex-mockery/commit/41c71dffbb61e4fa0a83c04fa740ff1590be890c))

## 1.0.0 (2023-02-22)


### Features

* add auto release communication bot ([#30](https://github.com/salesforce/apex-mockery/issues/30)) ([5cbdb63](https://github.com/salesforce/apex-mockery/commit/5cbdb6316220fb8e5fa05500724186d62f16f1a6))
* add call log history to concerned error messages ([2e2a460](https://github.com/salesforce/apex-mockery/commit/2e2a4602ff232c6f8ef8adaac03f23cdc6d8747a))
* add hasbeenCalledWith and hasBeenLastCalledWith ([#8](https://github.com/salesforce/apex-mockery/issues/8)) ([98ebbf2](https://github.com/salesforce/apex-mockery/commit/98ebbf26dd701ca168e19c50ef3560ca8033b51b))
* add recipes ([#22](https://github.com/salesforce/apex-mockery/issues/22)) ([745fed6](https://github.com/salesforce/apex-mockery/commit/745fed6566c82e5d9536298178bc17f1366ff460))
* add test classes ([#4](https://github.com/salesforce/apex-mockery/issues/4)) ([770b00f](https://github.com/salesforce/apex-mockery/commit/770b00f2adabcbf270f2004ebe621e19417e9672))
* add thenThrow API to spy ([#7](https://github.com/salesforce/apex-mockery/issues/7)) ([ff32fbf](https://github.com/salesforce/apex-mockery/commit/ff32fbffe21110f1fbc791f9abdfaa201ace3fdb))
* enhance assertion error messages by including call history ([#17](https://github.com/salesforce/apex-mockery/issues/17)) ([2e2a460](https://github.com/salesforce/apex-mockery/commit/2e2a4602ff232c6f8ef8adaac03f23cdc6d8747a))
* implement whenCalledWithParams using ParameterMatcher ([#10](https://github.com/salesforce/apex-mockery/issues/10)) ([127359c](https://github.com/salesforce/apex-mockery/commit/127359c417a9ac4d164451588f720caa0970bbf9))
* improve configuration error messages ([#21](https://github.com/salesforce/apex-mockery/issues/21)) ([3670ce8](https://github.com/salesforce/apex-mockery/commit/3670ce85e8ea602bad9d4d0ec56c0b31b48aebcb))
* improve existing functional test ([#11](https://github.com/salesforce/apex-mockery/issues/11)) ([f2b5760](https://github.com/salesforce/apex-mockery/commit/f2b576072e26278c019344df3fdd16e22ea55874))
* improve README content ([#2](https://github.com/salesforce/apex-mockery/issues/2)) ([64dd0fc](https://github.com/salesforce/apex-mockery/commit/64dd0fc4dbb4c6c90e24a29f195deb0795a8df59))
* introduce convenient API to avoid Params usage ([#25](https://github.com/salesforce/apex-mockery/issues/25)) ([6d9efa4](https://github.com/salesforce/apex-mockery/commit/6d9efa4af9eea1a91fcaf3dc1a1540ec009f0422))


### Bug Fixes

* enhance docs and samples readability ([#24](https://github.com/salesforce/apex-mockery/issues/24)) ([9fe4611](https://github.com/salesforce/apex-mockery/commit/9fe461107587f5144d4f1bc47103119f46676ec7))
* small cleanup ([#26](https://github.com/salesforce/apex-mockery/issues/26)) ([30aede9](https://github.com/salesforce/apex-mockery/commit/30aede9aa7aaa0e7c779d1cea505dfa07c62de63))
