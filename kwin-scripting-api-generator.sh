#!/bin/bash
# USAGE: ./kwin-scripting-api-generator.sh /path/to/kwin/src/directory outputfile
# tool needs to be run in the same directory where the Doxyfile and xslt is
###############################

CURRENT_DIR=`pwd`
KWIN_SRC_DIR=${1}
OUTPUT_FILE=${2}
DOXYFILE_GENERATED=Doxyfile.working
XSLT_FILE=${CURRENT_DIR}/mediawiki.xslt

sed s*KWIN_SRC_DIR*${KWIN_SRC_DIR}*g Doxyfile > ${DOXYFILE_GENERATED}

# doxygen
doxygen ${DOXYFILE_GENERATED}

# global
# TODO Once KWin 5.22 is released change to src/scripting
saxon8 ${KWIN_SRC_DIR}/scripting/documentation-global.xml mediawiki.xslt > ${OUTPUT_FILE}

# workspace wrapper
saxon8 ${CURRENT_DIR}/docs/xml/class_k_win_1_1_workspace_wrapper.xml mediawiki.xslt >> ${OUTPUT_FILE}
# options
saxon8 ${CURRENT_DIR}/docs/xml/class_k_win_1_1_options.xml mediawiki.xslt >> ${OUTPUT_FILE}
# toplevel
saxon8 ${CURRENT_DIR}/docs/xml/class_k_win_1_1_toplevel.xml mediawiki.xslt >> ${OUTPUT_FILE}
#abstractclient
saxon8 ${CURRENT_DIR}/docs/xml/class_k_win_1_1_abstract_client.xml mediawiki.xslt >> ${OUTPUT_FILE}

rm ${DOXYFILE_GENERATED}
