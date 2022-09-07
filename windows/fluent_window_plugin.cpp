#include "fluent_window_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include "include/encoding.h"

#pragma warning(push)
#pragma warning(disable : 4201)
#include "hicon_to_bytes.cpp"

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>

namespace fluent_window
{

    HWND native_window;

    // static
    void FluentWindowPlugin::RegisterWithRegistrar(
        flutter::PluginRegistrarWindows *registrar)
    {
        auto channel =
            std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
                registrar->messenger(), "fluent_window",
                &flutter::StandardMethodCodec::GetInstance());

        auto plugin = std::make_unique<FluentWindowPlugin>();

        channel->SetMethodCallHandler(
            [plugin_pointer = plugin.get()](const auto &call, auto result)
            {
                plugin_pointer->HandleMethodCall(call, std::move(result));
            });

        registrar->AddPlugin(std::move(plugin));
    }

    FluentWindowPlugin::FluentWindowPlugin() {}

    FluentWindowPlugin::~FluentWindowPlugin() {}

    void FluentWindowPlugin::HandleMethodCall(
        const flutter::MethodCall<flutter::EncodableValue> &method_call,
        std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
    {
        if (method_call.method_name().compare("getPlatformVersion") == 0)
        {
            std::ostringstream version_stream;
            version_stream << "Windows ";
            if (IsWindows10OrGreater())
            {
                version_stream << "10+";
            }
            else if (IsWindows8OrGreater())
            {
                version_stream << "8";
            }
            else if (IsWindows7OrGreater())
            {
                version_stream << "7";
            }
            result->Success(flutter::EncodableValue(version_stream.str()));
        }
        else
        {
            result->NotImplemented();
        }
    }

} // namespace fluent_window
