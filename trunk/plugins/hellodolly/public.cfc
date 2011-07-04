<!---
Plugin Name: Hello Dolly
Description: This is not just a plugin, it symbolizes the hope and enthusiasm of an entire generation summed up in two words sung most famously by Louis Armstrong: Hello, Dolly. When called you will randomly see a lyric from <cite>Hello, Dolly</cite>. Alternatively, you can specify a line number to get a specific lyric.
Author: Matt Mullenweg (Ported to Kindling by Miles Rausch)
Version: 1.0
Author URI: http://ma.tt/ & http://awayken.com
--->
<cfcomponent output="no">
	<cffunction name="init" output="no" access="public" returntype="string">
		<cfargument name="linenumber" type="string" required="no" default="" />
		
		<cfset var local = {} />
		<cfset local.lyrics = "Hello, Dolly
Well, hello, Dolly
It's so nice to have you back where you belong
You're lookin' swell, Dolly
I can tell, Dolly
You're still glowin', you're still crowin'
You're still goin' strong
We feel the room swayin'
While the band's playin'
One of your old favourite songs from way back when
So, take her wrap, fellas
Find her an empty lap, fellas
Dolly'll never go away again
Hello, Dolly
Well, hello, Dolly
It's so nice to have you back where you belong
You're lookin' swell, Dolly
I can tell, Dolly
You're still glowin', you're still crowin'
You're still goin' strong
We feel the room swayin'
While the band's playin'
One of your old favourite songs from way back when
Golly, gee, fellas
Find her a vacant knee, fellas
Dolly'll never go away
Dolly'll never go away
Dolly'll never go away again" />

		<cfset local.lyrics = ListToArray(local.lyrics, chr(10) & chr(13)) />
		
		<cfif arguments.LineNumber EQ "">
			<cfset arguments.LineNumber = RandRange(1, ArrayLen(local.lyrics)) />
		</cfif>
		
		<cfhtmlhead text="
<style type='text/css'>
.dolly {
	font-weight: bold;
	font-size: 11px;
}
</style>
" />
		
		<cfsavecontent variable="local.html"><cfoutput>
			<p class='dolly'>#local.lyrics[arguments.LineNumber]#</p>
		</cfoutput></cfsavecontent>
		
		<cfreturn local.html />
	</cffunction>
</cfcomponent>