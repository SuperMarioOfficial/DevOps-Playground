#!/bin/sh -eux

	
     export OSQUERY_KEY=1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B
     apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $OSQUERY_KEY
     apt-get install software-properties-common  -y
     apt-get update  -y
     add-apt-repository 'deb [arch=amd64] https://pkg.osquery.io/deb deb main'
     apt-get update  -y
     apt-get install osquery  -y
