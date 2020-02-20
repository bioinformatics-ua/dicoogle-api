# <img src="docs/static/images/webapi/webapi_full_dark.png" height="100"/>

This repository contains the source code and generation scripts of the Dicoogle API website.

[Please click here to enter the website.](https://bioinformatics-ua.github.io/dicoogle-api/)

## Building

There is a Makefile available to build both the Javadoc and the Web API documentations. The instalation of git is required.

To build the Javadoc, run:

```sh
  make javadoc
```

To build the Web API, run:

```sh
  make webapi
```

You may also define which version to build:
```sh
  make javadoc-v2.5.0 
```

To build all the versions available to both Javadoc and Web API:
You may also define which version to build:
```sh
  make 
```
