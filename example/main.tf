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
