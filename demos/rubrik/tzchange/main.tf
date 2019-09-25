provider "rubrik" {}

resource "rubrik_configure_timezone" "ChicagoTZ" {
    timezone = "America/Chicago"
    //timezone = "America/Los_Angeles"
}
