# SYSADMIN - FIREBIRDBCK (FIREBIRD BACKUP)

## Introduction

For system administrators (SYSADMIN), efficient database management is crucial to ensure the integrity and availability of critical organizational data. In the context of systems utilizing Firebird as their Database Management System (DBMS), implementing a backup script for their multiple databases becomes a fundamental operational requirement.

This automated script enables sysadmins to perform regular and reliable backups of all Firebird databases, thereby ensuring resilience against potential data loss. Here, we will delve into the development of an effective script to perform backups on multiple Firebird databases. From initial configuration to the implementation of scheduling and monitoring routines, SYSADMINS will be guided through a step-by-step process to create a simple, robust, and scalable backup system.

With this script in operation, SYSADMINS can enjoy greater peace of mind, knowing that their data is safeguarded by an automated and dependable backup process. Let's begin creating this essential solution for effective Firebird database management.

## Table of Contents

- [License](#license)
- [Features](#features)
- [Installation](#installation)

## License

Copyright (c) [2024] [EMMANUEL T. PEIXOTO]
Licensed under the MIT License. See LICENSE file in the project root for full license information.
page official of project <https://github.com/irmaodejesus/SYSADMIN.FirebirdBck>

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

# Navigate into the project directory
cd SYSADMIN.FirebirdBck
