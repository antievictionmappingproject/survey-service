survey service
==============

[![Build Status](https://snap-ci.com/antievictionmappingproject/survey-service/branch/master/build_image)](https://snap-ci.com/antievictionmappingproject/survey-service/branch/master)

Micro service for the anti eviction mapping project's survey data.

## System Requirements

1. VirtualBox
2. Vagrant

## Setup

```
./go deploy
```

## Usage

```
./go migrate
```
Create database and run migrations

```
./go start
```
Run the survey service locally

```
./go test
```
Run rspec tests for the survey service