

echo > ips

block () {
  echo block $1
  host $1 | grep ' address ' | awk -F ' address ' '{ print $2 }' | xargs -I % bash -c 'echo % >> ips'
}

export -f block

while read -r line; do
    echo "$line" | grep '0.0.0.0' | awk '{ print $NF}' | xargs -I % bash -c 'block %'
done < ./Anti-Porn-HOSTS-File/HOSTS.txt



