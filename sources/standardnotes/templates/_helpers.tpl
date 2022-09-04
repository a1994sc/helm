{{/*
Expand the name of the chart.
*/}}
{{- define "standardnotes.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "standardnotes.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "standardnotes.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "standardnotes.labels" -}}
helm.sh/chart: {{ include "standardnotes.chart" . }}
{{ include "standardnotes.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "standardnotes.selectorLabels" -}}
app.kubernetes.io/name: {{ include "standardnotes.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
API Selector labels
*/}}
{{- define "standardnotes.apiSelectorLabels" -}}
{{include "standardnotes.selectorLabels" . }}
app.kubernetes.io/function: {{ default "api-gateway" .Values.api.selectorID }}
{{- end }}

{{/*
FILE Selector labels
*/}}
{{- define "standardnotes.fileSelectorLabels" -}}
{{include "standardnotes.selectorLabels" . }}
app.kubernetes.io/function: {{ default "file" .Values.file.selectorID }}
{{- end }}


{{/*
AUTH manager Selector labels
*/}}
{{- define "standardnotes.authSelectorLabels" -}}
{{include "standardnotes.selectorLabels" . }}
app.kubernetes.io/function: {{ default "authentication-manager" .Values.auth.selectorManagerID }}
{{- end }}

{{/*
AUTH worker Selector labels
*/}}
{{- define "standardnotes.authWorkerSelectorLabels" -}}
{{include "standardnotes.selectorLabels" . }}
app.kubernetes.io/function: {{ default "authentication-worker" .Values.auth.selectorWorkerID }}
{{- end }}

{{/*
SYNC manager Selector labels
*/}}
{{- define "standardnotes.syncSelectorLabels" -}}
{{include "standardnotes.selectorLabels" . }}
app.kubernetes.io/function: {{ default "syncing-server" .Values.sync.selectorManagerID }}
{{- end }}

{{/*
SYNC worker Selector labels
*/}}
{{- define "standardnotes.syncWorkerSelectorLabels" -}}
{{include "standardnotes.selectorLabels" . }}
app.kubernetes.io/function: {{ default "syncing-server" .Values.sync.selectorWorkerID }}
{{- end }}

{{/*
Auth SVC name generator
*/}}
{{- define "standardnotes.authSVC" -}}
{{ printf "%s-%s" (include "standardnotes.name" .) .Values.auth.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "standardnotes.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "standardnotes.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
