output "instance_id" {
    value = "${google_compute_instance.slimsample.self_link}"
}

output "public_ip" {
    value = "${google_compute_instance.slimsample.network_interface.0.access_config.0.assigned_nat_ip}"
}