#!/bin/bash

####+BEGIN: bx:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+minimal"
### Args: :control "enabled|disabled|hide|release|fVar"  :vc "cvs|git|nil" :partof "bystar|nil" :copyleft "halaal+minimal|halaal+brief|nil"
typeset RcsId="$Id: dblock-iim-bash.el,v 1.4 2017-02-08 06:42:32 lsipusr Exp $"
# *CopyLeft*
__copying__="
* Libre-Halaal Software"
#  This is part of ByStar Libre Services. http://www.by-star.net
#  This is a Halaal Poly-Existential. See http://www.freeprotocols.org

####+END:

####+BEGIN: bx:bsip:bash:seed-spec :types "seedFtoCommon.sh"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedFtoCommon.sh]] |
"
FILE="
*  /This File/ :: /bisos/git/auth/bxRepos/bisos-pip/ftoProc.sh
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedFtoCommon.sh -l $0 "$@"
    exit $?
fi
####+END:


leavesExcludes=""

leavesOrdered=""

nodesExcludes=""

nodesOrdered=""


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [[elisp:(blee:ppmm:org-mode-toggle)][Nat]] [[elisp:(beginning-of-buffer)][Top]] [[elisp:(delete-other-windows)][(1)]] || List       ::  Leaves List    [[elisp:(org-cycle)][| ]]
_CommentEnd_

####+BEGIN: bx:dblock:ploneProc:bash:leavesList :types ""
# {{{ DBLOCK-leavesList
leavesList="
"
# }}} DBLOCK-leavesList
####+END:


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [[elisp:(blee:ppmm:org-mode-toggle)][Nat]] [[elisp:(beginning-of-buffer)][Top]] [[elisp:(delete-other-windows)][(1)]] || List       ::  Nodes List    [[elisp:(org-cycle)][| ]]
_CommentEnd_

#
# For now ftoWalk is restricted to
#

####+BEGIN: bx:dblock:ploneProc:bash:nodesList :types ""
# {{{ DBLOCK-nodesList
nodesList="
bpf
examples
mmwsIcm
bootstrap
full
bashStandaloneIcmSeed
pals
marme
platform
bx-bases
provision
basics
bpo
bxoGitlab
common
core
things
overview
gossonot
coreDist
cntnr
namespace
icm
currents
lcnt
"
# }}} DBLOCK-nodesList
####+END:

####+BEGINNOT: bx:dblock:ploneProc:bash:nodesList :types ""
# {{{ DBLOCK-nodesList
nodesListPips="
blee-pip
unisos-pip
roPerf-pip
bisos-pip
"
# }}} DBLOCK-nodesList
####+END:



_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  [[elisp:(blee:ppmm:org-mode-toggle)][Nat]] [[elisp:(beginning-of-buffer)][Top]] [[elisp:(delete-other-windows)][(1)]] || Cmnd       ::  examplesHookPostExample    [[elisp:(org-cycle)][| ]]
_CommentEnd_

function examplesHookPost {
    cat  << _EOF_
$( examplesSeperatorTopLabel "EXTENSION EXAMPLES" )
_EOF_

    pypiFtpWalks

    templatesEvolution

    cat  << _EOF_
$( examplesSeperatorTopLabel "unisos-pip specific transtions" )
ftoProc.sh -i ftoWalkRunCmnd bisosTransitionInterim.sh -i py2to3  # moves dev to py2 and copies into py3
${G_myName} ${extraInfo} -i pys2to3ConvertDotPys  # runs 2to3 and keeps relevant files
${G_myName} ${extraInfo} -i pys2to3ConvertNoneDotPys  # runs 2to3 and keeps relevant files
${G_myName} ${extraInfo} -i py2SetupFixes   # seds setup.py and renames namesapce
$( examplesSeperatorSection "Upload Modules To PyPi" )
${G_myName} ${extraInfo} -i fullPrepUpload py3
${G_myName} ${extraInfo} -i fullPrepUpload py2
$( examplesSeperatorSection "Structural" )
${G_myName} ${extraInfo} -i py3SetupFixes   # a place holder -- not needed
${G_myName} ${extraInfo} -i pys2to3ConvertEach
$( examplesSeperatorSection "Identify Tabs" )
${G_myName} -i py3RelevantFiles
${G_myName} -i py3RelevantFiles | tabsExpand.sh -i filesHaveTabsReport | grep ==FOUND==
${G_myName} -i py3RelevantFiles | xargs tabsExpand.sh -i filesHaveTabsReport | grep ==FOUND==
$( examplesSeperatorSection "Expand Tabs" )
${G_myName} -i py3RelevantFiles |  xargs tabsExpand.sh -i expandTabs
_EOF_

    return
}


function pypiFtpWalks {
    local pypiProcStartTemplate="/bisos/apps/defaults/software/starts/pypiProc.sh"
    local ftoProcNodeStartTemplate="/bisos/apps/defaults/update/fto/start/commonProc/anyFtoItem/ftoProcNode.sh"
    
    cat  << _EOF_
$( examplesSeperatorChapter "ftpWalks: Uninstall" )
ftoProc.sh -v -n showRun -i ftoWalkRunCmnd pypiProc.sh -i pkgUnInstall sys
$( examplesSeperatorChapter "PyPi AuxNode ftpWalks" )
ftoProc.sh -v -n showRun -i treeRecurse runFunc pypiProc.sh -i distClean
ftoProc.sh -v -n showRun -i ftoWalkRunCmnd pypiProc.sh -i distClean
ftoProc.sh -v -n showRun -i ftoWalkRunCmnd pypiProc.sh -i pkgInstall edit /bisos/venv/py3/dev-bisos3
ftoProc.sh -v -n showRun -i ftoWalkRunCmnd pypiProc.sh -i pkgInstall edit sys
ftoProc.sh -v -n showRun -i ftoWalkRunCmnd icmPlayer.sh -i clean ftoProc.sh pypiProc.sh
ftoProc.sh -v -n showRun -i ftoWalkRunCmnd icmPlayer.sh -i pkgedPrep ftoProc.sh pypiProc.sh
$( examplesSeperatorChapter "Under Files Update" )
ftoProc.sh -v -n showRun -i updateUnderFilesTo  ${ftoProcNodeStartTemplate} ftoProc.sh
ftoProc.sh -v -n showRun -i updateUnderFilesTo  ${pypiProcStartTemplate} pypiProc.sh 
_EOF_
 return
}


function templatesEvolution {
    local ftoProcNodeStartTemplate="/bisos/apps/defaults/update/fto/start/commonProc/anyFtoItem/ftoProcNode.sh"
    local panelStartTemplate="/bisos/apps/defaults/update/fto/start/commonProc/anyFtoItem/mainPanel.org"
    
    cat  << _EOF_
$( examplesSeperatorSection "ftoProc.sh -- Templates Evolution" )
diff ./ftoProc.sh ${ftoProcNodeStartTemplate}
cp ./ftoProc.sh ${ftoProcNodeStartTemplate}
cp ${ftoProcNodeStartTemplate} ./ftoProc.sh  
$( examplesSeperatorSection "commonPanel.org -- Templates Evolution" )
diff ./Panel.org  ${panelStartTemplate}
cp ./Panel.org ${panelStartTemplate}
cp ${panelStartTemplate} ./Panel.org
_EOF_
 return
}


function vis_updateUnderFilesTo {
    G_funcEntry
    function describeF {  cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 2 ]]

    local updateToFile="$1"        
    local underFilesName="$2"

    if [ ! -f "${updateToFile}" ] ; then
	EH_problem "Bad Usage Missing ${updateToFile}"
	lpReturn
    fi

    local underFilesList=$(find . -type f -print | egrep "/${underFilesName}"'$')

    for each in ${underFilesList} ; do
	opDo cp ${updateToFile} ${each} 
	opDo bx-dblock -i dblockUpdateFile ${each}
    done

    lpReturn
}

function vis_py2SetupFixes {
    G_funcEntry
    function describeF {  cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    local subjectFilesList=$(find . -type f -print | egrep "/py2/" |  egrep "/setup.py"'$')

    local eachBaseDir=""
    local eachNameSpace=""

    local dateTag=$( DATE_nowTag )

    function nameSpaceRename {
        EH_assert [[ $# -eq 1 ]]
        local nameSpaceBaseDir=$1
        if [ -d "${nameSpaceBaseDir}" ] ; then
            lpDo mv ${nameSpaceBaseDir} ${nameSpaceBaseDir}2
        elif [ -d "${nameSpaceBaseDir}2" ] ; then
            ANT_raw "${nameSpaceBaseDir}2 already in place -- skipped"
        else
            ANT_raw "Neither ${nameSpaceBaseDir} nor ${nameSpaceBaseDir}2 found"
        fi
    }

    function getNameSpace {
        EH_assert [[ $# -eq 1 ]]
        local setupBaseDir=$1
        local outcome=""
        if [ -d "${setupBaseDir}/unisos2" ] ; then
            outcome="unisos2"
        elif [ -d "${setupBaseDir}/bisos2" ] ; then
            outcome="bisos2"
        elif [ -d "${setupBaseDir}/blee2" ] ; then
            outcome="blee2"
        else
            EH_problem "No Namespace Found"
        fi
        echo "${outcome}"
    }

    function setupConvert {
        EH_assert [[ $# -eq 1 ]]
        local setupFile=$1

        local setupBaseDir=$( FN_dirsPart "${setupFile}" )
        if [ -f "${setupFile}" ] ; then
            local nameSpace=$(lpDo getNameSpace ${setupBaseDir})
            if [ -z "${nameSpace}" ] ; then
                ANT_raw "No NameSpace Found -- setup adjustements skipped"
                lpReturn
            fi
            if grep -q ${nameSpace} ${setupFile} ; then
                ANT_raw "${nameSpace} already adjusted"
                lpReturn
            fi
            local oldNameSpace=$(echo ${nameSpace} | sed -e 's/2$//')

            lpDo FN_fileSafeCopy ${setupFile} ${setupFile}.${dateTag}

            local tmpFile=$( FN_tempFile )
            lpDo eval sed -e s/${oldNameSpace}/${nameSpace}/g ${setupFile} \> ${tmpFile}
            lpDo mv ${tmpFile} ${setupFile}
            lpDo chmod ugo+x ${setupFile}
        else
            EH_problem "Missing ${setupFile} -- skipped"
        fi
    }

    for each in ${subjectFilesList} ; do
        eachBaseDir=$( FN_dirsPart "${each}" )
        lpDo nameSpaceRename ${eachBaseDir}/unisos
        lpDo nameSpaceRename ${eachBaseDir}/bisos
        lpDo nameSpaceRename ${eachBaseDir}/blee

        lpDo setupConvert ${each}
    done

    lpReturn
}

function vis_py3SetupFixes {
    G_funcEntry
    function describeF {  cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    local subjectFilesList=$(find . -type f -print | egrep "/py3/" | grep setup.py)

    for each in ${subjectFilesList} ; do
        opDo echo ${each}
    done

    lpReturn
}

function vis_py3RelevantFiles {
    G_funcEntry
    function describeF {  cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    local outList=""
    local subjectFilesList=$(find . -type f -print | egrep "/py3/" | egrep "\.py"'$')

    for each in ${subjectFilesList} ; do
        outList="${outList} ${each}"
    done

    subjectFilesList=$(find . -type f -print | egrep "/py3/" | egrep "/bin/")

    local eachPrefix=""
    local eachExtension=""

    for each in ${subjectFilesList} ; do
        eachPrefix=$( FN_prefix ${each} )
        eachExtension=$( FN_extension ${each} )

        if [ -z "${eachExtension}" ] ; then
            outList="${outList} ${each}"
        fi
    done

    for each in ${outList} ; do
        opDo echo ${each}
    done

    lpReturn
}


function vis_pys2to3ConvertEach {
    G_funcEntry
    function describeF {  cat  << _EOF_
_EOF_
                       }
    EH_assert [[ $# -eq 1 ]]
    local each=$1

    if [ -f "${each}.2to3" ] ; then
        ANT_raw "${each} has already been converted -- skipped"
    else
        opDo echo Running: 2to3 -w ${each}
        2to3 -w ${each} > ${each}.2to3 2>&1
        if [ -f ${each}.3 ] ; then
            ANT_raw "${each}.3 already in place. Copying skipped"
        else
            lpDo cp -p ${each} ${each}.3
        fi
    fi
    lpReturn
}

function vis_pys2to3ConvertDotPys {
    G_funcEntry
    function describeF {  cat  << _EOF_
_EOF_
                       }
    EH_assert [[ $# -eq 0 ]]

    local subjectFilesList=$(find bxoGitlab -type f -print | egrep "/py3/" | egrep "\.py"'$')

    for each in ${subjectFilesList} ; do
        lpDo vis_pys2to3ConvertEach ${each}
    done

    lpReturn
}

function vis_pys2to3ConvertNoneDotPys {
    G_funcEntry
    function describeF {  cat  << _EOF_
_EOF_
                       }
    EH_assert [[ $# -eq 0 ]]

    local subjectFilesList=$(find bxoGitlab -type f -print | egrep "/py3/" | egrep "/bin/")

    local eachPrefix=""
    local eachExtension=""

    for each in ${subjectFilesList} ; do
        eachPrefix=$( FN_prefix ${each} )
        eachExtension=$( FN_extension ${each} )

        if [ -z "${eachExtension}" ] ; then
            lpDo vis_pys2to3ConvertEach ${each}
        fi
    done

    lpReturn
}



function vis_py3Keep%% {
    G_funcEntry
    function describeF {  cat  << _EOF_
_EOF_
                       }
    EH_assert [[ $# -eq 0 ]]

    local subjectFilesList=$(find . -type f -print | egrep "/py3/" | egrep "\.py"'$')

    for each in ${subjectFilesList} ; do
        if [ -f "${each}.2to3" ] ; then
            if [ -f ${each}.3 ] ; then
                ANT_raw "${each}.3 already in place. Copying skipped"
            else
                lpDo cp -p ${each} ${each}.3
            fi
        else
            ANT_raw "2to3 seems not have been run here. skipped."
        fi
    done

    lpReturn
}

function vis_fullPrepUpload {
    G_funcEntry
    function describeF {  cat  << _EOF_
_EOF_
                       }
    EH_assert [[ $# -eq 1 ]]
    local py3or2=$1

    local subjectFilesList=$(find . -type f -print | egrep "/${py3or2}/" | egrep "/pypiProc.sh"'$')

    local eachBaseDir=""
    local eachNonBaseDir=""

    for each in ${subjectFilesList} ; do
        eachBaseDir=$( FN_dirsPart "${each}" )
        eachNonBaseDir=$( FN_nonDirsPart "${each}" )
        inBaseDirDo ${eachBaseDir} ${eachNonBaseDir} -v -n showRun -p repo=main -i fullPrepUpload
    done

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
