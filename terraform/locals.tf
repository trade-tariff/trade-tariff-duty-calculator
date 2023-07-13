locals {
  service = "duty-calculator"
  api_service_backend_url_options = {
    uk = "https://${var.base_domain}/uk/"
    xi = "https://${var.base_domain}/xi/"
  }
}
