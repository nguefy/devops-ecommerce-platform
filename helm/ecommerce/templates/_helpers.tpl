{{/*
Generate chart fullname
*/}}
{{- define "ecommerce.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}