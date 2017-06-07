<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
                xmlns:html="http://www.w3.org/TR/REC-html40"
				xmlns:image="http://www.google.com/schemas/sitemap-image/1.1"
                xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<title>Sitemap</title>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
				<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
				<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous"/>
				<script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
				<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
				<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
				<script>
					<![CDATA[
					function stripUrl(unsafe) {
						return unsafe
							.replace(/\//g, "")
							.replace(/https/g, "")
							.replace(/http/g, "")
							.replace(/:/g, "");
					}
					$(document).ready(function(){					
						$('td:first').each(function() {
							console.log($(this).text());
							var site_title = stripUrl($(this).text());
							$('title').html(site_title)
							$('h1').html(site_title + ' sitemap')
						});
						$('.url').each(function(){
							var fullurl = $(this).html()
							var url = fullurl.split("/").length - 4;
							$(this).closest('td').next().html(url);
							console.log(url);
						});
						
    					
					});
					]]>
				</script>
			</head>
			<body>
				<div id="content">
					<h1>XML Sitemap</h1>
					<p class="expl">
						This sitemap contains <xsl:value-of select="count(sitemap:urlset/sitemap:url)"/> URLs.
					</p>			
					<table id="sitemap" cellpadding="3" class="table table-striped table-hover table-sm">
						<thead class="thead-inverse">
							<tr>
								<th width="75%">URL</th>
								<th width="25%">Depth (1 = root)</th>
							</tr>
						</thead>
						<tbody>
							<xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyz'"/>
							<xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
							<xsl:for-each select="sitemap:urlset/sitemap:url">
								<tr>
									<td>
										<xsl:variable name="itemURL">
											<xsl:value-of select="sitemap:loc"/>
										</xsl:variable>
										<a class="url" href="{$itemURL}">
											<xsl:value-of select="sitemap:loc"/>
										</a>
									</td>
									<td class="depth">  
										
									</td>
					
								</tr>
							</xsl:for-each>
						</tbody>
					</table>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>