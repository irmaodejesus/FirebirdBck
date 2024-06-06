# Project Structure of FirebirdBck

Description of the project structure and the purpose of each folder and file.

SYSADMIN.FirebirdBck
├── src/ # Main Project Fonts
│ ├── Linux/ # Linux program Fonts
│ | ├── main/
| | | ├──FirebirdBckRestory.sh # Restory database.
| | | ├──FirebirdBckNFS.sh # Backup and send NFS.
| | | ├──FirebirdBckCtrSVC.sh # Turn the backup service on and off.
| | | ├──FirebirdBckDB.sh # Makes the dp DB backup presented.
| | | └──FirebirdBckNFSMount.sh # Mount the NFS share.
│ | ├── helpers/
| | | |__FirebirdBckSetting.sh # Populates the variables in the system configuration file.
│ | └── util/
| |   ├──FirebirdBckDYLocRot.sh # rotates the backup daily on local storage.
| |   ├──FirebirdBckDYRemRot.sh # rotates the backup daily on remote storage.
| |   ├──FirebirdBckDYSend.sh # Sends the daily backup to the remote storage.
| |   ├──FirebirdBckMORemRot.sh # rotates the monthly backup on remote storage.
| |   └──FirebirdBckWKRemRot.sh # rotates the weekly backup on remote storage.
│ └── Windows/ # Windows program Fonts
│   ├── main/
│   ├── helpers/
│   └── util/
├── tests/ # Main Project tests
│ ├── Windows/ # Windows tests
│ | ├── main/
│ | ├── helpers/
│ | └── util/
│ └── Linux/ # Linux tests
│   ├── main/
│   ├── helpers/
│   └── util/
├── docs/ # Project Documentation
│ ├── Introduction.md # Introductory Document
│ ├── Project_Structure.md # Project Structure Description
│ ├── Installation.md # Installation Instructions
│ ├── Uses.md # Examples of Use
│ ├── Configuration.md # How to set up the project.
│ ├── Tests.md # How to run the project test suite.
│ ├── FAQs.md # Instructions for adding new tests to the project.
│ └── Changelog.md # Record of all important changes in the project.
├── configs/ # configurations files.
│ └── FirebirdBck.conf # Main configuration file.
├── scripts/ # Auxiliary scripts
│ ├── FirebirdBckInstall.sh # Script to deploy linux project via direct download.
│ ├── start.sh # Script to start linux project
│ └── deploy.sh # Script to deploy the linux project
├── github/
├── LICENSE # Project License
├── README.md # Overview & Quick Instructions
├── SECURITY.md # Quick Instructions on System Security
└── CONTRIBUTING.md # Information for Contributors
