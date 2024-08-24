//
// Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <audioplayers_webos/audioplayers_web_os_plugin.h>
#include <shared_preferences_webos/shared_preferences_webos_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  AudioplayersWebOsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("AudioplayersWebOsPlugin"));
  SharedPreferencesWebosPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("SharedPreferencesWebosPlugin"));
}
