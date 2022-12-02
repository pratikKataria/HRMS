import 'package:hrms/env/environment_controller.dart';

abstract class EnvironmentVariables {
  static const int DEV = 0;
  static const int PROD = 1;

  static getTokenBody() {
    if (EnvironmentController.getCurrentEnv == DEV) {
      return {
        "grant_type": "password",
        "client_id": "3MVG9e2mBbZnmM6kh475SUvzSvPer7Yk8JkKLnlOrw8Wo4BoovXwaMMvmHqoh1RJzCzgYixgOAMYSsXR1B32h",
        "client_secret": "3E484F03D70BC76A46B6ADDD7B1A81B16924DAD561FCECE47889C7EF3C8CC082",
        "username": "devashish.nagapure1010@stetig.in",
        "password": "BookingApp@1231lrroM0mDmamjeRbdT9nJozq",
      };
    } else {
      return {
        "grant_type": "password",
        "client_id": "3MVG9Y6d_Btp4xp4lVI7hc0WUtDYjwSgLAw.8mGivfrt3frW8NVjEjcjLI2Vfg_FzkEDulWGtkRqeiSxZ6nle",
        "client_secret": "C892D8F3AAAF197C32FB41ECF5BA1C2EB151A1F2B2586AB3BB26C51E5662B92B",
        "username": "swapnil.gavande1010@stetig.in",
        "password": "Salesforce@123IhdyiMlHpHSilZ3EJMSu8jdWx",
      };
    }
  }

  static get getBaseURL => EnvironmentController.getCurrentEnv == PROD
      ? "https://piramal-realty.my.salesforce.com/services/apexrest"
      : "https://raymondrealty--raymondsb.sandbox.my.salesforce.com";

  static get getAccessTokenURL => EnvironmentController.getCurrentEnv == PROD
      ? "https://login.salesforce.com/services/oauth2/token"
      : "https://test.salesforce.com/services/oauth2/token";
}
