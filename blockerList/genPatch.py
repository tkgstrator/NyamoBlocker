import json

blockerList = []
with open("hosts.txt", mode="r") as f:
    for host in f:
        if "//" not in host and host != "\n":
            domain = host.strip().replace(".", "\\.")
            blockerList.append({"action": {"type": "block"}, "trigger" : {"url-filter": domain}})
with open("selector.txt", mode="r") as f:
    selectors = []
    for css in f:
        if "//" in css: # Domain Name
            domain = css.replace("//", "").strip().replace(".", "\\.")
        else:
            if css != "\n":
                selectors.append(css.strip())
            if css == "\n":
                selector = ", ".join(selectors)
                blockerList.append({"action": {"type": "css-display-none", "selector": selector}, "trigger" : {"url-filter": domain}})
                selectors = []
    selector = ", ".join(selectors)
    blockerList.append({"action": {"type": "css-display-none", "selector": selector}, "trigger" : {"url-filter": domain}})
with open("blockerList.json", mode="w") as w:
    w.write(json.dumps(blockerList, indent=4))