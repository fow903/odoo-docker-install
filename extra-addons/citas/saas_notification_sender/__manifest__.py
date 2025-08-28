{
    'name': 'SaaS Notification Sender',
    'version': '1.0',
    'category': 'Tools',
    'summary': 'Admin tool to send push notifications to SaaS clients',
    'author': 'Edwin De Los Santos',
    'depends': ['base'],
    'data': [
        'security/ir.model.access.csv',
        'views/notification_sender_views.xml',
    ],
    'installable': True,
    'auto_install': False,
}