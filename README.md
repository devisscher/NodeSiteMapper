# Node.js SiteMap generator

 var xml = xmlbuilder.create('urlset', { version: '1.0', encoding: 'UTF-8' })
        .att('xmlns', 'http://www.sitemaps.org/schemas/sitemap/0.9')
        .instructionBefore('xml-stylesheet', 'type="text/xsl" href="../../stylesheets/xml-sitemap.xsl"')