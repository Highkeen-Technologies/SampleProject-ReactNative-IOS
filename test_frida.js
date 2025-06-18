console.log("Script loaded successfully");

if (ObjC.available) {
    console.log("Objective-C runtime is available");
    
    // Try to hook NSBundle mainBundle method
    try {
        var NSBundle = ObjC.classes.NSBundle;
        if (NSBundle) {
            console.log("NSBundle class found");
            
            var mainBundle = NSBundle.mainBundle();
            console.log("Main bundle: " + mainBundle);
            console.log("Bundle identifier: " + mainBundle.bundleIdentifier());
            console.log("Bundle path: " + mainBundle.bundlePath());
        } else {
            console.log("NSBundle class not found");
        }
    } catch (e) {
        console.log("Error accessing NSBundle: " + e);
    }
} else {
    console.log("Objective-C runtime is not available");
}

