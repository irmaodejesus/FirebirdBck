# Configuration

Detailed information on how to set up the project.

## Environment Variables

List of environment variables and their descriptions.

## Configuration Files

Description of the configuration files and how to use them.

## Data Retention Policy

In the scenario we've set up, the backup is performed in full daily on the disk designated for backup support, placed in a folder corresponding to its day of the week, with Monday being day 1 and Sunday being day 7, compressed, and sent to an external repository.

In the external repository, every backup made on the 1st of each month is treated as monthly, and those made on the 7th of each week are treated as weekly. Only the weekly backups from the last two weeks and the monthly backups from the last two months are retained, always including the current and previous month and week.

## Security and Data Access

Ensuring improved security of the databases, the external repository has its own security process; however, for added security, the backups are encrypted with the public-private key of the responsible department.

The external storage server has its own security measures in place. Data removal is carried out by reusing the allocated backup spaces, both on the backup support server and on the backup support HD within the server itself. Additionally, the server has its own security protocols to prevent unauthorized access to the data. Thus, these measures ensure compliance with the best data protection practices established by GDPR in the European Union, HIPAA in the United States, and LGPD in Brazil.
