variable "credentials" {
    type               = "string"
    description        = "Google cloud credential(service accout file)"
}

variable "project" {
    type               = "string"
    description        = "Google cloud project name"
}

variable "region" {
    type               = "string"
    description        = "Google cloud region"
}

variable "gce_name" {
    type               = "string"
    description        = "Google compute engine name"
}

variable "machine_type" {
    type               = "string"
    description        = "Machine type"
}

variable "zone" {
    type               = "string"
    description        = "Google compute zone"
}

variable "compute_address_name" {
    type               = "string"
    description        = "Google compute address name"
}

variable "ssh_user" {
    type               = "string"
    description        = "User name used to remote login to compute engine via ssh."
}

variable "ssh_pub_key" {
    type               = "string"
    description        = "Ssh user public key path"
}

variable "ssh_private_key" {
    type               = "string"
    description        = "Ssh user private key path"
}

variable "deploy_key_type" {
    type               = "string"
    description        = "Slim sample deploy key type."
}

variable "deploy_key" {
    type               = "string"
    description        = "Slim sample deploy key."
}

variable "deploy_key_comment" {
    type               = "string"
    description        = "Slim sample deploy key comment."
}

variable "chef" {
    type               = "map"
    description        = "Knife configuration."
}