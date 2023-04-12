# ------------------------------------------------------------ Imports ----------------------------------------------------------- #

# System
from typing import List
import os

# Local
from common import (
    PROJECT_CODE_PATH, TAB, SUPPORTED_FONT_SIZES, SUPPORTED_FONT_WEIGHTS,
    scandir, scanfiles, create_swift_file, rstrip, lstrip, lowerCamelCase, upperCamelCase, to_name, cleanup
)

# -------------------------------------------------------------------------------------------------------------------------------- #




# ------------------------------------------------------------- Paths ------------------------------------------------------------ #

assets_path    = os.path.join(PROJECT_CODE_PATH, 'Assets.xcassets')
resources_path = os.path.join(PROJECT_CODE_PATH, 'Resources')


# ------------------------------------------------------------ Methods ----------------------------------------------------------- #

# Utils

def var_name(cat: str, var: str) -> str:
    return lowerCamelCase(
        '{}{}'.format(to_name(cat), upperCamelCase(enum_entry(cat, var)))
    )

def enum_entry(cat: str, var: str) -> str:
    return lowerCamelCase(lstrip(to_name(var), cat))


# Generators

def generate_common() -> None:
    # Common
    create_swift_file(
        'Protocols/StringRepresentableInitable',
        ['Foundation'],
'''
protocol StringRepresentableInitable {
    init<T: RawRepresentable>(_ enumValue: T, bundle: Bundle?) where T.RawValue == String
}
'''
    )

    # SwiftUI
    create_swift_file(
        'Protocols/SwiftUI/SwiftUIStringBundleInitable',
        ['Foundation'],
'''
protocol SwiftUIStringBundleInitable {
    init(_ name: String, bundle: Bundle?)
}
'''
    )
    create_swift_file(
        'Protocols/SwiftUI/SwiftUIStringRepresentableInitable',
        ['Foundation'],
'''
protocol SwiftUIStringRepresentableInitable: StringRepresentableInitable, SwiftUIStringBundleInitable {}

extension SwiftUIStringRepresentableInitable {
    init<T: RawRepresentable>(_ enumValue: T, bundle: Bundle? = nil) where T.RawValue == String {
        self.init(enumValue.rawValue, bundle: bundle)
    }
}
'''
    )

    # UIKit
    create_swift_file(
        'Protocols/UIKit/UIKitStringBundleInitable',
        ['UIKit'],
'''
protocol UIKitStringBundleInitable {
    init?(named name: String, in bundle: Bundle?, compatibleWith traitCollection: UITraitCollection?)
}
'''
    )
    create_swift_file(
        'Protocols/UIKit/UIKitStringRepresentableInitable',
        ['Foundation'],
'''
protocol UIKitStringRepresentableInitable: StringRepresentableInitable, UIKitStringBundleInitable {}

extension UIKitStringRepresentableInitable {
    init<T: RawRepresentable>(_ enumValue: T, bundle: Bundle? = nil) where T.RawValue == String {
        self.init(named: enumValue.rawValue, in: bundle, compatibleWith: nil)!
    }
}
'''
    )

def generate_colors(p: str) -> None:
    color_names = sorted([rstrip(p.split(os.sep)[-1], '.colorset') for p in scandir(p) if p.endswith('.colorset')])

    create_swift_file(
        'Enums/ColorName',
        ['Foundation'],
        'enum ColorName: String {\n' + '\n'.join([
            '{}case {} = "{}"'.format(TAB, lowerCamelCase(color_name), color_name) for color_name in color_names
        ]) + '\n}'
    )

    color_blocks = [
        '{}static var {}: Self'.format(TAB, lowerCamelCase(color_name)) + ' { ' + 'return .init(ColorName.{})'.format(lowerCamelCase(color_name)) + ' }'
        for color_name in color_names
    ]

    create_swift_file(
        'Extensions/SwiftUI/Color+Colors',
        ['SwiftUI'],
        'extension Color: SwiftUIStringRepresentableInitable {\n' + '\n'.join(color_blocks).replace('Self', 'Color')+ '\n}'
    )
    
    create_swift_file(
        'Extensions/UIKit/UIColor+Colors',
        ['UIKit'],
        'extension UIColor: UIKitStringRepresentableInitable {\n' + '\n'.join(color_blocks).replace('Self', 'UIColor')+ '\n}'
    )

def generate_images(p: str) -> None:
    image_category_paths = sorted(scandir(p))
    enum_name = 'AssetName'

    sub_enums = []
    static_vars = []

    for image_category_path in image_category_paths:
        image_category_name = upperCamelCase(image_category_path.rstrip(os.sep).split(os.sep)[-1])
        image_names = sorted([rstrip(_p.rstrip(os.sep).split(os.sep)[-1], '.imageset') for _p in scandir(image_category_path)])

        if len(image_names) == 0:
            continue

        sub_enums.append(TAB + 'enum {}: String '.format(image_category_name) + '{\n' + '\n'.join([
            '{}{}case {} = "{}"'.format(TAB, TAB, lowerCamelCase(to_name(image_name)), image_name) for image_name in image_names
        ]) + '\n' + TAB + '}')
        static_vars.append('{}/// {}\n{}'.format(TAB, image_category_name, '\n'.join([
            '{}static var {}: Self '.format(TAB, var_name(image_category_name, image_name)) + '{ ' + 'return .init({}.{}.{})'.format(enum_name, image_category_name, lowerCamelCase(to_name(image_name))) + ' }'
            for image_name in image_names
        ])))

    create_swift_file(
        'Enums/AssetName',
        ['Foundation'],
        'enum AssetName {\n' + '\n\n'.join(sub_enums) + '\n}'
    )

    create_swift_file(
        'Extensions/SwiftUI/Image+Assets',
        ['SwiftUI'],
        'extension Image: SwiftUIStringRepresentableInitable {\n' + '\n\n\n'.join(static_vars).replace('Self', 'Image') + '\n}'
    )

    create_swift_file(
        'Extensions/UIKit/UIImage+Assets',
        ['UIKit'],
        'extension UIImage: UIKitStringRepresentableInitable {\n' + '\n\n\n'.join(static_vars).replace('Self', 'UIImage') + '\n}'
    )

def generate_strigs(p: str) -> None:
    with open(p, 'r') as f:
        s = f.read()

    enum_name = 'LocalizableStringKeys'

    cat_blocks = [cb.strip() for cb in s.replace('"', '').split('//')[1::]]
    sub_enums = []
    static_vars = []
    
    for cat_block in cat_blocks:
        # cat_block = cat_block.replace('\\\n', temp_new_line_key)
        cat_block_lines = cat_block.split('\n')

        cat_block_title = ''.join([v.title() for v in cat_block_lines[0].strip().replace(' ', '_').split('_')])
        cat_block_lines = [cb.strip().strip(';') for cb in cat_block_lines[1::] if cb.strip() != '']
        text_keys = [cbl.split('=')[0].strip() for cbl in cat_block_lines]
        text_keys_names = [(text_key, enum_entry(cat_block_title, text_key.title())) for text_key in text_keys]

        sub_enums.append(TAB + 'enum {}: String, LocalizableStringKey '.format(cat_block_title) + '{\n' + '\n'.join([
            '{}{}case {} = "{}"'.format(TAB, TAB, text_name, text_key) for (text_key, text_name) in text_keys_names
        ]) + '\n' + TAB + '}')
        static_vars.append('{}/// {}\n{}'.format(TAB, cat_block_title, '\n'.join([
            '{}static var {}: String '.format(TAB, var_name(cat_block_title, text_name)) + '{ ' + 'return {}.{}.{}.localized'.format(enum_name, cat_block_title, text_name) + ' }'
            for (text_key, text_name) in text_keys_names
        ])))

    create_swift_file(
        'Protocols/LocalizableStringKey',
        ['Foundation'],
'''
protocol LocalizableStringKey: RawRepresentable where RawValue == String {}

extension LocalizableStringKey {
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
'''
)

    create_swift_file(
        'Enums/LocalizableStringKeys',
        ['Foundation'],
        'enum LocalizableStringKeys {\n' + '\n\n'.join(sub_enums) + '\n}'
    )

    create_swift_file(
        'Extensions/Foundation/String+LocalizableStringKeys',
        ['SwiftUI'],
        'extension String {\n' + '\n\n\n'.join(static_vars) + '\n}'
    )

def generate_fonts(p: str) -> None:
    font_paths = [_p for _p in scanfiles(p) if _p.endswith('.ttf') or _p.endswith('.otf')]
    font_names = [fp.split(os.sep)[-1].split('.')[0] for fp in font_paths]
    font_types = [fn.split('-')[-1] for fn in font_names]
    font_titles = [fn.split('-')[0] for fn in font_names]
    font_enums = [lowerCamelCase(ft) for ft in font_types]

    convenience_funcs = '\n\n'.join([
        (
            '{}static func {}{}(_ size: CGFloat) -> Self {{ return .custom(.{}{}, size: size) }}'.format(TAB, lowerCamelCase(ft), upperCamelCase(fe), lowerCamelCase(ft), upperCamelCase(fe))
            + '\n' +
            '{}static func {}{}(_ size: FontSize) -> Self {{ return .{}{}(size.rawValue) }}'.format(TAB, lowerCamelCase(ft), upperCamelCase(fe), lowerCamelCase(ft), upperCamelCase(fe))
        if ft.lower() != fe.lower() else
            '{}static func {}(_ size: CGFloat) -> Self {{ return .custom(.{}, size: size) }}'.format(TAB, lowerCamelCase(ft), lowerCamelCase(ft))
            + '\n' +
            '{}static func {}(_ size: FontSize) -> Self {{ return .{}(size.rawValue) }}'.format(TAB, lowerCamelCase(ft), lowerCamelCase(ft))
        )
        for ft, fe in zip(font_titles, font_enums) 
    ])
    
    create_swift_file(
        'Enums/FontType',
        ['Foundation'],
'''enum FontType: String {{
{}
}}'''
        .format(
            '\n'.join([
                '{}case {}{} = "{}"'.format(TAB, lowerCamelCase(ft), upperCamelCase(fe), fn)
                if ft.lower() != fe.lower() else 
                 '{}case {} = "{}"'.format(TAB, lowerCamelCase(ft), fn)
                for ft, fe, fn in zip(font_titles, font_enums, font_names)
            ])
        )
    )
    create_swift_file(
        'Enums/FontSize',
        ['CoreGraphics'],
'''enum FontSize: CGFloat {{
{}
}}'''
        .format(
            '\n'.join([
                '{}case size{} = {}'.format(TAB, fs, fs)
                for fs in SUPPORTED_FONT_SIZES
            ])
        )
    )

    create_swift_file(
        'Extensions/UIKit/UIFont/UIKit+UIFont-Functions',
        ['UIKit'],
'''
extension UIFont {{
    static func custom(_ type: FontType, size: CGFloat) -> UIFont {{
        return self.init(name: type.rawValue, size: size)
            ?? .systemFont(ofSize: size, weight: .medium)
    }}

    static func custom(_ type: FontType, size: FontSize) -> UIFont {{
        return .custom(type, size: size.rawValue)
    }}


    // Convenience static funcs
    
{}
}}
'''.format(convenience_funcs).replace('Self', 'UIFont')
    )

    create_swift_file(
        'Extensions/SwiftUI/Font/SwiftUI+Font-Functions',
        ['SwiftUI'],
'''
extension Font {{
    static func custom(_ type: FontType, size: CGFloat) -> Font {{
        return .custom(type.rawValue, size: size)
    }}

    static func custom(_ type: FontType, size: FontSize) -> Font {{
        return .custom(type, size: size.rawValue)
    }}


    // Convenience static funcs
    
{}
}}
'''.format(convenience_funcs).replace('Self', 'Font')
    )

    static_var_groups = []

    for font_title, font_enum in zip(font_titles, font_enums):
        static_vars = []

        lowerFontTitle = lowerCamelCase(font_title)
        upperFontEnum = upperCamelCase(font_enum)

        for font_size in SUPPORTED_FONT_SIZES:
            if font_title.lower() != font_enum.lower() :
                static_vars.append('{}static var {}{}{}: Self {{ return .{}{}(.size{}) }}'.format(TAB, lowerFontTitle, upperFontEnum, font_size, lowerFontTitle, upperFontEnum, font_size))
            else:
                static_vars.append('{}static var {}{}: Self {{ return .{}(.size{}) }}'.format(TAB, lowerFontTitle, font_size, lowerFontTitle, font_size))

        static_var_groups.append(
'{}/// {}\n'.format(TAB, upperCamelCase(font_enum)) + '\n'.join(static_vars)
        )

    create_swift_file(
        'Extensions/SwiftUI/Font/SwiftUI+Font-Vars',
        ['SwiftUI'],
'''extension Font {{
{}
}}
'''.format('\n\n\n'.join(static_var_groups).replace('Self', 'Font'))
    )

    create_swift_file(
        'Extensions/UIKit/UIFont/UIKit+UIFont-Vars',
        ['UIKit'],
'''extension UIFont {{
{}
}}
'''.format('\n\n\n'.join(static_var_groups).replace('Self', 'UIFont'))
    )
    
    
    

# ------------------------------------------------------------- Flow ------------------------------------------------------------- #

cleanup()

generate_common()
generate_colors(os.path.join(assets_path, 'Colors'))
generate_images(os.path.join(assets_path, 'Images'))
generate_strigs(os.path.join(resources_path, 'Localization/en.lproj/Localizable.strings'))
generate_fonts(os.path.join(resources_path, 'Fonts'))

# -------------------------------------------------------------------------------------------------------------------------------- #
