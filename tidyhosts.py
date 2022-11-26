
from tld import get_fld

domains = [i for i in open('./Anti-Porn-HOSTS-File/HOSTS.txt').read().split() if i and i !='0.0.0.0']

lst = set()

for i in domains:
    c = get_fld(i, fix_protocol=True, fail_silently=True)

    if c and (c == i or 'www.' + c == i):
        lst.add(i)

txt = '\n'.join(sorted(list(lst)))

print(txt)

