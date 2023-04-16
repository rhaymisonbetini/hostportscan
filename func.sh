#! /usr/bin/env bash;

avalible_host() {
    read -p "INSERT TARGET EX:192.168.1 - " main
    read -p "INSERT INITAL: " init
    read -p "INSERT LIMIT: " final

    if [ $init -ge 1 -a $final -le 254 -a main != "" ]; then
        echo "SCAN INIT"
        for host in $(seq $init $final); do
            hping3 -S -p 80 -c 1 $main.$host 1>>"./${main}-${init}-${final}.txt" 2>/dev/null | grep "flags=SA" | cut -d "=" -f1
        done
        echo "SCAN FINISH!"
    else
        echo "INVALID VALUES FOR INTERVAL"
    fi
}

avalibe_ports_in_host() {
    read -p "INSERT THE TARGET EX: 192.157.1.30 - " host
    read -p "INSERT INITAL PORT : " init
    read -p "INSERT FINAL  PORT : " final

    if [ $init -le -1 -o $init -gt 65535 -o $init == "" ] || [ $final -le -1 -o $final -gt 65535 -o $final == "" ]; then
        echo "PORT INTERVAL BETWEEN 0 AND 65535"
    else
        echo "INIT SCAN BY PORTS IN HOST: $host"
        for port in $(seq $init $final); do
            hping3 -S -p $port -c 1 $host 1>>"./${host}-${init}-${final}.txt" 2>/dev/null | grep "flags=SA"
        done
        echo "SCAN FINISH!"
    fi
}

avalibe_port_in_hosts() {
    read -p "INSERT THE TARGET EX: 192.157.1 - " main
    read -p "INSERT INITAL : " init
    read -p "INSERT FINAL : " final
    read -p "INSERT PORT TO SCAN (0->65535) : " port

    if [ $main == "" -o $init == "" -o $final == "" -o $port == "" ] || [ $port -le -1 -o $port -gt 65535 ]; then
        echo "INVALID PARAMS"
    else
        echo "INIT SCAN PORT: $port IN HOSTS!"
        for host in $(seq $init $final); do
            hping3 -S -p $port -c 1 $main.$host 1>"./${main}-${init}-${final}.txt" 2>/dev/null | grep "flags=SA"
        done
        echo "SCAN FINISH!"
    fi
}

traceroute() {
    read -p "INSERT THE TARGET EX: 192.157.1.30 - " host
    read -p "TIPE OF IP TRACER (IPV4 OR IPV6): OPS: [4,6] :" ip
    if [ $host != "" ]; then
        echo "MAKE TRACEROUTER"
        traceroute -n "-${ip}" $host >>"tracerouter-${host}.txt"
    else
        echo "INVALID TARGET"
    fi
}

subdomains() {
    read -p "INSERT THE TARGET EX: 192.168.157.2 or www.google.com - " host
    if [ $host != "" ]; then
        sudo rm -rf index.html subs.txt
        wget $host
        cat index.html | egrep -i "href|http|https|src" | cut -d "/" -f3 | sed 's/"/ /' | sed 's/crossorigin="crossorigin"/ /' | sed 's/>/ /' | grep -v "window.location.href" | egrep -i ".com|.io" | sort -u >subs.txt
    else
        echo "INVALID CHOICE"
    fi
}
