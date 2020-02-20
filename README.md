# <img src="https://user-images.githubusercontent.com/4738426/33545371-e652d482-d8d5-11e7-9ea5-c676d9313378.png" height="50"/>

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
