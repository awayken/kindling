# Plugins #

## Using Plugins ##

Kindling allows developers a lot of freedom in their content pages. You can build full-fledged applications using Kindling and the CFML conventions that you're used to. However, Kindling does offer a plugin system, making it easy to invoke code in your content pages or templates.

You can invoke a plugin using similar syntax to defining a region: `@‍[NAME ATTRIBUTE1="VALUE" ATTRIBUTE2="VALUE" ...]`. The `NAME` corresponds to the folder within plugins in the library that contains the plugin component. All attributes are passed to the plugin like you're used to. To see a plugin invocation in action, check out this example:

```
@(main)
	<p>Check out the source for this very page:</p>
	@[viewcode file="/plugins/index.cfm"]
@(/main)
```

## Writing Plugins ##

Plugins are just folders with CFCs in them. You really write your plugin no differently than you would any sort of ColdFusion component. There four requirements for a plugin:

  1. Your plugin must live in a folder whose name is the name of your plugin, like `viewcode`
  1. Your plugin must have a `public.cfc` component
  1. Your `public.cfc` component must include method called `init`
  1. Your `init` method must return a `string` as the output

Besides these simple constraints, your plugin can take any form you want. You can break your code up using whichever programming practices you prefer. Feel free to add your plugin into the plugins repository for SMS Campfire.

**For best practices, set `output="no"` on both your `public.cfc` and your `init` method. Any output will display, but it will do so before the template is parsed.**

Here is the source for the `viewcode` plugin. This is `/_library/plugins/viewcode/public.cfc`:

```
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
<div id="code_#hash(local.filepath)#" class="viewcode">
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
```