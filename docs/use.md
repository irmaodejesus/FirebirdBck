
## 1 - Definition of Objectives and Requirements

### * Limitations and recommendations for the use of backup scripts

These scripts are designed to create backups of multiple Firebird databases, tested with a total of 150GB and capable of handling growth up to 300GB, in a Linux environment. If the combined size of your databases exceeds 300GB, please use these scripts with caution and communicate their success or failure along with your scenario.

### * Requirements of Hardware and Software

This script was developed to be tested in a virtualized environment using the XCP-NG Hypervisor, running on a fully virtualized Linux guest system.

The Linux guest is running Ubuntu 22, equipped with 12GB of memory, network bonded at 2Gbit/s, and configured with 1 CPU comprising 2 cores. Additionally, it features 3 hard drives: one for the operating system, another dedicated to the operational database, and a third drive allocated for supporting daily backup routines.

### * Data Retention Policy

In the scenario we've set up, the backup is performed in full daily on the disk designated for backup support, placed in a folder corresponding to its day of the week, with Monday being day 1 and Sunday being day 7, compressed, and sent to an external repository.

In the external repository, every backup made on the 1st of each month is treated as monthly, and those made on the 7th of each week are treated as weekly. Only the weekly backups from the last two weeks and the monthly backups from the last two months are retained, always including the current and previous month and week.

### * Security and Data Access

Ensuring improved security of the databases, the external repository has its own security process; however, for added security, the backups are encrypted with the public-private key of the responsible department.

The external storage server has its own security measures in place. Data removal is carried out by reusing the allocated backup spaces, both on the backup support server and on the backup support HD within the server itself. Additionally, the server has its own security protocols to prevent unauthorized access to the data. Thus, these measures ensure compliance with the best data protection practices established by GDPR in the European Union, HIPAA in the United States, and LGPD in Brazil.

### * Error Notification and Alerts

### * Backup and Recovery Testing

### * Documentation and Training

### * Compatibility and Integration with Other Systems
