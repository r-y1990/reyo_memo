+++
title = "{{ replace .Name "-" " " | title }}"
date = "{{ .Date | time.Format "2006-01-02" }}"

categories = [
{{ if in .Path "gamemo" }}"Gamemo"{{ else if "diary" }}"Diary"{{ end }}
]

tags = [
{{ if in .Path "gamemo" }}"Gamemo"{{ end }}
]
draft = false
+++
