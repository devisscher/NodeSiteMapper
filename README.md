# Node.js SiteMap generator

This project is developmental.

### Install dependencies

```
npm install 
```

### Modify sitemap-generator module to add xsl stylesheet.

```
// node_modules/sitemap-generator/lib/SitemapGenerator.js  ~ line 32

 var xml = xmlbuilder.create('urlset', { version: '1.0', encoding: 'UTF-8' })
        .att('xmlns', 'http://www.sitemaps.org/schemas/sitemap/0.9')
        .instructionBefore('xml-stylesheet', 'type="text/xsl" href="../../stylesheets/xml-sitemap.xsl"')
```

### Run

```
npm run dev
```

