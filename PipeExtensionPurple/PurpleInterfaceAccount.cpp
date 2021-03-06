//======================================================================================================================
/*
	Copyright (c) since 2015 - Paul Freund (freund.paul@lvl3.org)
	
	Permission is hereby granted, free of charge, to any person
	obtaining a copy of this software and associated documentation
	files (the "Software"), to deal in the Software without
	restriction, including without limitation the rights to use,
	copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the
	Software is furnished to do so, subject to the following
	conditions:
	
	The above copyright notice and this permission notice shall be
	included in all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
	OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
	OTHER DEALINGS IN THE SOFTWARE.
*/
//======================================================================================================================

#include "CommonHeader.h"
#include "PurpleInterfaceAccount.h"
#include "PurpleInterfaceContact.h"

using namespace std;

//======================================================================================================================

PurpleInterfaceAccount::PurpleInterfaceAccount(const tstring& address, const tstring& path, PipeObjectPtr settings, const tstring& instance_name, const tstring& instance_description)
	: PipeServiceNode(address, path, settings, _T("purple_account"), _T("A purple chat account"), instance_name, instance_description, _T("purple_account")) {

	createMessageTypes();
	createCommandTypes();

	auto cmdJoin = PipeSchema::Create(PipeSchemaTypeString).title(_T("Channel")).description(_T("Channel name"));
	addCommand(_T("join"), _T("Test"), cmdJoin, [&](PipeObject& message) {
		auto ref = message[_T("ref")].string_value();
		if(!message.count(_T("data")) || !message[_T("data")].is_string()) {
			pushOutgoing(ref, _T("error"), _T("Missing command data"));
			return;
		}

		tstring channel = message[_T("data")].string_value();

		PurpleConnection* connection = purple_account_get_connection(_client);
		PurplePluginProtocolInfo* info = PURPLE_PLUGIN_PROTOCOL_INFO(purple_connection_get_prpl(connection));
		//// TODO: This should be a command type later
		//for(GList* comp = info->chat_info(connection); comp; comp = comp->next) {
		//	proto_chat_entry* entry = reinterpret_cast<proto_chat_entry*>(comp->data);
		//}

		GHashTable* components = info->chat_info_defaults(connection, channel.c_str());

		PurpleChat* channelBuddy = purple_chat_new(_client, channel.c_str(), components);

		tstring channelAddressName = timplode(texplode(channel, TokenAddressSeparator), _T('_'));
		tstring channelAddress = _address + TokenAddressSeparator + channelAddressName;
		addChild(channelAddress, make_shared<PurpleInterfaceContact>(channelAddress, _path, _settings, channel, _T(""), reinterpret_cast<PurpleBlistNode*>(channelBuddy)));

		serv_join_chat(connection, components);

		g_hash_table_destroy(components);
	});
}

//----------------------------------------------------------------------------------------------------------------------

PurpleInterfaceAccount::~PurpleInterfaceAccount() {
	if(_client != nullptr)
		purple_account_destroy(_client);
}

//----------------------------------------------------------------------------------------------------------------------

void PurpleInterfaceAccount::init(const tstring& protocol_id) {
	_client = purple_account_new(_T(""), protocol_id.c_str());
	if(_client == nullptr) {
		pushOutgoing(_T(""), _T("error"), _T("Account could not be created"));
		return;
	}

	for(auto& setting : *_settings) {
		if(setting.first == _T("base_user")) {
			purple_account_set_username(_client, setting.second.string_value().c_str());
		}
		else if(setting.first == _T("base_password")) {
			purple_account_set_password(_client, setting.second.string_value().c_str());
		}
		else {
			if(setting.second.is_string())
				purple_account_set_string(_client, setting.first.c_str(), setting.second.string_value().c_str());
			else if(setting.second.is_bool())
				purple_account_set_bool(_client, setting.first.c_str(), setting.second.bool_value());
			else if(setting.second.is_integer())
				purple_account_set_int(_client, setting.first.c_str(), setting.second.int_value());
		}
	}

	purple_account_set_enabled(_client, PurpleInterface::InterfaceID.c_str(), true);

	// TODO: Error handling
}

//----------------------------------------------------------------------------------------------------------------------

bool PurpleInterfaceAccount::hasRequestHandle(void* requestHandle) {
	// TODO
	return false;
}

//----------------------------------------------------------------------------------------------------------------------

PurpleInterfaceContact* PurpleInterfaceAccount::contactService(PurpleBlistNode* contact) {
	auto& childNodes = children();
	for(auto it = begin(childNodes); it != end(childNodes); it++) {
		PurpleInterfaceContact* service = reinterpret_cast<PurpleInterfaceContact*>(it->second.get());
		if(service->contactHandle() == contact)
			return service;
	}

	return nullptr;
}

PurpleInterfaceContact* PurpleInterfaceAccount::contactService(tstring name) {
	auto& childNodes = children();
	for(auto it = begin(childNodes); it != end(childNodes); it++) {
		PurpleInterfaceContact* contact = reinterpret_cast<PurpleInterfaceContact*>(it->second.get());
		if(contact->contactName() == name)
			return contact;
	}

	// TODO: What to do when Contact does not exist ( IRC for example )
	return nullptr;
}

//----------------------------------------------------------------------------------------------------------------------

void PurpleInterfaceAccount::onConnecting() {
	pushOutgoing(_T(""), _T("connecting"), _T(""));
}

//----------------------------------------------------------------------------------------------------------------------

void PurpleInterfaceAccount::onDisabled() {
	// TODO
	pushOutgoing(_T(""), _T("disabled"), _T(""));
}

//----------------------------------------------------------------------------------------------------------------------

void PurpleInterfaceAccount::onEnabled() {
	// TODO
	pushOutgoing(_T(""), _T("enabled"), _T(""));
}

//----------------------------------------------------------------------------------------------------------------------

void PurpleInterfaceAccount::onAuthRequest(tstring user, tstring message) {
	// TODO
	pushOutgoing(_T(""), _T("auth_request"), _T("From: ") + user + _T(" (") + message + _T(")"));
}

//----------------------------------------------------------------------------------------------------------------------

void PurpleInterfaceAccount::onAuthDenied(tstring user) {
	// TODO
	pushOutgoing(_T(""), _T("auth_denied"), user);
}

//----------------------------------------------------------------------------------------------------------------------

void PurpleInterfaceAccount::onAuthGranted(tstring user) {
	// TODO
	pushOutgoing(_T(""), _T("auth_granted"), user);
}

//----------------------------------------------------------------------------------------------------------------------

void PurpleInterfaceAccount::onSignedOn() {
	// TODO
	pushOutgoing(_T(""), _T("signed_on"), _T(""));
}

//----------------------------------------------------------------------------------------------------------------------

void PurpleInterfaceAccount::onSignedOff() {
	// TODO
	pushOutgoing(_T(""), _T("signed_off"), _T(""));
}

//----------------------------------------------------------------------------------------------------------------------

void PurpleInterfaceAccount::onStatusChanged() {
	// TODO
	pushOutgoing(_T(""), _T("status_changed"), _T(""));
}

//----------------------------------------------------------------------------------------------------------------------

void PurpleInterfaceAccount::onActionsChanged() {
	// TODO
	pushOutgoing(_T(""), _T("actions_changed"), _T(""));
}

//----------------------------------------------------------------------------------------------------------------------

void PurpleInterfaceAccount::onErrorChanged(tstring oldError, tstring newError) {
	// TODO
	pushOutgoing(_T(""), _T("error_changed"), _T("From \"") + oldError + _T("\" to \"") + newError + _T("\""));
}

//----------------------------------------------------------------------------------------------------------------------

void PurpleInterfaceAccount::onConnectionError(tstring error, tstring description) {
	// TODO
	pushOutgoing(_T(""), _T("connection_error"), error + _T(" (") + description + _T(")"));
}

//----------------------------------------------------------------------------------------------------------------------

inline tstring getContactName(PurpleBlistNode* contact) {
	auto type = purple_blist_node_get_type(contact);
	if(type == PURPLE_BLIST_BUDDY_NODE) {
		return safe_tstring(reinterpret_cast<PurpleBuddy*>(contact)->name);
	}
	else if(type == PURPLE_BLIST_CHAT_NODE) {
		return safe_tstring(reinterpret_cast<PurpleBuddy*>(contact)->alias);
	}

	return _T("");
}

void PurpleInterfaceAccount::onContactAdded(PurpleBlistNode* contact) {
	tstring contactName = getContactName(contact);
	if(contactName.empty()) { return; }

	tstring contactAddress = _address + TokenAddressSeparator + timplode(texplode(contactName, TokenAddressSeparator), _T('_'));
	addChild(contactAddress, make_shared<PurpleInterfaceContact>(contactAddress, _path, _settings, contactName, _T(""), contact));
}

//----------------------------------------------------------------------------------------------------------------------

void PurpleInterfaceAccount::onContactRemoved(PurpleBlistNode* contact) {
	tstring contactName = getContactName(contact);
	if(contactName.empty()) { return; }

	tstring contactAddress = _address + TokenAddressSeparator + timplode(texplode(contactName, TokenAddressSeparator), _T('_'));
	removeChild(contactAddress);
}

//----------------------------------------------------------------------------------------------------------------------
void PurpleInterfaceAccount::onMessageUnknownSender(tstring sender, tstring message) {
	// TODO
	pushOutgoing(_T(""), _T("message_unknown_sender"), sender + _T(": ") + message);
}

//----------------------------------------------------------------------------------------------------------------------

void PurpleInterfaceAccount::onInvited(tstring who, tstring where, tstring message, GHashTable* joinData) {
	// TODO
	pushOutgoing(_T(""), _T("invited"), _T("From: ") + who + _T(" to ") + where + _T(" (") + message + _T(")"));
}

//----------------------------------------------------------------------------------------------------------------------

void PurpleInterfaceAccount::onFileRecvUpdate(PurpleXfer *xfer) {
	// TODO
	pushOutgoing(_T(""), _T("file_recv_update"), _T(""));
}

//----------------------------------------------------------------------------------------------------------------------

void PurpleInterfaceAccount::onFileSendUpdate(PurpleXfer *xfer) {
	// TODO
	pushOutgoing(_T(""), _T("file_send_update"), _T(""));
}

//----------------------------------------------------------------------------------------------------------------------

void PurpleInterfaceAccount::onCloseRequest(void* requestHandle) {
	// TODO
	pushOutgoing(_T(""), _T("close_request"), _T(""));
}

//----------------------------------------------------------------------------------------------------------------------

void* PurpleInterfaceAccount::onRequestInput(PurpleConversation* conversation, PurpleInterfaceRequestInputCb ok_cb, PurpleInterfaceRequestCancelCb cancel_cb, void* user_data, tstring who, tstring title, tstring ok_text, tstring cancel_text, tstring primary, tstring secondary, tstring default_value, tstring hint, bool multiline, bool masked) {
	// TODO
	pushOutgoing(_T(""), _T("request_input"), _T(""));
	return nullptr; // TODO: Return made-up handle
}

//----------------------------------------------------------------------------------------------------------------------

void* PurpleInterfaceAccount::onRequestChoice(PurpleConversation* conversation, PurpleInterfaceRequestChoiceCb ok_cb, PurpleInterfaceRequestCancelCb cancel_cb, void* user_data, tstring who, tstring title, tstring ok_text, tstring cancel_text, tstring primary, tstring secondary, int default_value, std::map<int, tstring> choices) {
	// TODO
	pushOutgoing(_T(""), _T("request_choice"), _T(""));
	return nullptr; // TODO: Return made-up handle
}

//----------------------------------------------------------------------------------------------------------------------

void* PurpleInterfaceAccount::onRequestAction(PurpleConversation* conversation, void* user_data, tstring who, tstring title, tstring primary, tstring secondary, int default_action, std::map<int, std::pair<tstring, PurpleInterfaceRequestActionCb>> actions) {
	// TODO
	pushOutgoing(_T(""), _T("request_action"), _T(""));
	return nullptr; // TODO: Return made-up handle
}

//----------------------------------------------------------------------------------------------------------------------

void* PurpleInterfaceAccount::onRequestFile(PurpleConversation* conversation, PurpleInterfaceRequestFileCb ok_cb, PurpleInterfaceRequestCancelCb cancel_cb, void* user_data, tstring who, tstring title, tstring filanem, bool savedialog) {
	// TODO
	pushOutgoing(_T(""), _T("request_file"), _T(""));
	return nullptr; // TODO: Return made-up handle
}

//----------------------------------------------------------------------------------------------------------------------

void* PurpleInterfaceAccount::onRequestFolder(PurpleConversation* conversation, PurpleInterfaceRequestFolderCb ok_cb, PurpleInterfaceRequestCancelCb cancel_cb, void* user_data, tstring who, tstring title, tstring dirname) {
	// TODO
	pushOutgoing(_T(""), _T("request_folder"), _T(""));
	return nullptr; // TODO: Return made-up handle
}

//----------------------------------------------------------------------------------------------------------------------

void PurpleInterfaceAccount::createCommandTypes() {

}

//----------------------------------------------------------------------------------------------------------------------

void PurpleInterfaceAccount::createMessageTypes() {
	PipeObject emptyObject;
	addMessageType(_T("connecting"), _T("The account is trying to connect"), emptyObject);

	/*
	void onConnecting();
	void onDisabled();
	void onEnabled();

	void onAuthRequest(tstring user, tstring message = _T(""));
	void onAuthDenied(tstring user);
	void onAuthGranted(tstring user);

	void onSignedOn();
	void onSignedOff();

	void onStatusChanged();
	void onActionsChanged();

	void onErrorChanged(tstring oldError, tstring newError);
	void onConnectionError(tstring error, tstring description = _T(""));

	void onContactAdded(PurpleBlistNode* contact);
	void onContactRemoved(PurpleBlistNode* contact);

	void onMessageUnknownSender(tstring sender, tstring message);
	void onInvited(tstring who, tstring where, tstring message, GHashTable* joinData);

	void onFileRecvUpdate(PurpleXfer *xfer);
	void onFileSendUpdate(PurpleXfer *xfer);

	void onCloseRequest(void* requestHandle);
	void* onRequestInput(PurpleConversation* conversation, PurpleInterfaceRequestInputCb ok_cb, PurpleInterfaceRequestCancelCb cancel_cb, void* user_data, tstring who, tstring title, tstring ok_text, tstring cancel_text, tstring primary, tstring secondary, tstring default_value, tstring hint, bool multiline, bool masked);
	void* onRequestChoice(PurpleConversation* conversation, PurpleInterfaceRequestChoiceCb ok_cb, PurpleInterfaceRequestCancelCb cancel_cb, void* user_data, tstring who, tstring title, tstring ok_text, tstring cancel_text, tstring primary, tstring secondary, int default_value, std::map<int, tstring> choices);
	void* onRequestAction(PurpleConversation* conversation, void* user_data, tstring who, tstring title, tstring primary, tstring secondary, int default_action, std::map<int, std::pair<tstring, PurpleInterfaceRequestActionCb>> actions);
	void* onRequestFile(PurpleConversation* conversation, PurpleInterfaceRequestFileCb ok_cb, PurpleInterfaceRequestCancelCb cancel_cb, void* user_data, tstring who, tstring title, tstring filanem, bool savedialog);
	void* onRequestFolder(PurpleConversation* conversation, PurpleInterfaceRequestFolderCb ok_cb, PurpleInterfaceRequestCancelCb cancel_cb, void* user_data, tstring who, tstring title, tstring dirname);
	
	*/
}

//======================================================================================================================
