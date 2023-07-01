from setuptools import setup

APP = ['main.py']
ICON = 'icon.icns'

setup(
    app=APP,
    setup_requires=['py2app'],
    options={
        'py2app': {
            'iconfile': ICON,
        }
    }
)
