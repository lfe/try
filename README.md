# try.lfe.io


## Introduction

This project is currently under active development. For more information,
see the [wiki](../../wiki).


## Installation

Just add it to your ``rebar.config`` deps:

```erlang
  {deps, [
    ...
    {try.lfe.io, ".*",
      {git, "git@github.com:lfex/try.lfe.io.git", "master"}}
      ]}.
```

And then do the usual:

```bash
    $ rebar get-deps
    $ rebar compile
```


## Usage

In a development environment, simply run the ``dev`` target:

```bash
$ make dev
```

This will start up YAWS and you'll be able to view the site at [[http://localhost:5099/]]
