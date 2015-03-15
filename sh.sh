#!/bin/sh
set -xe

cd ./repos
git clone --depth=1 git@github.com:fastladder/fastladder.git
git clone --depth=1 git@github.com:redmine/redmine.git
git clone --depth=1 git@github.com:spree/spree.git
git clone --depth=1 git@github.com:rubygems/rubygems.org.git
git clone --depth=1 git@github.com:alphagov/whitehall.git
git clone --depth=1 git@github.com:lodge/lodge.git
git clone --depth=1 git@github.com:gitlabhq/gitlabhq.git
cd -

