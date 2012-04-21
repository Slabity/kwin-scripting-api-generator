<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:fn="http://www.w3.org/2005/xpath-functions">
<xsl:output method="text"/>
<xsl:template match="/doxygen/compounddef">
== <xsl:value-of select="compoundname"/> ==
<xsl:value-of select="fn:normalize-space(briefdescription)"/>
<xsl:if test="fn:string-length(fn:normalize-space(basecompoundref)) != 0">
'''Inherits:''' <xsl:value-of select="fn:normalize-space(basecompoundref)"/>
</xsl:if>
=== Read-only Properties ===
  <xsl:for-each select="sectiondef[@kind='property']/memberdef[@writable='no']">
    <xsl:call-template name="documentedItem"/>
  </xsl:for-each>
=== Read-write Properties ===
  <xsl:for-each select="sectiondef[@kind='property']/memberdef[@writable='yes']">
    <xsl:call-template name="documentedItem"/>
  </xsl:for-each>
=== Signals ===
  <xsl:for-each select="sectiondef[@kind='signal']/memberdef">
    <xsl:call-template name="documentedItem"/>
  </xsl:for-each>
=== Functions ===
  <xsl:for-each select="sectiondef[@kind='public-slot']/memberdef">
    <xsl:call-template name="documentedItem"/>
  </xsl:for-each>
  <xsl:for-each select="sectiondef[@kind='public-func']/memberdef">
    <xsl:if test="fn:contains(type, 'Q_SCRIPTABLE')">
        <xsl:call-template name="documentedItem"/>
    </xsl:if>
    <xsl:if test="fn:contains(type, 'Q_INVOKABLE')">
        <xsl:call-template name="documentedItem"/>
    </xsl:if>
  </xsl:for-each>

</xsl:template>

<xsl:template name="documentedItem">
    <xsl:variable name="description" select="fn:normalize-space(detaileddescription)"/>
* <xsl:if test="type != 'void' and type != 'Q_INVOKABLE void' and type != 'Q_SCRIPTABLE void'">''<xsl:value-of select="fn:replace(fn:replace(type, 'Q_SCRIPTABLE ', ''), 'Q_INVOKABLE ','')"/>'' </xsl:if>'''<xsl:value-of select="name"/><xsl:value-of select="argsstring"/>'''<xsl:if test="fn:string-length($description) != 0">: <xsl:value-of select="$description"/></xsl:if>
</xsl:template>

</xsl:stylesheet>
