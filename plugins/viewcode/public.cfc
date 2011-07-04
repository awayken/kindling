<!---
Plugin Name: View Code
Description: Properly formats a referenced file for display and download.
Author: Miles Rausch
Version: 1.0
Author URI: http://www.awayken.com
--->
<cfcomponent output="no">
	<cffunction name="init" output="no" access="public" returntype="string">
		<cfargument name="file" type="string" required="yes" />
		
		<cfset var local = {} />
		<cfset local.filepath = ExpandPath(arguments.file) />
		
		<cfif FileExists(local.filepath)>
			<cffile action="read" file="#local.filepath#" variable="local.filecontent" />
		<cfelse>
			<cfset local.filecontent = "File was not found." />
		</cfif>
		
<cfsavecontent variable="local.html"><cfoutput>
<div id="#hash(local.filepath)#" class="viewcode">
	<div class="toolbox">
		<span>#ListLast(arguments.file, "/")#</span>
		<a href="#arguments.file#" target="_blank"><cfif ListLast(arguments.file, ".") EQ "cfm">View page<cfelse>Download file</cfif></a>
	</div>
	<code>#HtmlEditFormat(local.filecontent)#</code>
</div>
</cfoutput></cfsavecontent>
		
		<cfreturn local.html />
	</cffunction>
</cfcomponent>