
from tld import get_fld

domains = [j for j in open('porn-domains/block.txt').read().split() if j]

lst = set()

for i in set(domains):
    c = get_fld(i, fix_protocol=True, fail_silently=True)

    if c and (c == i or 'www.' + c == i):
        lst.add(i)

txt = '\n'.join(sorted(list(lst)))

print(txt)

