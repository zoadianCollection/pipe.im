//======================================================================================================================

Ext.define('PipeUI.view.conversation.BaseView', {
	//------------------------------------------------------------------------------------------------------------------

	extend: 'Ext.panel.Panel',

	//------------------------------------------------------------------------------------------------------------------
	
	layout: {
		type: 'vbox',
		align: 'stretch'
	},

	//------------------------------------------------------------------------------------------------------------------

	items: [{
		xtype: 'grid',
		reference: 'messages',
		hideHeaders: true,
		autoScroll: true,
		border: false,
		columnLines: false,
		enableColumnResize: false,
		rowLines: false,
		flex: 1,
		store: {
			fields: [
				{ name: 'message' }
			]
		},
		columns: [
			{
				text: 'Message',
				dataIndex: 'message',
				flex: 20
			}
		],
	}],

	//------------------------------------------------------------------------------------------------------------------

	controller: {
		//--------------------------------------------------------------------------------------------------------------

		type: 'baseController',

		//--------------------------------------------------------------------------------------------------------------

		onInit: function () {
			var myself = this;

			if(!this.view) { return; }
			this.view.on('activate', this.onActivate, this);

			if(!this.view.address) { return; }

			var service = this.getService(this.view.address);
			if(!service || !service.data || !service.data.commands) { return; }

			var toolbarItems = [];
			Ext.iterate(service.data.commands, function (cmd) {
				var cmdFkt = 'on_' + cmd.command;
				if(this[cmdFkt]) { return; }

				toolbarItems.push({
					xtype: 'button',
					text: cmd.command,
					tooltip: cmd.description,
					handler: cmdFkt
				});

				this[cmdFkt] = function () {
					myself.send({ address: myself.view.address, command: 'command', data: cmd.command });
				};
			}, this);

			this.view.addDocked({
				xtype: 'toolbar',
				dock: 'top',
				items: toolbarItems
			});
		},

		//--------------------------------------------------------------------------------------------------------------

		onMessage: function (msg) {
			if(!this.view || !this.view.address) { debugger; }
			if(msg.address != this.view.address) { return; }

			if(msg.message === 'command') {
				if(msg.data && msg.data.name && msg.data.schema) { this.onCommand(msg.data.name, msg.data.schema); }
				return;
			}

			// TODO: Interpret constants and stuff

			this.addMessage(JSON.stringify(msg));
			this.highlight();
		},

		//--------------------------------------------------------------------------------------------------------------

		onActivate: function () {
			if(this.view && this.view.tab) {
				try { this.view.tab.setGlyph(0); } catch(e) { }
			}

			this.scrollToBottom();
		},

		//--------------------------------------------------------------------------------------------------------------

		onSent: function (msg) {
			if(res = ph.res(this, 'view.shelf.constants.sent')) {
				if(res.ignore) { return; }
			}

			this.addMessage(JSON.stringify(msg));
		},

		//--------------------------------------------------------------------------------------------------------------

		onCommand: function (command, schema) {
			if(!this.view || !this.view.address) { return; }
			if(!schema) {
				this.send({
					command: command,
					address: myself.view.address
				});
			}

			var myself = this;
			this.commandWindow = Ext.create('PipeUI.view.dialog.Command', {
				autoShow: true,
				schema: schema,
				onSend: function (result) {
					myself.send({
						command: command,
						address: myself.view.address,
						data: result
					});
					myself.commandWindow.destroy();
				}
			});
		},

		//--------------------------------------------------------------------------------------------------------------

		getMessages: function () {
			var grid = this.lookupReference('messages');
			if(!grid) { return null; }
			return grid.getStore();
		},

		//--------------------------------------------------------------------------------------------------------------

		addMessage: function (message) {
			var store = this.getMessages();
			if(!store) { return; }

			// TODO: Do something about templating

			store.add({message: message });

			this.scrollToBottom();
		},

		//--------------------------------------------------------------------------------------------------------------

		scrollToBottom: function () {
			var grid = this.lookupReference('messages');
			if(!grid) { return; }
			var gridView = grid.getView();
			if(!gridView) { return; }

			try { gridView.scrollBy(0, 999999, true); } catch(e) { }
		},

		//--------------------------------------------------------------------------------------------------------------

		highlight: function () {
			if(this.view && this.view.tab && !this.view.tab.active) {
				this.view.tab.setGlyph(126);
			}
		}

		//--------------------------------------------------------------------------------------------------------------
	}

	//------------------------------------------------------------------------------------------------------------------
});

//======================================================================================================================
