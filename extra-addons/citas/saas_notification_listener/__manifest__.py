{
    'name': 'SaaS Notification Listener',
    'version': '1.0',
    'category': 'Tools',
    'summary': 'Push notification with sound for SaaS clients',
    'author': 'Edwin De Los Santos',
    'depends': ['web', 'bus', 'base'],
    'data': [],
    'assets': {
        'web.assets_backend': [
            'saas_notification_listener/static/src/js/notification_listener.js',
            'saas_notification_listener/static/src/sound/alert.wav',
        ]
    },
    'data': [
        'views/notification_listener.xml',
    ],
    'installable': True,
    'auto_install': False,
}