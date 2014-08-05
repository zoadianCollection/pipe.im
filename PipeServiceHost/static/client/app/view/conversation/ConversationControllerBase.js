//======================================================================================================================

Ext.define('PipeUI.view.conversation.ConversationControllerBase', {
	extend: 'PipeUI.view.ViewControllerBase',

	init: function () {
		var view = this.getView();
		if(view.initialMessage) {
			this.onMessage(view.initialMessage);
			view.initialMessage = null;
		}
	},

	onSession: function (session) {
		this.session = session;
	},

	onDisconnected: function () {
		this.session = undefined;
	},

	onMessage: function (msg) {
		var view = this.getView();
		if(msg.address != view.address) { return; }

		switch(msg.message) {
			case 'children':
			case 'node_added':
			case 'node_info_updated':
			case 'node_removed':
				break;

			case 'info':
				//view.tabInfo.title = 
				// TODO: Update info
				break;

			default:
				if(this.onReceived) { this.onReceived(msg); }
				break;
		}
	}
});

//======================================================================================================================
