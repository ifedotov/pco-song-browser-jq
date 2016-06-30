<cfcomponent accessors="true" output="false">

    <cfset this.appID = "dc5396a3629bc845a1dcce701b3001fffc1dfa0fc611fb04a350b2ee9ddc3ea0">
    <cfset this.secret="14fa56e6249d36187e8fb9b57aa17ac03e97061cab558ec8aca4b01216c3a4f0">
    <cfset this.basic_auth_token = toBase64('#this.appID#:#this.secret#')>

    <cffunction name="song_list" access="remote" returnType="string" returnformat="json" output="false">
        <cfargument name="offset" type="numeric" required="false" default="0">
        <cfhttp url="https://api.planningcenteronline.com/services/v2/songs" method="get" result="local.songs">
            <cfhttpparam type="header" name="Authorization" value="Basic #this.basic_auth_token#">
            <cfhttpparam type="url" name="sort" value="title">
            <cfhttpparam type="url" name="per_page" value="100">
            <cfhttpparam type="url" name="offset" value="#offset#">
        </cfhttp>
    
        <cfreturn local.songs.filecontent>
    </cffunction>


    <cffunction name="song_arrangements" access="remote" returnType="string" returnformat="json" output="false">
        <cfargument name="songid" type="string" required="true">
        <cfhttp url="https://api.planningcenteronline.com/services/v2/songs/#songid#/arrangements" method="get" result="local.arrangements">
            <cfhttpparam type="header" name="Authorization" value="Basic #this.basic_auth_token#">
        </cfhttp>
    
        <cfreturn local.arrangements.filecontent>
    </cffunction>

</cfcomponent>