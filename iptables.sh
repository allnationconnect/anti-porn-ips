
echo > /tmp/ips

block () {
  echo block $1
  host $1 | grep ' has address ' | awk -F ' address ' '{ print $2 }' | xargs -I % bash -c 'echo % >> /tmp/ips '
}

curl https://raw.githubusercontent.com/jiemoshu/anti-porn-ips/master/domains.txt > /tmp/domains.txt

while read -r line; do
  block $line &
done < /tmp/domains.txt

sleep 2

iptables -D FORWARD -m set --match-set porn-ipset src -j DROP
ipset destroy porn-ipset

cat /tmp/ips | sort | uniq | wc -l | xargs -I % ipset create porn-ipset hash:ip maxelem %
cat /tmp/ips | sort | uniq | xargs -I % ipset add porn-ipset %

iptables -I FORWARD 1 -m set --match-set porn-ipset src -j DROP
