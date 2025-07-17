# template.py
import json
import sys

from jinja2 import Template


def main(template_path, data_path, output_path):
    
    with open(template_path) as f:
        template = Template(f.read())
    
    with open(data_path) as f:
        data = json.load(f)
    
    rendered = template.render(**data)
    
    with open(output_path, "w", encoding="utf-8") as f:
        f.write(rendered)


if __name__ == '__main__':
    main(*sys.argv[1:])

