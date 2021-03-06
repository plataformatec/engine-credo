# Credo Engine

[![Build Status](https://travis-ci.org/sourcelevel/engine-credo.svg?branch=main)](https://travis-ci.org/sourcelevel/engine-credo) [![SourceLevel](https://app.sourcelevel.io/github/sourcelevel/engine-credo.svg)](https://app.sourcelevel.io/github/sourcelevel/engine-credo)

`engine-credo` is a Docker container that wraps
[credo](http://github.com/rrrene/credo) as a standalone executable,
following the [Code Climate Engine spec](https://github.com/codeclimate/spec)
for JSON output.

`engine-credo` is available on [SourceLevel](https://sourcelevel.io) as the default engine
for reviewing Elixir code.

## Configuration

`engine-credo` will respect the `.credo.exs` configuration placed inside your
repository. For more details, see the [`Configuration`](https://github.com/rrrene/credo#configuration)
section of Credo's README.

To check available versions and engine configuration visit
[SourceLevel Credo page](https://docs.sourcelevel.io/engines/credo).

## Upgrading `credo`

To upgrade `credo` version used by this container, simply:

```
script/update-credo
```

## Publishing

It will be automatically built and pushed by `script/push` (included in
[Travis CI](https://travis-ci.org) config file described in [`after_success`](https://docs.travis-ci.com/user/job-lifecycle/) stage) on merging into `main` branch.

## Need help?

For help with `credo`,
[check out their documentation](https://github.com/rrrene/credo).
