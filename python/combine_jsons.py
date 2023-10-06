#!/usr/bin/env python3

from sys import argv
import json

summaries = {}
for summary_json in argv[1:]:
    # Remove "_summary.json" from name to get project_name
    project_name = summary_json[: -len("_summary.json")]
    with open(summary_json) as f:
        contents = f.read()
        # Read contents as json
        contents = json.loads(contents)
    summaries[project_name] = contents
with open("summaries.json", "w") as f:
    f.write(json.dumps(summaries, indent=2))
