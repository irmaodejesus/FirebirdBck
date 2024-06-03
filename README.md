# SYSADMIN - FIREBIRDBCK (FIREBIRD BACKUP)

## Introduction

For system administrators (SYSADMIN), efficient database management is crucial to ensure the integrity and availability of critical organizational data. In the context of systems utilizing Firebird as their Database Management System (DBMS), implementing a backup script for their multiple databases becomes a fundamental operational requirement.

This automated script enables sysadmins to perform regular and reliable backups of all Firebird databases, thereby ensuring resilience against potential data loss. Here, we will delve into the development of an effective script to perform backups on multiple Firebird databases. From initial configuration to the implementation of scheduling and monitoring routines, SYSADMINS will be guided through a step-by-step process to create a simple, robust, and scalable backup system.

With this script in operation, SYSADMINS can enjoy greater peace of mind, knowing that their data is safeguarded by an automated and dependable backup process. Let's begin creating this essential solution for effective Firebird database management.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Contributing](#contributing)
- [License](#license)

## Features

- Performs daily backup of one or more firebird databases
- Keeps only the last three locally deposited backups
- Compresses and crypts daily backup
- Sends the daily backup to a remote repository, with NFS protocol.
- Rotates the remote repository while keeping the backup for the last two months
- Rotates to the remote repository while keeping the backup of the last two weeks

## Installation

```bash
# Clone the repository
git clone https://github.com/irmaodejesus/SYSADMIN.FirebirdBck.git
```

```bash
# Navigate into the project directory
cd SYSADMIN.FirebirdBck
```

## CONTRIBUTING

Instructions for those who want to contribute to your project. This can include guidelines for submitting issues, creating pull requests, and any coding standards.

Please see  [CONTRIBUTING](https://github.com/irmaodejesus/SYSADMIN.FirebirdBck/blob/d8346a53c60b7fc8fc1a28178c07ea928b8e02ea/CONTRIBUTING.md)  for more details.

## License

Include information about the licensing of your project. Mention the type of license and provide a link to the license file.

This project is licensed under the MIT License - see the [LICENSE.MD](https://github.com/irmaodejesus/SYSADMIN.FirebirdBck/blob/d8346a53c60b7fc8fc1a28178c07ea928b8e02ea/LICENSE) .md file for details.
