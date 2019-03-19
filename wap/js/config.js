var SiteUrl = "/mall";
var ApiUrl = "/mo_bile";
var pagesize = 10;
var WapSiteUrl = "/wap";
var IOSSiteUrl = "https://itunes.apple.com/us/app/";
var AndroidSiteUrl = "download/app/AndroidFeiWa2014Moblie.apk";

// auto url detection
(function() {
    var m = /^(https?:\/\/.+)\/wap/i.exec(location.href);
    if (m && m.length > 1) {
        SiteUrl = m[1] + '/mall';
        ApiUrl = m[1] + '/mo_bile';
        WapSiteUrl = m[1] + '/wap';
    }
})();
