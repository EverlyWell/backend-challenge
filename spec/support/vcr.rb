# With activesupport gem Webdrivers::Common.subclasses.map { |driver| URI(driver.base_url).host }
driver_hosts = [
  'selenium-release.storage.googleapis.com',
  'chromedriver.storage.googleapis.com',
  'selenium-release.storage.googleapis.com',
  'msedgedriver.azureedge.net'
]

VCR.configure { |config| config.ignore_hosts(*driver_hosts) }
