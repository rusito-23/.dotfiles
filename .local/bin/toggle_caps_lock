#!/usr/bin/osascript -l JavaScript
// Toggle caps lock programmatically using AppleScript
// https://apple.stackexchange.com/questions/361373/toggle-caps-lock-programmatically-using-applescript

ObjC.import("IOKit");
ObjC.import("CoreServices");
ObjC.import("CoreFoundation");


function run(params) {
    if (params != "true" && params != "false") {
        console.log("A boolean (true/false) is required as argument.");
        return;
    }

    var value = JSON.parse(params);
    var ioConnect = Ref();

    var ioService = $.IOServiceGetMatchingService(
        $.kIOMasterPortDefault,
        $.IOServiceMatching($.kIOHIDSystemClass)
    );

    $.IOServiceOpen(
        ioService,
        $.mach_task_self_,
        $.kIOHIDParamConnectType,
        ioConnect
    );

    $.IOHIDSetModifierLockState(ioConnect, $.kIOHIDCapsLockState, value);
    $.IOServiceClose(ioConnect);
}
