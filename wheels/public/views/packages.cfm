<cfinclude template="../layout/_header.cfm">

<cfscript>
param name="request.wheels.params.type" default="app";

packages = $createObjectFromRoot(path=application.wheels.wheelsComponentPath, fileName="Test", method="$listTestPackages", options=request.wheels.params);

// ignore packages before the "tests directory"
if (packages.recordCount) {
	allPackages = ListToArray(packages.package, ".");
	preTest = "";
	for (i in allPackages) {
		preTest = ListAppend(preTest, i, ".");
		if (i eq "tests") {
			break;
		}
	}
}

</cfscript>
<cfoutput>

<div class="ui container">

	#pageHeader("Test Suites", "Core &amp; App test suites")#

	<cfinclude template="../tests/_navigation.cfm">

	<div class="ui segment">
		<p>Below is listing of all the #type# test packages. Click the part of the package to run it individually.</p>
			<cfif packages.recordcount>
			#startTable("Test Packages")#
				<cfloop query="packages">
					<tr><td>
						<cfset testablePackages = ListToArray(ReplaceNoCase(package, "#preTest#.", "", "one"), ".")>
						<cfset packagesLen = arrayLen(testablePackages)>
						<cfloop from="1" to="#packagesLen#" index="i">
							<a href="#urlFor(route="wheelsTests",
							type = type,
							params="package=#ArrayToList(testablePackages.subList(JavaCast('int', 0), JavaCast('int', i)), '.')#&format=html")#">#testablePackages[i]#<cfif i neq packagesLen> .</cfif></a>
						</cfloop>
					</td></tr>
				</cfloop>
			#endTable()#
			<cfelse>
				<div class="ui placeholder segment">
				  <div class="ui icon header">
				    <i class="tasks icon"></i>
				    No tests found!
				  </div>
				</div>
			</cfif>
		</div>
	</div>

</cfoutput>

<cfinclude template="../layout/_footer.cfm">

