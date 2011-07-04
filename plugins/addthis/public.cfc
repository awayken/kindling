<!---
Plugin Name: AddThis
Description: Wraps AddThis HTML and JavaScript (v250) with a lot of options.
Author: Miles Rausch
Version: 1.0
Author URI: http://www.awayken.com
--->
<cfcomponent displayname="AddThis Public" hint="The public methods for AddThis component." output="no">

	<cfset this.attributes = StructNew()>

	<cffunction name="init" output="no" returntype="string" displayname="Initilize AddThis">
		<cfargument name="UserId" required="false" default="">
		<cfargument name="Content" required="false" default="Share">
		<cfargument name="Brand" required="false" default="">
		<cfargument name="HeaderColor" required="false" default="">
		<cfargument name="HeaderBackground" required="false" default="">
		<cfargument name="Options" required="false" default="">
		<cfargument name="Language" required="false" default="">
		
		<cfset var html = "" />
		
		<cfset this.attributes = arguments>
		
		<cfsavecontent variable="html">
			<cfinvoke method="displayJS" />
			<cfinvoke method="displayHTML" />
		</cfsavecontent>
		
		<cfreturn html />
	</cffunction>
	
	<cffunction name="displayHTML" output="true">
	
		<cfoutput>
		<div class="addthis">
			<a href="http://www.addthis.com/bookmark.php?v=250" class="addthis_button">
			<cfif IsDefined("this.attributes.Content") AND Len(this.attributes.Content)>
				<cfif REFind("\.jpg|\.png|\.gif|\.bmp|\.tiff", LCase(this.attributes.Content))>
					<img src="#this.attributes.Content#" border="0" alt="Share graphic" />
				<cfelse>
					#this.attributes.Content#
				</cfif>
			</cfif>
			</a>
        </div>
		</cfoutput>
	
	</cffunction>
	
	<cffunction name="displayJS" output="true">
		
		<cfset var addthis_domain = "http://s7.addthis.com">
		<cfif CGI.Https EQ "ON"><cfset addthis_domain = "https://secure.addthis.com"></cfif>
		
<cfhtmlhead text='
<!-- AddThis -->
<script type="text/javascript" src="#addthis_domain#/js/250/addthis_widget.js"></script>
'>
	
		<cfoutput>
		<script type="text/javascript">
			var addthis_config = {
				data_track_clickback: true,
				<cfif IsDefined("this.attributes.UserId") AND Len(this.attributes.UserId)>username: "#this.attributes.UserId#</cfif>",
				<cfif IsDefined("this.attributes.Brand") AND Len(this.attributes.Brand)>ui_cobrand: "#this.attributes.Brand#",</cfif>
				<cfif IsDefined("this.attributes.HeaderColor") AND Len(this.attributes.HeaderColor)>ui_header_color: "#this.attributes.HeaderColor#",</cfif>
				<cfif IsDefined("this.attributes.HeaderBackground") AND Len(this.attributes.HeaderBackground)>ui_header_background: "#this.attributes.HeaderBackground#",</cfif>
				<cfif IsDefined("this.attributes.Options") AND Len(this.attributes.Options)>services_compact: "#this.attributes.Options#",</cfif>
				ui_language: "<cfif IsDefined("this.attributes.Language")>#this.attributes.Language#<cfelse>en</cfif>"
			}
		</script>
		</cfoutput>
	
	</cffunction>

</cfcomponent>