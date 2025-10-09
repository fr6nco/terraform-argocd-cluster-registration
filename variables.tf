

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
}

variable "labels" {
  description = "Additional labels to add to the cluster secret"
  type        = map(string)
  default     = {}
}

variable "annotations" {
  description = "Annotations to add to the cluster secret"
  type        = map(string)
  default     = {}
}

variable "api_endpoint" {
  description = "The API endpoint of the target cluster"
  type        = string
}

variable "ca" {
  description = "The CA certificate of the target cluster"
  type        = string
}
