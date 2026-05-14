## [Unreleased]

## [0.3.0] - 2026-05-14

### Breaking changes

- The account model (default `EtsyAccount`) must now implement a `token_expired?` instance method. If you ran the install generator in v0.2.x, you need to add this method manually. See the [migration guide](#migrating-from-v02x-to-v03x) in the README.

### Changed

- Token expiration checking now delegates to `token_expired?` on the account model instead of using inline logic in the gem
- Replaced Faraday with Ruby's stdlib `Net::HTTP`, removing the only external runtime dependency
- Declared `activesupport` as an explicit runtime dependency (was previously undeclared)

### Fixed

- Fixed `TypeError` crash in `check_token_expiration` when `expires_in` or `last_token_refresh` is nil
- Failed token refresh responses no longer save nil credentials back to the account

## [0.2.0] - 2021-05-04

- Initial release

## [0.1.0] - 2021-05-04

- Securing **Betsy** gem name
