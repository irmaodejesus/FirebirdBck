# SYSADMIN - FIREBIRDBCK (FIREBIRD BACKUP)

## Introduction

For system administrators (SYSADMIN), efficient database management is crucial to ensure the integrity and availability of critical organizational data. In the context of systems utilizing Firebird as their Database Management System (DBMS), implementing a backup script for their multiple databases becomes a fundamental operational requirement.

This automated script enables sysadmins to perform regular and reliable backups of all Firebird databases, thereby ensuring resilience against potential data loss. Here, we will delve into the development of an effective script to perform backups on multiple Firebird databases. From initial configuration to the implementation of scheduling and monitoring routines, SYSADMINS will be guided through a step-by-step process to create a simple, robust, and scalable backup system.

With this script in operation, SYSADMINS can enjoy greater peace of mind, knowing that their data is safeguarded by an automated and dependable backup process. Let's begin creating this essential solution for effective Firebird database management.

You can learn more about the system by reading [INTRODUCTION](https://github.com/irmaodejesus/SYSADMIN.FirebirdBck/blob/8f8dc7f3e6f7bf28e50249e72fb326ab265989d2/docs/Introduction.md).

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Configuration](#configuration)
- [Uses](#uses)
- [Security Policy](#security)
- [Changelog](#changelog)
- [Contributing](#contributing)
- [Structure](#structure)
- [Tests](#tests)
- [FAQ](#faq)
- [License](#license)

## Features

- Performs daily backup of one or more firebird databases
- Keeps only the last three locally deposited backups
- Compresses and crypts daily backup
- Sends the daily backup to a remote repository, with NFS protocol.
- Rotates the remote repository while keeping the backup for the last two months
- Rotates to the remote repository while keeping the backup of the last two weeks

## Installation

See how to install [INSTALLATION](https://github.com/irmaodejesus/SYSADMIN.FirebirdBck/blob/8f8dc7f3e6f7bf28e50249e72fb326ab265989d2/docs/Installation.md).

## Configuration

How and what settings are necessary for this system to work, you can see in [CONFIGUATION](https://github.com/irmaodejesus/SYSADMIN.FirebirdBck/blob/8f8dc7f3e6f7bf28e50249e72fb326ab265989d2/docs/Configuration.md).

## Uses

Examples of use cases of these projects you can check in [USE CASES](https://github.com/irmaodejesus/SYSADMIN.FirebirdBck/blob/8f8dc7f3e6f7bf28e50249e72fb326ab265989d2/docs/Uses.md) for more details.

## Security

Our security policy can be found at [SECURITY POLICY](https://github.com/irmaodejesus/SYSADMIN.FirebirdBck/blob/4264fcd9d1ab3984809decce8f11145b21170d5a/SECURITY.md).

## Changelog

To keep track of changes to the project, see [CHANGELOG](https://github.com/irmaodejesus/SYSADMIN.FirebirdBck/blob/8f8dc7f3e6f7bf28e50249e72fb326ab265989d2/docs/Changelog.md).

## Contributing

Instructions for those who want to contribute to this project. This can include guidelines for submitting issues, creating pull requests, and any coding standards.

Please see  [CONTRIBUTING](https://github.com/irmaodejesus/SYSADMIN.FirebirdBck/blob/d8346a53c60b7fc8fc1a28178c07ea928b8e02ea/CONTRIBUTING.md)  for more details.

## Structure

To learn more about how the project is structured, see  [PROJECT STRUCTURE](https://github.com/irmaodejesus/SYSADMIN.FirebirdBck/blob/8f8dc7f3e6f7bf28e50249e72fb326ab265989d2/docs/Project_Structure.md)  for more details.

## Tests

How to run the project test suite, Please see  [TESTS](https://github.com/irmaodejesus/SYSADMIN.FirebirdBck/blob/8f8dc7f3e6f7bf28e50249e72fb326ab265989d2/docs/Tests.md) for more details.

## FAQ

To do and follow the Q&A, see our [FAQ](https://github.com/irmaodejesus/SYSADMIN.FirebirdBck/discussions/new) for more details.

## License

Include information about the licensing of your project. Mention the type of license and provide a link to the license file.

This project is licensed under the MIT License - see the [LICENSE](https://github.com/irmaodejesus/SYSADMIN.FirebirdBck/blob/d8346a53c60b7fc8fc1a28178c07ea928b8e02ea/LICENSE) file for details.
