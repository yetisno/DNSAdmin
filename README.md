# DNSAdmin
The Web server module of [`DNSManager`](../../../DNSManager), this provide Domain Name Admin Service and support base function like [A, CNAME, MX, NS, SOA]. DNSManger = DNSAdmin + DNService

# Install

## 1. Install Ruby (Ubuntu)
```bash
sudo apt-get install -y curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
mkdir /tmp/ruby && cd /tmp/ruby
curl -L --progress http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.1.tar.gz | tar xz
cd ruby-2.2.1
./configure --disable-install-rdoc
make
sudo make install
sudo gem install bundler --no-ri --no-rdoc
```

## 2. Setting DNAdmin

Change the parameter or set environment variable to your own, see [config/dnsadmin.yml](config/dnsadmin.yml)

```yaml
dnsadmin:
    bind-ip: web bind ip
    bind-port: web bind port
dnservice:
    ip: DNService' ip
    port: DNService' port
    reload-key: DNService's reload key
```

Set Database connection string at [config/database.yml](config/database.yml), the environment variable is `DNS_DATABASE_URL`


## 3. Start Service
```bash
$ rake dns:start    # DNSAdmin | Start Service

#Action list
rake dns:db:drop                        # DNSAdmin | Drop DB
rake dns:db:init                        # DNSAdmin | Build DB
rake dns:db:migrate                     # DNSAdmin | Migrate DB
rake dns:db:rebuild                     # DNSAdmin | Rebuild DB
rake dns:restart                        # DNSAdmin | Restart Service
rake dns:run                            # DNSAdmin | Run Application (Not Daemon)
rake dns:start                          # DNSAdmin | Start Service
rake dns:stop                           # DNSAdmin | Stop Service
```


#### Contributor:

1. Yeti Sno (yeti@yetiz.org)
2. Cake Ant \[Gloria Lin\] (ant@yetiz.org)
