iptables -D FORWARD -j ANTI-PORN
iptables -F ANTI-PORN
iptables -X ANTI-PORN

iptables -N ANTI-PORN

block () {
  echo block $1
  host $1 | grep ' has address ' | awk -F ' address ' '{ print $2 }' | xargs -I % bash -c 'iptables -A ANTI-PORN -d % -j DROP'
}

curl https://raw.githubusercontent.com/jiemoshu/anti-porn-ips/master/domains.txt > /tmp/domains.txt

while read -r line; do
  block $line &
done < /tmp/domains.txt

iptables -I FORWARD 1 -j ANTI-PORN

