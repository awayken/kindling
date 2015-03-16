# Creating Templates #

Kindling offers an easy and flexible way to template your pages. Templates are defined in the `templates` directory within the library for your site. Templates are CFM pages, where the filename before the extension is the name of the template. Templates contain zero or more regions for content to drop into. There is no penalty for having too few, too many, or incorrectly named regions. The template helper drops in whatever content it can, and it ignores everything else.

Within a template, a region is defined by a name, enclosed in parentheses, proceeded by an "@" symbol: `@(NAME)`. For instance, you might have two regions: `@(main)` and `@(sidebar)`. Regions can be dropped anywhere in your template file. Here is a sample template file:

```
<cfif Not IsDefined("request.page")>
	<cfoutput>You're not allowed to view this page directly.</cfoutput>
	<cfabort />
</cfif>
<cfsetting showdebugoutput="no">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><cfoutput>#request.page.displayTitle()#</cfoutput></title>
		
		<meta name="robots" content="noindex,nofollow" />
		<meta name="description" content="<cfoutput>#request.page.displayDescription()#</cfoutput>" />
		<meta name="keywords" content="<cfoutput>#request.page.displayKeywords()#</cfoutput>" />
		
		<link rel="stylesheet" type="text/css" href="/_styles/styles.css" />
		
	<cfif StructCount(request.page.getHeaders())>
		<!-- Additional Headers -->
		<cfoutput>#request.page.displayHeaders()#</cfoutput>
	</cfif>
	</head>
	<body class="interior">
		<h1><a href="<cfoutput>#application.config.domain#</cfoutput>/">SMS Campfire</a></h1>
		
		<div class="sitenav"><cfinclude template="_includes/sitenav.cfm" /></div>
		
		@(sidebar)
		
		<div id="main">
			<h2><cfoutput>#request.page.getName()#</cfoutput></h2>
			@(main)
		</div>
		
		<div id="footer">
			© <cfoutput>#DateFormat(Now(), "yyyy")#</cfoutput> Miles Rausch.
		</div>
		
		<script language="javascript" type="text/javascript" src="/_ls/js/jquery/jquery-1.4.2.min.js"></script>
		<script language="javascript" type="text/javascript" src="/_scripts/scripts.js"></script>
		
	<cfif StructCount(request.page.getFooters())>
		<!-- Additional Footers -->
		<cfoutput>#request.page.displayFooters()#</cfoutput>
	</cfif>
	</body>
</html>
```

Your template can have as many regions as you want, and they can be named however you want to name them. Kindling is flexible with regions. Kindling uses the template file as a guide. For every region it finds, it looks for a corresponding section of content in your page, then it combines the two. If it can't find a region in your content page, it ignores the region. It's as simple as that.

## Page Request Variables ##

Kindling leaves the template creation up to you. You can decide exactly how much HTML your template includes. You also decide what and how the page data gets utilized. To give you that freedom, Kindling provides you with some page request variables that you can use in your templates or in your page content.

When a page is requested, the Application initializes the Page helper, passing it the template path. The Page helper, among other things, locates the page data file and turns it into actual data. This data is encapsulated in `request.page`. This structure offers `get`, `set`, and `display` functions for most of the properties available in the page data file.

The following table defines the different page request variables you can use.

| PROPERTY |	RETURNS | 	DEFINITION |
|:---------|:--------|:------------|
| `request.page.setURL()` | 	`void` | 	Sets the page's URL property. |
| `request.page.getURL()` | 	`string` | 	Gets the page's URL property. |
| `request.page.displayURL()` |	 Full url | 	Displays the page's URL property. |
| `request.page.setPath()` | 	`void` | 	Sets the page's path property. |
| `request.page.getPath()` | 	`string` | 	Gets the page's path property. |
| `request.page.displayPath()` | 	 Expanded path | 	Displays the page's path property. |
| `request.page.setTemplate()` | 	`void` | 	Sets the page's template property. |
| `request.page.getTemplate()` | 	`string` | 	Gets the page's template property. |
| `request.page.displayTemplate()` | 	 string of template name | 	Displays the page's template property. |
| `request.page.setName()` | 	`void` | 	Sets the page's Name property. |
| `request.page.getName()` | 	`string` | 	Gets the page's Name property. |
| `request.page.displayName()` | 	 string of page name | 	Displays the page's Name property. |
| `request.page.setTitle()` | 	`void` | 	Sets the page's Title property. |
| `request.page.getTitle()` | 	`string` | 	Gets the page's Title property. |
| `request.page.displayTitle()` | 	 string of page title | 	Displays the page's Title property. |
| `request.page.setDescription()` | 	`void` | 	Sets the page's Description property. |
| `request.page.getDescription()` | 	`string` | 	Gets the page's Description property. |
| `request.page.displayDescription()` | string of description	 | 	Displays the page's Description property. |
| `request.page.setKeywords()` | 	`void` | 	Sets the page's Keywords property. |
| `request.page.getKeywords()` | 	`string` | 	Gets the page's Keywords property. |
| `request.page.displayKeywords()` | string of keywords	 | 	Displays the page's Keywords property. |
| `request.page.setVisibility()` | 	`void` | 	Sets the page's Visibility property. |
| `request.page.getVisibility()` | 	`string` | 	Gets the page's Visibility property. |
| `request.page.displayVisibility()` | 	 `boolean`	 | Displays the page's Visibility property. |
| `request.page.setHeaders()` | 	`void` | 	Sets the page's Headers property. |
| `request.page.getHeaders()` | 	`struct` | 	Gets the page's Headers property. |
| `request.page.displayHeaders()` | html	 | 	Displays the page's Headers property. |
| `request.page.setFooters()` | 	`void` | 	Sets the page's Footers property. |
| `request.page.getFooters()` | 	`struct` | 	Gets the page's Footers property. |
| `request.page.displayFooters()` | html	 | 	Displays the page's Footers property. |