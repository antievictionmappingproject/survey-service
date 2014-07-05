survey service
==============

Micro service for the anti eviction mapping project's survey data.

## Requirements

1. SQLite ```brew install sqlite```

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