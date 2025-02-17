#!/bin/bash

####+BEGIN: bx:bsip:bash:seed-spec :types "seedFtoCommon.sh"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedFtoCommon.sh]] |
"
FILE="
*  /This File/ :: /l/pip/ftoProc.sh
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedFtoCommon.sh -l $0 "$@"
    exit $?
fi
####+END:

seedExamplesType="pypi"

leavesExcludes=""

leavesOrdered=""

nodesExcludes=""

nodesOrdered=""

####+BEGIN: bx:dblock:pypi:bash:leavesList :types ""
leavesList="
"
####+END:

# nodesList=  comes from ./branches.list which is created by  vis_branchesList -- see below
####+BEGIN: bx:dblock:global:file-insert :mode "bash" :file "./branches.list"
nodesList="
b
banna
bashStandaloneIcmSeed
basics
binsprep
bootstrap
bpo
bx-bases
bxoGitlab
capability
capSpecs
cmdb
cntnr
common
core
coreDist
crypt
csPlayer
currents
debian
examples
facter
gcipher
githubApi
gossonot
graphviz-cs
lcnt
marmee
mmwsIcm
pals
platform
provision
pycs
qmail
regfps
sbom
siteRegistrars
things
transit
usgAcct
virsh
"

####+END:

function examplesHookPost {
    cat  << _EOF_
--- EXTRAs ---
$( examplesSeperatorChapter "List of Effective Branches To Traverse" )
${G_myName} -i branchesList ./branches.list
ls -l ./branches.list
${G_myName} -i branchesStdout
_EOF_
    return
}

function vis_branchesList {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -lt 2 ]]

    if [ $# -eq 1 ] ; then
        echo nodesList='"' > $1
        vis_branchesStdout >> $1
        echo '"' >> $1
    else
        vis_branchesStdout
    fi
}

function vis_branchesStdout {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    local requiredPackages="/bisos/git/auth/bxRepos/bisos-pip/full/py3/requires.outside"

    if [ ! -f ${requiredPackages} ] ; then
        EH_problem "Missing requiredPackages=${requiredPackages}"
    fi

    function processEach {
        EH_assert [[ $# -eq 1 ]]
        local each="$1"
        local parts
        local dirName
        IFS='.' read -ra parts <<< "$each"
        if [ "${parts[1]}" == "graphviz" ] ; then
            dirName="graphviz-cs"
        else
            dirName=${parts[1]}
        fi
        if [ ! -d "${dirName}"  ] ; then
            EH_problem "Missing ${dirName}"
        else
            echo "${dirName}"
        fi
    }


    local eachLine=""
    while read -r -t 1 eachLine ; do
        if [ ! -z "${eachLine}" ] ; then
            local each=""
            for each in ${eachLine} ; do
                lpDo processEach ${each}
            done
        fi
    done < ${requiredPackages}

    lpReturn
}

####+BEGIN: bx:dblock:bash:end-of-file :types ""
_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Common        ::  /[dblock] -- End-Of-File Controls/ [[elisp:(org-cycle)][| ]]
_CommentEnd_
#+STARTUP: showall
#local variables:
#major-mode: sh-mode
#fill-column: 90
# end:
####+END:
