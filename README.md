# Samba Setup Script for Linux Mint 22

This repository contains a simple Bash script that automates the installation and configuration of a Samba file share on a Linux Mint 22 system.

## Features

* Installs Samba if not already installed
* Prompts for:

  * Samba username
  * Samba password (hidden input)
  * Directory path to be shared
* Creates the directory if it doesn't exist
* Sets user ownership and full access permissions on the share
* Appends a share configuration block to `/etc/samba/smb.conf`
* Restarts the Samba service to apply changes

## Usage

### Step 1: Clone the repository

```bash
git clone https://github.com/your-username/samba-setup-script.git
cd samba-setup-script
```

### Step 2: Make the script executable

```bash
chmod +x samba-setup.sh
```

### Step 3: Run the script as root

```bash
sudo ./samba-setup.sh
```

Follow the prompts to enter:

* The desired Samba username
* A secure password for that user
* The directory you want to share (e.g. `/srv/samba/share`)

## Example

```
Enter the Samba username: thomas
Enter the Samba password: ******
Enter the full path of the directory to share: /home/thomas/shared
```

The share will be added under the name `[thomas-share]` and accessible only to the `thomas` Samba user.

## Notes

* The script adds the user with no login shell and no home directory if the system user does not already exist.
* Make sure to allow Samba ports (137-139, 445) through your firewall if accessing the share from another machine.

## License

This project is licensed under the MIT License.
