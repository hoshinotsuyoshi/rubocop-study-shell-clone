#!/bin/sh
set -x

cd ./repos
git clone --depth=1 git@github.com:fastladder/fastladder.git
git clone --depth=1 git@github.com:gitlabhq/gitlabhq.git
git clone --depth=1 git@github.com:lodge/lodge.git
git clone --depth=1 git@github.com:redmine/redmine.git
git clone --depth=1 git@github.com:rubygems/rubygems.org.git
git clone --depth=1 git@github.com:spree/spree.git
git clone --depth=1 git@github.com:alphagov/whitehall.git
cd -

set -xe
BUNDLE=$HOME/.gem/ruby/2.2.1/bin/bundle
#for project in fastladder redmine spree rubygems.org whitehall lodge gitlabhq
for project in whitehall lodge
do
  cd ./repos/$project
  rm -f .rubocop.yml
  rm -f .disabled-rubocop.yml
  rm -f .ruby-version
  cat << EOS > .rubocop.yml
AllCops:
  RunRailsCops: true
EOS
  rm -rf ./.bundle
  cat << EOS > Gemfile
source 'https://rubygems.org'
gem 'rubocop'
EOS
  #$BUNDLE -j4
  $BUNDLE exec rubocop --auto-gen-config || true
  mkdir -p ../../$project
  mv .rubocop_todo.yml ../../$project
  cd -
done

