#############################################################################
#			Описание задания												#
#		1 Создать 3 вм инстанса на GCP										#
#		a. размер диска 20 Гб												#
#		b. тип e2-small														#
#		c. Регион на выбор													#
#		d. имя node 1 node 2 node 3 (не с 0)								#
#		Условие не юзать для имён нод явный список или словарь.				#
#############################################################################

provider "google" {
  credentials = file("../../../creds/mygcp-creds.json")
  project     = "black-skyline-352214"
  region      = "asia-east1"
  zone        = "asia-east1-a"
}

resource "google_compute_instance" "nodes" {
  count        = 3
  name         = "node${count.index + 1}"
  machine_type = "e2-small"
  zone         = "asia-east1-a"
  boot_disk {
    initialize_params {
      size  = "20"
      image = "ubuntu-2004-focal-v20211212"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  metadata = {
    ssh-keys = "root:${file("~/.ssh/id_rsa.pub")}"
  }
}
