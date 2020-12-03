import json

selectors = []
with open("selector.txt", mode="r") as f:
    for selector in f:
        selectors.append({"action": {"type": "css-display-none", "selector": selector.strip()}, "trigger" : {"url-filter": ".*"}})
with open("blockerList.json", mode="w") as w:
    w.write(json.dumps(selectors, indent=4))