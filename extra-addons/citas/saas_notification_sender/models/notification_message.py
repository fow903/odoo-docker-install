from odoo import models, fields, api, SUPERUSER_ID
from odoo.modules.registry import Registry
from odoo.service import db
import logging

_logger = logging.getLogger(__name__)

class NotificationSender(models.Model):
    _name = 'saas.notification.sender'
    _description = 'Notification Sender for SaaS Clients'

    name = fields.Char(string='Title', required=True)
    message = fields.Text(string='Message', required=True)
    target_dbs = fields.Char(string="Target DBs (comma separated)", help="Leave empty to notify all")

    def action_send_notification(self):
        target_dbs = self.target_dbs.split(',') if self.target_dbs else db.list_dbs()
        for db_name in target_dbs:
            _logger.info(f"Sending notification to database: {db_name}")
            try:
                registry = Registry.new(db_name)
                with registry.cursor() as cr:
                    env = api.Environment(cr, SUPERUSER_ID, {})
                    # Send notification through the bus
                    env['bus.bus'].sendone('saas_notification', {
                        'message': self.message,
                    })
            except Exception as e:
                _logger.exception(f"Error sending to {db_name}: {e}")
