# ForemanHostExtraValidator

This plugin adds extra validations to a host.
Currently this only supports adding a regex validator for a hostname.

## Installation

See [How_to_Install_a_Plugin](http://projects.theforeman.org/projects/foreman/wiki/How_to_Install_a_Plugin)
for how to install Foreman plugins

## Usage

This plugin adds a new setting where you can define a regex. All host names have to match that regex.
This setting can be overridden by setting the smart parameter ```host_name_validation_regex``` on a hostgroup.

## Contributing

Fork and send a Pull Request. Thanks!

## Copyright

Copyright (c) 2015 Timo Goebel

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

