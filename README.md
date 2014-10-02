# Flocker Example

[Install Flocker][install]

## Mongo Example

Start Vagrant

    $ vagrant up
    $ ssh-add ~/.vagrant.d/insecure_private_key

Deploy Mongo to 172.16.255.250

    $ flocker-deploy volume-deployment.yml volume-application.yml
    $ ssh root@172.16.255.250 docker ps

Insert some data

    $ mongo 172.16.255.250/example
    > db.records.insert({"the data": "it moves"})
    > db.records.find()
    { "_id" : ObjectId("542cb12bdf81d7babb011c75"), "the data" : "it moves" }

Move Mongo to 172.16.255.251

    $ flocker-deploy volume-deployment-moved.yml volume-application.yml
    $ ssh root@172.16.255.251 docker ps

Confirm data moved to new host

    $ mongo 172.16.255.251/example
    > db.records.find()
    { "_id" : ObjectId("542cb12bdf81d7babb011c75"), "the data" : "it moves" }

For more information, see https://docs.clusterhq.com/en/0.2.1/gettingstarted/tutorial/index.html

## Postgres Example

Pull Docker containers

    $ ssh -t root@172.16.255.250 docker pull postgres
    $ ssh -t root@172.16.255.251 docker pull postgres

Deploy Postgres to 172.16.255.250

    $ flocker-deploy postgres-deployment.yml postgres-application.yml
    $ ssh root@172.16.255.250 docker ps

Insert some data

    $ psql postgres --host 172.16.255.250 --port 5432 --username postgres -f postgres_test.sql
    $ psql postgres --host 172.16.255.250 --port 5432 --username postgres -c 'select * from example'

Move Postgres to 172.16.255.251

    $ flocker-deploy postgres-deployment-moved.yml postgres-application.yml
    $ ssh root@172.16.255.251 docker ps

Confirm data moved to new host

    $ psql postgres --host 172.16.255.251 --port 5432 --username postgres -c 'select * from example'

For more information, see https://docs.clusterhq.com/en/0.2.1/gettingstarted/examples/postgres.html

## Elasticsearch, Logstash & Kibana Example

Pull Docker containers

    $ ssh -t root@172.16.255.250 docker pull clusterhq/elasticsearch
    $ ssh -t root@172.16.255.250 docker pull clusterhq/logstash
    $ ssh -t root@172.16.255.250 docker pull clusterhq/kibana

    $ ssh -t root@172.16.255.251 docker pull clusterhq/elasticsearch
    $ ssh -t root@172.16.255.251 docker pull clusterhq/logstash
    $ ssh -t root@172.16.255.251 docker pull clusterhq/kibana

Deploy ELK

    $ flocker-deploy elk-deployment.yml elk-application.yml
    $ ssh root@172.16.255.250 docker ps
    $ ssh root@172.16.255.251 docker ps

Open Kibana

    $ open http://172.16.255.250/

Generate some logs

    $ telnet 172.16.255.250 5000
    { "firstName": "John", "lastName": "Zoidberg" }
    { "firstName": "Bender", "middleName": "Bending", "lastName": "Rodríguez" }
    ^]

    telnet> quit

    $ open http://172.16.255.250/

For more information, see https://docs.clusterhq.com/en/0.2.1/gettingstarted/examples/linking.html

[install]: https://docs.clusterhq.com/en/0.2.1/gettingstarted/installation.html
