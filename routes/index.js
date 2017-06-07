var express = require('express');
var router = express.Router();
var path = require('path');
var fs = require('fs');
var SitemapGenerator = require('sitemap-generator');
var parseString = require('xml2js').parseString;

function walkSync(dir, filelist) {
    var fs = fs || require('fs'),
        files = fs.readdirSync(dir);
    filelist = filelist || [];
    files.forEach(function(file) {
        if (fs.statSync(dir + file).isDirectory()) {
            filelist = walkSync(dir + file + '/', filelist);
        } else {
            filelist.push(file);
        }
    });
    return filelist;
};

function stripUrl(unsafe) {
    return unsafe
        .replace(/\//g, "")
        .replace(/https/g, "")
        .replace(/http/g, "")
        .replace(/:/g, "");
}
/* GET home page. */
router.get('/', function(req, res) {
    console.log("Home page")
    var files = walkSync('./public/sitemaps/xml/');
    res.render('index', { title: 'Site map generator', files: files });
});

function getStringFromFile(file_path, data) {

}
router.get('/sitemap/:site_name', function(req, res) {
    const site_name = req.params.site_name;
    const file_path = `./public/sitemaps/json/${site_name}`

    fs.readFile(file_path, "utf8", function(err, data) {
        console.log(data.urlset['url'])
        var vm = {
            result: data,
        }
        res.render('result', vm);
    })
});

// write xml
function writeXmlMap(xml_sitemap, stripped_url) {
    const sitemap_path = `./public/sitemaps/xml/${stripped_url}.xml`;
    fs.writeFileSync(sitemap_path, xml_sitemap, 'utf8');
}


function writeJsonMap(xml_sitemap, stripped_url) {
    const sitemap_path = `./public/sitemaps/json/${stripped_url}.json`;
    parseString(xml_sitemap, function(err, result) {
        var json = JSON.stringify(result);
        fs.writeFileSync(sitemap_path, json, 'utf8');
    });
}
// write json

router.post('/', function(req, res) {
    console.time('crawling');
    console.log("Begining to crawl");
    const url_crawl = req.body.url_crawl;
    const stripped_url = stripUrl(url_crawl);
    const sitemap_path = `./public/sitemaps/${stripped_url}`;
    const generator = new SitemapGenerator(url_crawl);
    generator.on('done', function(sitemaps) {
        writeXmlMap(sitemaps, stripped_url)
        writeJsonMap(sitemaps, stripped_url)
        console.log(sitemaps); // => array of generated sitemaps
        console.timeEnd('crawling');
        res.send('done');
    });
    generator.start();
})
module.exports = router;