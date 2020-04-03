provider "dominos" {
  first_name    = ""
  last_name     = ""
  email_address = ""
  phone_number  = ""

  credit_card {
    number = 123456789101112
    cvv    = 1314
    date   = "15/16"
    zip    = 18192
  }
}

data "dominos_address" "addr" {
  street = ""
  city   = ""
  state  = ""
  zip    = ""
}

data "dominos_store" "store" {
  address_url_object = "${data.dominos_address.addr.url_object}"
}

data "dominos_menu_item" "item" {
  store_id     = "${data.dominos_store.store.store_id}"
  query_string = ["philly", "large"]
}

//resource "dominos_order" "order" {
//  address_api_object = "${data.dominos_address.addr.api_object}"
//  item_codes         = ["${data.dominos_menu_item.item.matches.0.code}"]
//  store_id           = "${data.dominos_store.store.store_id}"
//}