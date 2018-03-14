terraform {
  required_version = "= 0.11.1"
}

provider "google" {
  credentials = "${file("${var.credentials}")}"
  project     = "${var.project}"
  region      = "${var.region}"
}

resource "google_compute_address" "slimsample_static_ip" {
    name = "${var.compute_address_name}"
}

resource "google_compute_firewall" "slimsample_firewall" {
    name = "slimsample-firewall"
    network = "default"

    allow {
        protocol = "tcp"
        ports = ["80", "22"]
    }
}

resource "google_compute_instance" "slimsample" {
    name = "${var.gce_name}"
    machine_type = "${var.machine_type}"
    zone = "${var.zone}"

    boot_disk {
        initialize_params = {
            size = 30
            image = "ubuntu-1604-lts"
        }
    }

    network_interface {
        network = "default"

        access_config = {
            nat_ip = "${google_compute_address.slimsample_static_ip.address}"
        }
    }

    metadata {
        ssh-keys = "${var.ssh_user}:${file("${var.ssh_pub_key}")}"
    }

    provisioner "chef" {
        attributes_json = <<-EOF
            {
                "lamp": {
                    "web_app": {
                        "server_name": "${google_compute_address.slimsample_static_ip.address}",
                        "writable_dirs": ["cache", "tmp", "logs"],
                        "writable_files": ["logs/app.log"],
                        "deploy_key_type": "${var.deploy_key_type}",
                        "deploy_key": "${var.deploy_key}",
                        "deploy_key_comment": "${var.deploy_key_comment}"
                    }
                }
            }
        EOF

        node_name = "slimsample"
        server_url = "${var.chef["server_url"]}"
        user_name = "${var.chef["user_name"]}"
        user_key = "${file("${var.chef["user_key"]}")}"
        run_list = ["lamp::default", "lamp::web_app"]
        ssl_verify_mode = ":verify_none"
        recreate_client = true

        connection {
            type = "ssh"
            user = "${var.ssh_user}"
            private_key = "${file("${var.ssh_private_key}")}"
        }
    }
}