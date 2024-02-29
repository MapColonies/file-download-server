{{/*
Expand the name of the chart.
*/}}
{{- define "files-server.name" -}}
{{- default .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
