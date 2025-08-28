odoo.define('saas_notification_listener.listener', function (require) {
    "use strict";

    const WebClient = require('web.WebClient');
    const core = require('web.core');

    const NotificationWebClient = WebClient.include({

        start: function () {
            this._super.apply(this, arguments);
            console.log("🔔 Notification listener loaded");

            try {
                const bus = require('bus.bus').bus;
                bus.add_channel("saas_notification");
                bus.on("notification", null, function (notifications) {
                    console.log("📩 Received notifications:", notifications);
                    _.each(notifications, function (notif) {
                        const payload = notif[1];
                        if (payload.message) {
                            const audio = new Audio('/saas_notification_listener/static/src/sound/alert.wav');
                            audio.play();
                            alert(payload.message);
                        }
                    });
                });
            } catch (error) {
                console.warn("🚫 Could not load bus:", error);
            }

            return Promise.resolve();
        },
    });

    return NotificationWebClient;
});
