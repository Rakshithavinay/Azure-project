 
resource "azurerm_resource_group" "raksrg" {
    location = var.location
    name = var.appservicename
  }

resource "azurerm_app_service_plan" "appplan" {
  name                = "raks-appserviceplan"
  location            = azurerm_resource_group.raksrg.location
  resource_group_name = azurerm_resource_group.raksrg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

 resource "azurerm_app_service" "appserve" {
  name                = "raks1appserve"
  location            = azurerm_resource_group.raksrg.location
  resource_group_name = azurerm_resource_group.raksrg.name
  app_service_plan_id = azurerm_app_service_plan.appplan.id

  site_config {
    dotnet_framework_version = "v4.0"
    always_on = true
   }

   backup {
    name = "sitebackup"
     storage_account_url = "https://coderbackup.blob.core.windows.net/$logs?sv=2021-06-08&ss=bfqt&srt=c&sp=rwdlacupiytfx&se=2022-09-07T20:14:07Z&st=2022-09-07T12:14:07Z&spr=https&sig=Mu3khwffkkaCVaySFCP4DWUgH%2BtGJMR9L8bKlrRPb14%3D&sr=b"
    schedule {
   frequency_interval = 10
   frequency_unit = "Day"
}
}
 }