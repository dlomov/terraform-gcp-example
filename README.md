# Примеры работы с GCP с помощью Terraform
## 1. Создать 3 вм инстанса на GCP. Условие — не юзать для имён нод явный список или словарь.
- Размер диска 20 Гб
- Тип e2-small
- Регион на выбор
- Имя node 1 node 2 node 3 (не с 0)
---

<details>
<summary>Смотреть код</summary>

```terraform
provider "google" {
	#прячим свои креденшнл
  credentials = file("../../../creds/mygcp-creds.json")
  project     = "black-skyline-352214"
  region      = "asia-east1"
  zone        = "asia-east1-a"
}

resource "google_compute_instance" "nodes" {
  count        = 3
  #именуем ноды через count.index+1
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
	#это сетка по дефолту
    network = "default"
    access_config {
    }
  }

  metadata = {
	#кидаем сразу свой ssh-keygen -t rsa -C "you@mail.com"
    ssh-keys = "root:${file("~/.ssh/id_rsa.pub")}"
  }
}
```
![3 инстанса GCP](https://github.com/dlomov/terraform-gcp-example/blob/master/1/1.PNG "3 инстанса GCP")
</details>

---