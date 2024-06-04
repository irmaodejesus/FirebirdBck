# Installation

Detailed instructions for installing and configuring the project.

## Prerequisites

### Limitations and recommendations for the use of backup scripts

These scripts are designed to create backups of multiple Firebird databases, tested with a total of 150GB and capable of handling growth up to 300GB, in a Linux environment. If the combined size of your databases exceeds 300GB, please use these scripts with caution and communicate their success or failure along with your scenario.

### Requirements of Hardware and Software

This script was developed to be tested in a virtualized environment using the XCP-NG Hypervisor, running on a fully virtualized Linux guest system.

The Linux guest is running Ubuntu 22, equipped with 12GB of memory, network bonded at 2Gbit/s, and configured with 1 CPU comprising 2 cores. Additionally, it features 3 hard drives: one for the operating system, another dedicated to the operational database, and a third drive allocated for supporting daily backup routines.

## Installation Steps

1. Clone the repository:

  ```bash
    git clone  https://github.com/irmaodejesus/SYSADMIN.FirebirdBck.git
    cd SYSADMIN.FirebirdBck
    ```

2. Install the dependencies:

   ```bash
    dnf install cron vim
    ```
