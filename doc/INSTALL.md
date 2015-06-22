# Install Ruby or RVM
## Ruby
	sudo apt-get install -y curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
	mkdir /tmp/ruby && cd /tmp/ruby
	curl -L --progress http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.1.tar.gz | tar xz
	cd ruby-2.2.1
	./configure --disable-install-rdoc
	make
	sudo make install
	sudo gem install bundler --no-ri --no-rdoc

## RVM
	curl -L https://get.rvm.io | bash -s stable --auto-dotfiles --autolibs=enable --rails

# Install DNSManager
	cd dnsmanager
	git checkout develop
	bundle install
	rake assets:precompile
	export SECRET_KEY_BASE=$(rake secret)
	rake dnsmgr:db:rebuild RAILS_ENV=production
	rake dnsmgr:start

