# Project Structure of FirebirdBck

Description of the project structure and the purpose of each folder and file.

SYSADMIN.FirebirdBck
├── src/ # Main Project Fonts
│ ├── Linux/ # Linux program Fonts
│ | ├── main/
| | | └──FirebirdBck.sh # Main system backup.
│ | ├── helpers/
| | | |__FirebirdBckSetting.sh # Populates the variables in the system configuration file.
│ | └── util/
| |   ├──FirebirdBck_Restory.sh # Function Restory database.
| |   ├──FirebirdBck_DB.sh # Function DB backups.
| |   ├──FirebirdBck_Rotation.sh # Function rotation backups.
| |   ├──FirebirdBck_MSG.env # All menssagens e variables.
| |   ├──FirebirdBck_send.sh # Functions send remote backups.
| |   └──FirebirdBck_util.sh # Functions utils for the system.
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
