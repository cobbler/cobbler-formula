# Changelog

## [1.4.1](https://github.com/cobbler/cobbler-formula/compare/v1.4.0...v1.4.1) (2026-07-18)


### Bug Fixes

* **kitchen:** require "time" after Bundler setup, not via RUBYOPT ([a557344](https://github.com/cobbler/cobbler-formula/commit/a55734477211f53c9f734fd0f45581dcbf1d5571))
* **package:** refresh Cobbler 3.3.x community repository OS support ([162c786](https://github.com/cobbler/cobbler-formula/commit/162c786f133699bd4e490036e5bc31ae5fd71327))
* **parameters:** correct EPEL package name for AlmaLinux/Rocky Linux 9 ([e45772e](https://github.com/cobbler/cobbler-formula/commit/e45772e8f8ab2382e8ad89a2d264c3041965d597))


### Build System

* **deps:** bump actions/checkout from 3.6.0 to 7.0.0 ([edec0db](https://github.com/cobbler/cobbler-formula/commit/edec0dba1582190c2b3aa0f505bf87f697d848d1))
* **deps:** bump actions/setup-node from 3.9.1 to 7.0.0 ([d7b039e](https://github.com/cobbler/cobbler-formula/commit/d7b039e0e23fe7a00451cf1d58765749ff8eb5d9))
* **deps:** bump actions/setup-python from 3.1.4 to 6.3.0 ([0bee066](https://github.com/cobbler/cobbler-formula/commit/0bee0662b8207c535066478b2963942eae152426))
* **deps:** bump wagoid/commitlint-github-action from 1.8.0 to 6.2.1 ([623e9ca](https://github.com/cobbler/cobbler-formula/commit/623e9cacc825a0eb28902827c53f587eaedbc45b))


### Continuous Integration

* add version comments and add dependabot ([933f384](https://github.com/cobbler/cobbler-formula/commit/933f38474213d5e28113c830166571235360c931))
* **lint:** pin setup-python to 3.11 to fix rstcheck build ([8c1fd2b](https://github.com/cobbler/cobbler-formula/commit/8c1fd2b95f411dbe2e6e7dbf642056c9d6538976))
* pin GitHub Actions to commit SHAs ([e8417ba](https://github.com/cobbler/cobbler-formula/commit/e8417bae06fed2fa02616ad40e6dd7bbfb0050f2))
* replace pre-commit/action with pinned inline steps ([8c3fc56](https://github.com/cobbler/cobbler-formula/commit/8c3fc56d3e053192a64f355018deab256a5eda36))
* **test:** disable RPM-based platforms in CI, see [#17](https://github.com/cobbler/cobbler-formula/issues/17) ([1f57e7b](https://github.com/cobbler/cobbler-formula/commit/1f57e7b1ebaadcb83552a81ecb89c06c273c87bd))


### Documentation

* **tofs:** make repeated "design guidelines" link anonymous ([ad4bd75](https://github.com/cobbler/cobbler-formula/commit/ad4bd75dec661eebfdcfe2b45f8564b635f15dcd))


### Tests

* add _mapdata fixtures for newly active kitchen platforms ([6aa1e4b](https://github.com/cobbler/cobbler-formula/commit/6aa1e4bc003e11642db2c29a2dc1bb085377175f))
* **kitchen:** lower SSH ready timeout from 10m to 3m ([b47bd31](https://github.com/cobbler/cobbler-formula/commit/b47bd312c2123a9e3d2b0a08419a75d99b53715e))
* **kitchen:** work around opensuse-tumbleweed dependency conflict ([ae7f39d](https://github.com/cobbler/cobbler-formula/commit/ae7f39d83ee715ee888e1ecef5439d4f6f221da2))
* update testmatrix for kitchen ([42e6ad6](https://github.com/cobbler/cobbler-formula/commit/42e6ad604f42ab20f23631da749e8d4e8b811dc3))

# [1.4.0](https://github.com/cobbler/cobbler-formula/compare/v1.3.0...v1.4.0) (2024-06-17)


### Features

* **config:** add default configuration files ([76b95f3](https://github.com/cobbler/cobbler-formula/commit/76b95f36990d5ff2b073c790d77e979b8770ff68))

# [1.3.0](https://github.com/cobbler/cobbler-formula/compare/v1.2.0...v1.3.0) (2023-11-21)


### Features

* **service:** add cobblerd management ([10f2da8](https://github.com/cobbler/cobbler-formula/commit/10f2da8c6dada2de4106386d11348b78130fa734))

# [1.2.0](https://github.com/cobbler/cobbler-formula/compare/v1.1.0...v1.2.0) (2023-11-21)


### Bug Fixes

* **formula:** fixup description for metadata ([a91a147](https://github.com/cobbler/cobbler-formula/commit/a91a147b1d02f527419ebb33a9a5c6b179da3976))


### Features

* **formula:** install Cobbler from OS, community or epel ([630ccad](https://github.com/cobbler/cobbler-formula/commit/630ccad104ae0c25131f81353176648bc5d2c483))

# [1.1.0](https://github.com/cobbler/cobbler-formula/compare/v1.0.1...v1.1.0) (2023-11-17)


### Bug Fixes

* **formula:** example pillar ([aed0e0c](https://github.com/cobbler/cobbler-formula/commit/aed0e0cba924413f803475d0733fdfa56dbea8d6))


### Continuous Integration

* **github:** don't fail fast ([548b166](https://github.com/cobbler/cobbler-formula/commit/548b1667d23a58f63bb1aa172c299c2c3c660e95))


### Features

* **formula:** define supported operating sytems ([0c609a9](https://github.com/cobbler/cobbler-formula/commit/0c609a979f1934d153afbe4894a764059923f385))

## [1.0.1](https://github.com/cobbler/cobbler-formula/compare/v1.0.0...v1.0.1) (2023-11-17)


### Bug Fixes

* remove unused subcomponent ([7e18551](https://github.com/cobbler/cobbler-formula/commit/7e185518fb29972092b221e2d6322b095d682ff1))

# 1.0.0 (2023-09-15)


### Build System

* **semantic-release:** fixup repo URL ([e24e9b3](https://github.com/cobbler/cobbler-formula/commit/e24e9b3ebd5c8aa50e3a1c165143058abb5c6360))
* **semantic-release:** switch release pattern ([127cd26](https://github.com/cobbler/cobbler-formula/commit/127cd26ac90a84dad5b08aafdc3032c0875d07b9))


### Continuous Integration

* **github:** enable actions workflows ([e0f810d](https://github.com/cobbler/cobbler-formula/commit/e0f810d7e2c598bd394aae627c8951f59fd28af7))
* **github:** switch to main branch ([61b9654](https://github.com/cobbler/cobbler-formula/commit/61b9654b8b5519cc0262ccf8dda8a11900746677))
* **pre-commit:** bump salt-lint ([76eb2cc](https://github.com/cobbler/cobbler-formula/commit/76eb2cc15c61938d9c827e275b58e2a63388b0f5))
* **semantic-release:** add package.json ([3af9161](https://github.com/cobbler/cobbler-formula/commit/3af91615c6d6798cc958ba7101a2ccd7a9a391c1))


### Documentation

* **readme:** switch github badge url to main ([1378197](https://github.com/cobbler/cobbler-formula/commit/1378197b9b3651af5cce8190372c568a5a86e5a5))
* **readme:** switch to github badge ([4c78163](https://github.com/cobbler/cobbler-formula/commit/4c78163fef16236a635f8131ed9ebd0e6f9671bd))


### Features

* convert `template-formula` to `cobbler-formula` ([3f491cb](https://github.com/cobbler/cobbler-formula/commit/3f491cbb29c0c2027984bfc26762d16db53c31a5))
* initial commit ([713c58f](https://github.com/cobbler/cobbler-formula/commit/713c58f11f6742eff0baed7f4cb4d23221f2d834))


### Tests

* **kitchen:** remove amazonlinux from testing ([64fb4a8](https://github.com/cobbler/cobbler-formula/commit/64fb4a8fb860b997f0634ee5d31d5a8d9b016e5a))


### BREAKING CHANGES

* changed all state names and ids
