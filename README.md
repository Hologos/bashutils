# bashutils

This library contains several helper functions to be used with bash.

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
