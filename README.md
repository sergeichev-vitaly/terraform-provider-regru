# Terraform провайдер для управления DNS записями на reg.ru

Этот проект содержит Terraform провайдер для управления DNS записями с использованием API reg.ru. Провайдер позволяет создавать, читать и удалять различные типы DNS записей, включая A, AAAA, CNAME, MX и TXT.

## Установка

Для использования этого провайдера вам необходимо установить Terraform версии 0.12 или выше. Вы можете скачать Terraform с [официального сайта](https://www.terraform.io/downloads.html).

## Конфигурация

1. **Создайте файл переменных**:

    Создайте файл `vars.tf` и добавьте следующие переменные:

```hcl
variable "regru_api_username" {
  type        = string
  sensitive   = true
  default     = "login"
}

variable "regru_api_password" {
  type        = string
  sensitive   = true
  default     = "password"
}
```

2. **Создайте основной конфигурационный файл**:

Создайте файл `main.tf` с основной конфигурацией для провайдера и ресурсов:
```hcl
terraform {
  required_providers {
    regru = {
      version = "~>0.1.0"
      source  = "samolet/regru"
    }
  }
}

provider "regru" {
  username = var.regru_api_username
  password = var.regru_api_password
}
resource "regru_dns_record" "testcase-example-com" {
  record = "5.164.197.92"
  zone   = "example.com"
  name   = "testcase"
  type   = "A"
  priority = 0
}

resource "regru_dns_record" "testcase-ipv6-docs-example-com" {
  zone   = "example.com"
  name   = "testcase-ipv6"
  type   = "AAAA"
  record = "aa11::a111:11aa:aaa1:aa1a"
  priority = 0
}

resource "regru_dns_record" "testcase-cname-example-com" {
  record = "testcase-test"
  zone   = "example.com"
  name   = "testcase-cname"
  type   = "CNAME"
  priority = 0
}

resource "regru_dns_record" "testcase-txt-example-com" {
  zone   = "example.com"
  name   = "txt-testcase"
  type   = "TXT"
  record = "This is a TXT record for example.com"
  priority = 0
}

resource "regru_dns_record" "testcase-mx-example-com" {
  zone     = "example.com"
  name     = "@"
  type     = "MX"
  record   = "mail.testcase-mx.example.com"
  priority = 10
}
```

3. **Инициализация Terraform**:

    В каталоге с конфигурационными файлами выполните команду:

    ```sh
    terraform init
    ```

4. **Планирование конфигурации**:

    Перед применением конфигурации рекомендуется выполнить команду `terraform plan`, чтобы увидеть, какие изменения будут внесены:

    ```sh
    terraform plan
    ```

    Эта команда покажет, какие ресурсы будут созданы, изменены или удалены.

5. **Применение конфигурации**:

    Для создания указанных ресурсов выполните команду:

    ```sh
    terraform apply
    ```

## Разработка и сборка

Для сборки проекта убедитесь, что у вас установлен Go.

### Шаги по сборке проекта

1. **Клонируйте репозиторий**:

    ```sh
    git clone https://github.com/sergeichev-vitaly/terraform-provider-regru.git
    cd terraform-provider-regru
    ```

2. **Соберите провайдер**:

    Выполните команду для сборки провайдера:

    ```sh
    go build -o terraform-provider-regru ./cmd
    ```

3. **Создайте следующий каталог**:

    ```sh
    mkdir -p ~/.terraform.d/plugins/registry.terraform.io/samolet/regru/0.1.0/linux_amd64/
    ```
4. **Скопируйте файл провайдера в него**:

    ```sh
    cp terraform-provider-regru ~/.terraform.d/plugins/registry.terraform.io/samolet/regru/0.1.0/linux_amd64/
