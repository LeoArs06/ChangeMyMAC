from setuptools import setup

APP = ['main.py']
ICON = 'icon.icns'

setup(
    app=APP,
    setup_requires=['py2app'],
    options={
        'py2app': {
            'iconfile': ICON,
            'plist': {
                'CFBundleDisplayName': 'changemymac',
                'CFBundleName': 'Change my MAC',
                'CFBundleIdentifier': 'com.naitshiro.changemymac',
                'CFBundleShortVersionString': '1.0',
                'CFBundleVersion': '1.0',
                'LSApplicationCategoryType': 'public.app-category.utilities',
                'LSUIElement': '1',
                'NSPrincipalClass': 'NSApplication',
                'LSBackgroundOnly': '1',
                'Developers': 'LeoArs06, Natisfaction'
            }
        }
    }
)
