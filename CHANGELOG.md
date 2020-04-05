# CHANGELOG

## 2018-12-13
Initial version.

## 2019-04-28 `0.2.0`
- support for pictures inside ID3v2 tags.
- Rust 2018 edition!
    - dropped support for `rustc < 1.3.1`
- banged functions (ex. `ID3.get_tag!/1`)
- `new` functions for some structs

## 2019-05-02 `1.0.0`
- Changed `ID3.write_tag/2`'s argument positions
  - better piping

## 2020-04-06 `1.0.1`
- fix: Rust files weren't uploaded to hex.pm
- updated rustler to `0.21.0`
    - now supports OTP22
- updated rust-id3 to `0.5.0`
    - doesn't change this library's functionality for now
