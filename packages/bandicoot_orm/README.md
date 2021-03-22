# Bandicoot ORM

## Introduction

Bandicoot ORM is a simple ORM for quickly modeling and creating entities. No code generation or reflection required. Currently, this is package still a work in progress.

Currently, Postgres is the only supported database, but we hope to add support for more databases in the future.

## Creating an Entity

An example of a user entity being created.

```dart
Entity UserEntity = Entity('user')
  ..column(
    name: UserColumn.id,
    type: DataType.Primary(),
  )
  ..column(
    name: UserColumn.uuid,
    type: DataType.UUID(),
  )
  ..column(
    name: UserColumn.firstName,
    type: DataType.String(30),
  )
  ..column(
    name: UserColumn.lastName,
    type: DataType.String(30),
  )
  ..column(
    name: UserColumn.emailAddress,
    type: DataType.String(50),
  );
```
