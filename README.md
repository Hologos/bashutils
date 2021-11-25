# bashutils

This library contains several helper functions to be used with bash.

## Installation

**Important:** bash v3.2 and higher is required

Since this is a library, you should't use it alone. You should include it into your project. There are several aproaches:

### Using peru

[Peru](https://github.com/buildinspace/peru) is a tool for including others people's code into your projects.

You just define this dependency in `peru.yaml`:

```yaml
imports:
    bashutils: vendor/hologos/bashutils/  # This is where we want peru to put the module.

git module bashutils:
    url: https://github.com/Hologos/bashutils.git
```

Save it and run:

```bash
peru sync
```

This will download the library and saves it into `vendor/hologos/bashutils/`.

### Downloading the archive

1) Download archive from [the release page](https://github.com/Hologos/bashutils/releases).
2) Unpack it into `vendor/hologos/bashutils/` in your project folder.

### Cloning repo

**Important:** _If you forget to do `peru sync` after every update that contained changed `peru.yaml`, it can have undesirable consequences and can cause serious problems. Use at your own risk._

```bash
git clone https://github.com/Hologos/bashutils vendor/hologos/bashutils/
peru sync
```

### Loading the library

To include it in your project, just write:

```bash
source vendor/hologos/bashutils/bashutils
```

## List of functions

_bool_      | bashutils::is_installed()
:---------- | :--
description | Checks if program is callable.

_void_      | bashutils::terminate(message="")
:---------- | :--
description | Terminates the program with optional message.

_void_      | bashutils::invoke_sudo()
:---------- | :--
description | Requires user to enter his password for sudo.

_string_    | bashutils::basedir()
:---------- | :--
description | Gets basedir of current script.

_bool_      | bashutils::is_macos()
:---------- | :--
description | Checks if current os is macOS.

_bool_      | bashutils::is_linux()
:---------- | :--
description | Checks if current os is from linux family.

_bool_      | bashutils::is_aix()
:---------- | :--
description | Checks if current os is AIX.

_string_    | bashutils::get_os_family()
:---------- | :--
description | Gets OS family name.

_bool_      | bashutils::is_min_bash_version(_required-version_)
:---------- | :--
description | Checks if current bash version is equal or higher than required.
notes       | Format of _required-version_ is maximum of 4 groups (numbers only) that are dot separated (eg: `4.2.2.1` or `4.4`).

_void_      | bashutils::require_min_bash_version()
:---------- | :--
description | Checks if current bash version is equal or higher than required. Terminates the script is it's not.
