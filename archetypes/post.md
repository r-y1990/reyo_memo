+++
title = "{{ replace .Name "-" " " | title }}"
date = '{{ .Date }}'

categories = [
{{ if in .Path "gamemo" }}"Gamemo"{{ else }}"Post"{{ end }}
]

tags = [
{{ if in .Path "gamemo" }}"Gamemo"{{ end }}
]
draft = true
+++
