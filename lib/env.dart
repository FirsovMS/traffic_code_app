const bool isProduction = bool.fromEnvironment('dart.vm.product');

const testConfig = {
  'baseUrl' : 'https://trafficcodeappwebapi20200208102452.azurewebsites.net/'
};

const productionConfig  = {
  'baseUrl' : 'https://trafficcodeappwebapi20200208102452.azurewebsites.net/'
};

final environment = isProduction ? productionConfig : testConfig;