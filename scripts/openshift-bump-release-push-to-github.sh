#!/bin/bash

#
# This file is part of the FlossWare family of open source software.
#
# FlossWare is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 3
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA
#

#
# This script will allow one to push out to bump a release version and
# push that out to github.
#
# To use:
#   openshift-git-bump-release-push-to-github.sh
#

DIR=`dirname $0`

${DIR}/maven-bump-release.sh $PWD/pom.xml

. ${DIR}/maven-compute-version-parts.sh ${PWD}/pom.xml

BRANCH=${MAVEN_MAJOR_VERSION}.${MAVEN_MINOR_VERSION}

git checkout ${BRANCH}

if [ $? -eq 1 ]
then
    git checkout -b ${BRANCH}
fi

${DIR}/openshift-version-change-push-to-github.sh