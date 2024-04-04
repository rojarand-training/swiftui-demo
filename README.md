[podspec.resources vs podspec.resource_bundle](https://mohit-bhalla.medium.com/understanding-podspec-resource-and-resource-bundle-usage-in-cocoapods-943ce4c0ecc2)

If your library is built as a **static library**, files under `spec.resources = 'file1', 'file2'` are copied to the resource folder of the main application bundle (.app) and this can be a problem as this main application may already have a resource of that name. In that case these files will overwrite each other.

## Differences between storing files in the `Document Directory` and the `application bundle`.

In iOS, there are significant differences between storing files in the Document Directory and the application bundle. Here's a breakdown of each:

## Document Directory:

- Purpose: The Document Directory is meant for storing user-generated content or data that needs to persist between app launches. It's suitable for files that the user creates or modifies within the app.
- Access: Files stored in the Document Directory are writable and can be modified or deleted by the app at runtime.
- Backup: Files in the Document Directory are backed up by iTunes and iCloud if the user enables iCloud backup for the app.
- Location: The Document Directory is a writable directory specific to your app and is located within the app's sandboxed environment.
- Example Usage: Saving user-generated documents, photos, settings, or any other data that needs to persist.

## Application Bundle:

- Purpose: The application bundle contains all the compiled resources and code for your app. It is read-only and should not be modified at runtime.
- Access: Files in the application bundle are read-only and cannot be modified or deleted by the app at runtime. Any attempt to modify files in the bundle will result in a runtime error.
- Backup: The contents of the application bundle are backed up during app installation from the App Store. However, they are not backed up by iTunes or iCloud during regular device backups.
- Location: The application bundle is located within the app's sandboxed environment, but it is read-only and cannot be modified.
- Example Usage: Storing static resources like images, sound files, property lists, storyboards, xib files, localization files, etc. These files are part of your app's bundle and are typically added during the app development process.

In summary, the Document Directory is used for storing user-generated content or data that needs to persist between app launches and can be modified by the app at runtime. On the other hand, the application bundle is read-only and is used for storing static resources and code that are part of your app's distribution package.



In DerivedData

Without ...
```console
 #s.resource_bundles = {
 #  'ResourceBundlesPodFlagsLib2' => ['PodFlagsLib2/PodRes/*.png']
 #}
```

```console
$../DerivedData/../Debug-iphonesimulator % tree -L 3 PodFlagsLib2
PodFlagsLib2
├── PackageFrameworks
└── PodFlagsLib2.framework
    ├── Flags
    │   ├── ca.png
    │   ├── mx.png
    │   └── us.png
    ├── Headers
    │   ├── PodFlagsLib2-Swift.h
    │   └── PodFlagsLib2-umbrella.h
    ├── Info.plist
    ├── Modules
    │   ├── PodFlagsLib2.swiftmodule
    │   └── module.modulemap
    ├── PodFlagsLib2
    └── _CodeSignature
        └── CodeResources
```

With ...
```console
s.resource_bundles = {
  'ResourceBundlesPodFlagsLib2' => ['PodFlagsLib2/PodRes/*.png']
}
```

```console
../DerivedData/../Debug-iphonesimulator % tree -L 3 PodFlagsLib2
PodFlagsLib2
├── PackageFrameworks
├── PodFlagsLib2.framework
│   ├── Flags
│   │   ├── ca.png
│   │   ├── mx.png
│   │   └── us.png
│   ├── Headers
│   │   ├── PodFlagsLib2-Swift.h
│   │   └── PodFlagsLib2-umbrella.h
│   ├── Info.plist
│   ├── Modules
│   │   ├── PodFlagsLib2.swiftmodule
│   │   └── module.modulemap
│   ├── PodFlagsLib2
│   ├── ResourceBundlesPodFlagsLib2.bundle
│   │   ├── Info.plist
│   │   ├── ar.png
│   │   └── br.png
│   └── _CodeSignature
│       └── CodeResources
└── ResourceBundlesPodFlagsLib2.bundle  <<<<<<<<<<<<< ---- Generated via resource_bundles
    ├── Info.plist
    ├── ar.png
    └── br.png
```

In /Users/user/Library/Developer/XCTestDevices/UIID/data/Containers/Bundle/Application/UUID/SwiftUITipsAndTricks.app/Frameworks

```
Frameworks % tree -L 3 PodFlagsLib2.framework 
PodFlagsLib2.framework
├── Flags
│   ├── ca.png
│   ├── mx.png
│   └── us.png
├── Info.plist
├── PodFlagsLib2
├── ResourceBundlesPodFlagsLib2.bundle
│   ├── Info.plist
│   ├── ar.png
│   └── br.png
└── _CodeSignature
    └── CodeResources
```

Structure of the application

```console
└── SwiftUITipsAndTricks.app
    ├── FlagsLib_FlagsLib.bundle
    │   ├── Info.plist
    │   ├── _CodeSignature
    │   │   ├── CodeDirectory
    │   │   ├── CodeRequirements
    │   │   ├── CodeRequirements-1
    │   │   ├── CodeResources
    │   │   └── CodeSignature
    │   ├── de.png
    │   └── pl.png
    ├── Frameworks
    │   └── PodFlagsLib2.framework
    │       ├── Flags
    │       │   ├── ca.png
    │       │   ├── mx.png
    │       │   └── us.png
    │       ├── Info.plist
    │       ├── PodFlagsLib2
    │       ├── ResourceBundlesPodFlagsLib2.bundle
    │       │   ├── Info.plist
    │       │   ├── ar.png
    │       │   └── br.png
    │       └── _CodeSignature
    │           └── CodeResources
    ├── Info.plist
    ├── PkgInfo
    ├── PlugIns
    │   └── SwiftUITipsAndTricksTests.xctest
    │       ├── FlagsLib_FlagsLib.bundle
    │       │   ├── Info.plist
    │       │   ├── _CodeSignature
    │       │   │   ├── CodeDirectory
    │       │   │   ├── CodeRequirements
    │       │   │   ├── CodeRequirements-1
    │       │   │   ├── CodeResources
    │       │   │   └── CodeSignature
    │       │   ├── de.png
    │       │   └── pl.png
    │       ├── Frameworks
    │       │   └── PodFlagsLib2.framework
    │       │       ├── Flags
    │       │       │   ├── ca.png
    │       │       │   ├── mx.png
    │       │       │   └── us.png
    │       │       ├── Info.plist
    │       │       ├── PodFlagsLib2
    │       │       ├── ResourceBundlesPodFlagsLib2.bundle
    │       │       │   ├── Info.plist
    │       │       │   ├── ar.png
    │       │       │   └── br.png
    │       │       └── _CodeSignature
    │       │           └── CodeResources
    │       ├── Info.plist
    │       ├── SwiftUITipsAndTricksTests
    │       ├── _CodeSignature
    │       │   └── CodeResources
    │       └── countries-test.json
    ├── SwiftUITipsAndTricks
    ├── _CodeSignature
    │   └── CodeResources
    └── countries.json
```

