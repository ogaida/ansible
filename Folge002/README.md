# Ansible Folge 2

## User anlegen

### Ubuntu

Modul: user

Besonderheiten:

- `update_password: on_create`

### Windows

Module: win_user

Besonderheiten:

```
  become_method: runas
  become_user: "{{ansible_user}}"
```

## Inventory File über `ansible.cfg` setzen

siehe [https://docs.ansible.com/ansible/latest/reference_appendices/config.html](https://docs.ansible.com/ansible/latest/reference_appendices/config.html)

```
[defaults]
RETRY_FILES_ENABLED=False
host-key-checking=False
inventory=/Users/ogaida/ansible/hosts
forks = 6
```

## winrm Aktivieren

siehe:

- https://docs.ansible.com/ansible/latest/user_guide/windows_winrm.html
- https://docs.ansible.com/ansible/latest/user_guide/windows_setup.html

in der Admin-Powershell (nur für Testzwecke, nicht in prod.-Umgebungen einsetzen)

```powershell
Set-Item -Path WSMan:\localhost\Service\Auth\Basic -Value $true
```

## verwendete Kommandos

### VBoxManage

```bash
$ VBoxManage list runningvms
$ VBoxManage list vms
"ubuntu_default_1620677685084_83064" {918b6e66-485b-40a9-af07-c7095a3e8d76}
"10_default_1621168825996_85077" {4f8aa8d2-38cf-4a91-9cf5-6e7b60168e26}
$ VBoxManage startvm ubuntu_default_1620677685084_83064 --type headless
Waiting for VM "ubuntu_default_1620677685084_83064" to power on...
VM "ubuntu_default_1620677685084_83064" has been successfully started.
$ VBoxManage startvm 10_default_1621168825996_85077 --type headless
Waiting for VM "10_default_1621168825996_85077" to power on...
VM "10_default_1621168825996_85077" has been successfully started.
$ VBoxManage list runningvms
"ubuntu_default_1620677685084_83064" {918b6e66-485b-40a9-af07-c7095a3e8d76}
"10_default_1621168825996_85077" {4f8aa8d2-38cf-4a91-9cf5-6e7b60168e26}
$ VBoxManage list runningvms | awk '{print $1}' | xargs -I VM VBoxManage controlvm VM poweroff
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
$ VBoxManage list vms | awk '{print $1}' | xargs -I VM VBoxManage startvm VM --type headless
Waiting for VM "ubuntu_default_1620677685084_83064" to power on...
VM "ubuntu_default_1620677685084_83064" has been successfully started.
Waiting for VM "10_default_1621168825996_85077" to power on...
VM "10_default_1621168825996_85077" has been successfully started.
```

### installing pywinrm

```bash
$ python3 -m pip install pywinrm
Collecting pywinrm
  Downloading pywinrm-0.4.2-py2.py3-none-any.whl (44 kB)
     |████████████████████████████████| 44 kB 3.0 MB/s
Collecting xmltodict
  Downloading xmltodict-0.12.0-py2.py3-none-any.whl (9.2 kB)
Collecting requests>=2.9.1
  Downloading requests-2.25.1-py2.py3-none-any.whl (61 kB)
     |████████████████████████████████| 61 kB 8.0 MB/s
Collecting requests-ntlm>=0.3.0
  Downloading requests_ntlm-1.1.0-py2.py3-none-any.whl (5.7 kB)
Collecting six
  Downloading six-1.16.0-py2.py3-none-any.whl (11 kB)
Collecting certifi>=2017.4.17
  Downloading certifi-2020.12.5-py2.py3-none-any.whl (147 kB)
     |████████████████████████████████| 147 kB 6.5 MB/s
Collecting chardet<5,>=3.0.2
  Downloading chardet-4.0.0-py2.py3-none-any.whl (178 kB)
     |████████████████████████████████| 178 kB 6.6 MB/s
Collecting urllib3<1.27,>=1.21.1
  Downloading urllib3-1.26.4-py2.py3-none-any.whl (153 kB)
     |████████████████████████████████| 153 kB 6.9 MB/s
Collecting idna<3,>=2.5
  Downloading idna-2.10-py2.py3-none-any.whl (58 kB)
     |████████████████████████████████| 58 kB 8.0 MB/s
Collecting ntlm-auth>=1.0.2
  Downloading ntlm_auth-1.5.0-py2.py3-none-any.whl (29 kB)
Collecting cryptography>=1.3
  Downloading cryptography-3.4.7-cp36-abi3-macosx_10_10_x86_64.whl (2.0 MB)
     |████████████████████████████████| 2.0 MB 7.5 MB/s
Collecting cffi>=1.12
  Downloading cffi-1.14.5-cp39-cp39-macosx_10_9_x86_64.whl (177 kB)
     |████████████████████████████████| 177 kB 8.8 MB/s
Collecting pycparser
  Downloading pycparser-2.20-py2.py3-none-any.whl (112 kB)
     |████████████████████████████████| 112 kB 9.0 MB/s
Installing collected packages: pycparser, urllib3, idna, chardet, cffi, certifi, requests, ntlm-auth, cryptography, xmltodict, six, requests-ntlm, pywinrm
Successfully installed certifi-2020.12.5 cffi-1.14.5 chardet-4.0.0 cryptography-3.4.7 idna-2.10 ntlm-auth-1.5.0 pycparser-2.20 pywinrm-0.4.2 requests-2.25.1 requests-ntlm-1.1.0 six-1.16.0 urllib3-1.26.4 xmltodict-0.12.0
```