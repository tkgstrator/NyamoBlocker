import json

blockerList = []
with open("hosts.txt", mode="r") as f:
    for host in f:
        if "127.0.0.1" in host:
            domain = host.split(" ")[1].strip().replace(".", "\\.")
            blockerList.append({"action": {"type": "block"}, "trigger" : {"url-filter": domain}})
        if "::1" in host:
            domain = host.split(" ")[1].strip().replace(".", "\\.")
            blockerList.append({"action": {"type": "block"}, "trigger" : {"url-filter": domain}})
with open("selector.txt", mode="r") as f:
    for css in f:
        if not "//" in css:
            selector = css.split(" ")[0].strip()
            domain = css.split(" ")[1].strip().replace(".", "\\.")
            blockerList.append({"action": {"type": "css-display-none", "selector": selector}, "trigger" : {"url-filter": domain}})
with open("blockerList.json", mode="w") as w:
    w.write(json.dumps(blockerList, indent=4))