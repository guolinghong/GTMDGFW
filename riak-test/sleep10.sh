
ip=`hostname -I | awk '{print $1}'`
echo $ip 
echo ${ip}


sed -i.bak "s/storage_backend = bitcask//" /etc/riak/riak.conf
#sed -i.bak 's/127.0.0.1:8098/${ip}:8098/' /etc/riak/riak.conf
sed -i.bak "s/nodename = riak@127.0.0.1/nodename = riak@${ip}/" /etc/riak/riak.conf
sed -i.bak "s/listener.protobuf.internal = 127.0.0.1:8087/listener.protobuf.internal = ${ip}:8087/" /etc/riak/riak.conf
sed -i.bak "s/listener.http.internal = 127.0.0.1:8098/listener.http.internal = ${ip}:8098/" /etc/riak/riak.conf
sed -i.bak "s/listener = 127.0.0.1:8085/listener = ${ip}:8085/" /etc/stanchion/stanchion.conf
# sed -i.bak "s/riak_host = 127.0.0.1:8087/riak_host = ${ip}:8087/" /etc/riak-cs/riak-cs.conf
sed -i.bak "s/listener = 127.0.0.1:8080/listener = ${ip}:8080/" /etc/riak-cs/riak-cs.conf 
sed -i.bak "s/nodename = riak-cs@127.0.0.1/nodename = riak-cs@${ip}/" /etc/riak-cs/riak-cs.conf
sed -i.bak "s/anonymous_user_creation = off/anonymous_user_creation = on/" /etc/riak-cs/riak-cs.conf
sed -i.bak "s/stanchion_host = 127.0.0.1:8085/stanchion_host = ${ip}:8085/" /etc/stanchion/stanchion.conf

riak start
stanchion start
riak-cs start

# if master node, create admin account and write keys to /var/lib/riak/admin_keys.json 
# else copy keys from master node, somehow...


while(true); do sleep 10;done
