#!/usr/bin/env bash

source script/constant.sh

yarn

sudo yarn run docs:build

if [ ! -d "${nginxpath}/assets" ]; then
    echo "文件不存在"
else
    rm -rf ${nginxpath}/assets
fi

if [ ! -d "${nginxpath}/javaScript" ]; then
    echo "文件不存在"
else
    rm -rf ${nginxpath}/javaScript
fi

if [ ! -d "${nginxpath}/other" ]; then
    echo "文件不存在"
else
    rm -rf ${nginxpath}/other
fi

if [ ! -d "${nginxpath}/pat" ]; then
    echo "文件不存在"
else
    rm -rf ${nginxpath}/pat
fi

if [ ! -d "${nginxpath}/tags" ]; then
    echo "文件不存在"
else
    rm -rf ${nginxpath}/tags
fi

if [ ! -d "${nginxpath}/icons" ]; then
    echo "文件不存在"
else
    rm -rf ${nginxpath}/icons
fi

sed -i '/<head>/a\<script type="application/ld+json">{"@context": "https://schema.org","@type": "NewsArticle","mainEntityOfPage": {"@type": "WebPage","@id": "https://wyydsb.xin"},"headline": "乌云压顶是吧","image": "https://wyydsb.xin/face.jpg","datePublished": "2017-10-10T08:00:00+08:00","dateModified": "2019-01-01T19:24:025+08:00","author": {"@type": "Person","name": "Gun Jianpan"},"publisher": {"@type": "Organization","name": "Gun Jianpan","logo": {"@type": "ImageObject","url": "https://wyydsb.xin/favicon.ico"}},"description": "Some coder skills"}</script>' docs/.vuepress/dist/index.html

for htmlFile in docs/.vuepress/dist/*/*.html docs/.vuepress/dist/*.html; do
    needJs=$(cat ${htmlFile} | tail -n 3 | head -n 1)
    sed -i '/preload.*/d' ${htmlFile}
    sed -i "/<head>/a$needJs" ${htmlFile}
    sed -i '/<head>/a\<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/docsearch.js@2/dist/cdn/docsearch.min.css" />' ${htmlFile}
    sed -i '/<head>/a\<meta name="google-site-verification" content="7ULbF13p7e6Z16vpi2tbAPHXHJBVu83TaxPTnvwnA8I" />' ${htmlFile}
    sed -i '/<head>/a\<meta name="referrer" content="no-referrer" />' ${htmlFile}
    sed -i '/<head>/a\<script async src="https://www.googletagmanager.com/gtag/js?id=UA-113936890-1"></script><script>window.dataLayer = window.dataLayer || [];function gtag(){dataLayer.push(arguments);}gtag("js", new Date());gtag("config", "UA-113936890-1");</script>' ${htmlFile}
    sed -i '/<\/body>/a\<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-WJK56VN"height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>' ${htmlFile}
    sed -i '/<\/body>/a\<script type="text/javascript"> docsearch({ apiKey: "c42b71d494ca78750c7094eb2c55eda6", indexName: "wyydsb", inputSelector: "", debug: false }); </script> ' ${htmlFile}
    sed -i '/<body>/a\<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/docsearch.js@2/dist/cdn/docsearch.min.js"></script>' ${htmlFile}
    lineNum=$(cat ${htmlFile} | wc -l)
    lineNumLast3=$(expr ${lineNum} - 2)
    sed -i ''"${lineNumLast3}"'d' ${htmlFile}
done

mv docs/.vuepress/dist/* ${nginxpath}/
