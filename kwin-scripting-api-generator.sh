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
saxonb-xslt -xsl:${XSLT_FILE} -s:${KWIN_SRC_DIR}/scripting/documentation-global.xml > ${OUTPUT_FILE}
# workspace wrapper
saxonb-xslt -xsl:${XSLT_FILE} -s:${CURRENT_DIR}/docs/xml/class_k_win_1_1_workspace_wrapper.xml >> ${OUTPUT_FILE}
# options
saxonb-xslt -xsl:${XSLT_FILE} -s:${CURRENT_DIR}/docs/xml/class_k_win_1_1_options.xml >> ${OUTPUT_FILE}
# toplevel
saxonb-xslt -xsl:${XSLT_FILE} -s:${CURRENT_DIR}/docs/xml/class_k_win_1_1_toplevel.xml >> ${OUTPUT_FILE}
# client
saxonb-xslt -xsl:${XSLT_FILE} -s:${CURRENT_DIR}/docs/xml/class_k_win_1_1_client.xml >> ${OUTPUT_FILE}

rm ${DOXYFILE_GENERATED}
