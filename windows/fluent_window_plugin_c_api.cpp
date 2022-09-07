#include "include/fluent_window/fluent_window_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "fluent_window_plugin.h"

void FluentWindowPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  fluent_window::FluentWindowPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
