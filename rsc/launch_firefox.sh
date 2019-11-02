#!/bin/bash
url=$1
sed 's_REPLACEBYURL_'${url}'_' lexmark.policy.model > ${HOME}/.java.policy
/usr/bin/firefox/firefox --setDefaultBrowser ${url}
