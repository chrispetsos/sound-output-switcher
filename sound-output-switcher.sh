#!/bin/bash

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

getOutputProfiles() {
	result=`pacmd list-sinks | egrep -e "[^<]analog-output-" | sed -e 's/^[ \t]*//' | cut -d ':' -f1`
	echo "${result}"
}

getOutputDescription() {
	result=`pacmd list-sinks | egrep -e "[^<]analog-output-" | sed -e 's/^[ \t]*//' | cut -d ':' -f1`
	echo "${result}" | tac	# my setup returns the headphones for line-out and vice-versa, so reverse order with tac
}


OPTIND=1

while getopts "h?pd" opt; do
    case "$opt" in
    h|\?)
        echo "USAGE: $0 [-pd]"
        exit 0
        ;;
    p)  getOutputProfiles
        ;;
    d)  getOutputDescription
        ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift