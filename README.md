## Installation
  1. [Install Ansible](http://docs.ansible.com/intro_installation.html).
  2. Clone this repository to your local drive.
  3. Run `$ ansible-galaxy install -r requirements.yml` inside this directory to install required Ansible roles.
  4. Run `ansible-playbook main.yml -i inventory -K` inside this directory. Enter your account password when prompted.


## Running a specific set of tagged tasks

You can filter which part of the provisioning process to run by specifying a set of tags using `ansible-playbook`'s `--tags` flag. The tags available are `dotfiles`, `homebrew`, `mas`, `extra-packages` and `osx`.

    ansible-playbook main.yml -i inventory -K --tags "dotfiles,homebrew"