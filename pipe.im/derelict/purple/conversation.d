/*

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license (the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

*/ 

module derelict.purple.conversation;

import derelict.glib.gtypes;
import derelict.glib.glibconfig;
import derelict.glib.glist;
import derelict.glib.ghash;
import derelict.purple.connection;
import derelict.purple.account;
import derelict.purple.buddyicon;
import core.stdc.time;
import core.stdc.config;

extern (C):

alias _PurpleConversationUiOps PurpleConversationUiOps;
alias _PurpleConversation PurpleConversation;
alias _PurpleConvIm PurpleConvIm;
alias _PurpleConvChat PurpleConvChat;
alias _PurpleConvChatBuddy PurpleConvChatBuddy;
alias _PurpleConvMessage PurpleConvMessage;
alias _Anonymous_0 PurpleConversationType;
alias _Anonymous_1 PurpleConvUpdateType;
alias _Anonymous_2 PurpleTypingState;
alias _Anonymous_3 PurpleMessageFlags;
alias _Anonymous_4 PurpleConvChatBuddyFlags;

enum _Anonymous_0
{
	PURPLE_CONV_TYPE_UNKNOWN = 0,
	PURPLE_CONV_TYPE_IM = 1,
	PURPLE_CONV_TYPE_CHAT = 2,
	PURPLE_CONV_TYPE_MISC = 3,
	PURPLE_CONV_TYPE_ANY = 4
}

enum _Anonymous_1
{
	PURPLE_CONV_UPDATE_ADD = 0,
	PURPLE_CONV_UPDATE_REMOVE = 1,
	PURPLE_CONV_UPDATE_ACCOUNT = 2,
	PURPLE_CONV_UPDATE_TYPING = 3,
	PURPLE_CONV_UPDATE_UNSEEN = 4,
	PURPLE_CONV_UPDATE_LOGGING = 5,
	PURPLE_CONV_UPDATE_TOPIC = 6,
	PURPLE_CONV_ACCOUNT_ONLINE = 7,
	PURPLE_CONV_ACCOUNT_OFFLINE = 8,
	PURPLE_CONV_UPDATE_AWAY = 9,
	PURPLE_CONV_UPDATE_ICON = 10,
	PURPLE_CONV_UPDATE_TITLE = 11,
	PURPLE_CONV_UPDATE_CHATLEFT = 12,
	PURPLE_CONV_UPDATE_FEATURES = 13
}

enum _Anonymous_2
{
	PURPLE_NOT_TYPING = 0,
	PURPLE_TYPING = 1,
	PURPLE_TYPED = 2
}

enum _Anonymous_3
{
	PURPLE_MESSAGE_SEND = 1,
	PURPLE_MESSAGE_RECV = 2,
	PURPLE_MESSAGE_SYSTEM = 4,
	PURPLE_MESSAGE_AUTO_RESP = 8,
	PURPLE_MESSAGE_ACTIVE_ONLY = 16,
	PURPLE_MESSAGE_NICK = 32,
	PURPLE_MESSAGE_NO_LOG = 64,
	PURPLE_MESSAGE_WHISPER = 128,
	PURPLE_MESSAGE_ERROR = 512,
	PURPLE_MESSAGE_DELAYED = 1024,
	PURPLE_MESSAGE_RAW = 2048,
	PURPLE_MESSAGE_IMAGES = 4096,
	PURPLE_MESSAGE_NOTIFY = 8192,
	PURPLE_MESSAGE_NO_LINKIFY = 16384,
	PURPLE_MESSAGE_INVISIBLE = 32768
}

enum _Anonymous_4
{
	PURPLE_CBFLAGS_NONE = 0,
	PURPLE_CBFLAGS_VOICE = 1,
	PURPLE_CBFLAGS_HALFOP = 2,
	PURPLE_CBFLAGS_OP = 4,
	PURPLE_CBFLAGS_FOUNDER = 8,
	PURPLE_CBFLAGS_TYPING = 16,
	PURPLE_CBFLAGS_AWAY = 32
}

struct _PurpleConversationUiOps
{
	void function (PurpleConversation*) create_conversation;
	void function (PurpleConversation*) destroy_conversation;
	void function (PurpleConversation*, const(char)*, const(char)*, PurpleMessageFlags, time_t) write_chat;
	void function (PurpleConversation*, const(char)*, const(char)*, PurpleMessageFlags, time_t) write_im;
	void function (PurpleConversation*, const(char)*, const(char)*, const(char)*, PurpleMessageFlags, time_t) write_conv;
	void function (PurpleConversation*, GList*, gboolean) chat_add_users;
	void function (PurpleConversation*, const(char)*, const(char)*, const(char)*) chat_rename_user;
	void function (PurpleConversation*, GList*) chat_remove_users;
	void function (PurpleConversation*, const(char)*) chat_update_user;
	void function (PurpleConversation*) present;
	gboolean function (PurpleConversation*) has_focus;
	gboolean function (PurpleConversation*, const(char)*, gboolean) custom_smiley_add;
	void function (PurpleConversation*, const(char)*, const(guchar)*, gsize) custom_smiley_write;
	void function (PurpleConversation*, const(char)*) custom_smiley_close;
	void function (PurpleConversation*, const(char)*) send_confirm;
	void function () _purple_reserved1;
	void function () _purple_reserved2;
	void function () _purple_reserved3;
	void function () _purple_reserved4;
}

struct _PurpleConvIm
{
	PurpleConversation* conv;
	PurpleTypingState typing_state;
	guint typing_timeout;
	time_t type_again;
	guint send_typed_timeout;
	PurpleBuddyIcon* icon;
}

struct _PurpleConvChat
{
	PurpleConversation* conv;
	GList* in_room;
	GList* ignored;
	char* who;
	char* topic;
	int id;
	char* nick;
	gboolean left;
	GHashTable* users;
}

struct _PurpleConvChatBuddy
{
	char* name;
	char* alias_;
	char* alias_key;
	gboolean buddy;
	PurpleConvChatBuddyFlags flags;
	GHashTable* attributes;
	gpointer ui_data;
}

struct _PurpleConvMessage
{
	char* who;
	char* what;
	PurpleMessageFlags flags;
	time_t when;
	PurpleConversation* conv;
	char* alias_;
}

struct _PurpleConversation
{
	PurpleConversationType type;
	PurpleAccount* account;
	char* name;
	char* title;
	gboolean logging;
	GList* logs;
	union
	{
		PurpleConvIm* im;
		PurpleConvChat* chat;
		void* misc;
	}
	PurpleConversationUiOps* ui_ops;
	void* ui_data;
	GHashTable* data;
	PurpleConnectionFlags features;
	GList* message_history;
}

alias da_purple_conversation_new = PurpleConversation* function(PurpleConversationType type, PurpleAccount* account, const(char)* name);																																																						/* da_purple_conversation_new purple_conversation_new; */
alias da_purple_conversation_destroy = void function(PurpleConversation* conv);																																																						/* da_purple_conversation_destroy purple_conversation_destroy; */
alias da_purple_conversation_present = void function(PurpleConversation* conv);																																																						/* da_purple_conversation_present purple_conversation_present; */
alias da_purple_conversation_get_type = PurpleConversationType function(const(PurpleConversation)* conv);																																																						/* da_purple_conversation_get_type purple_conversation_get_type; */
alias da_purple_conversation_set_ui_ops = void function(PurpleConversation* conv, PurpleConversationUiOps* ops);																																																						/* da_purple_conversation_set_ui_ops purple_conversation_set_ui_ops; */
alias da_purple_conversations_set_ui_ops = void function(PurpleConversationUiOps* ops);																																																						/* da_purple_conversations_set_ui_ops purple_conversations_set_ui_ops; */
alias da_purple_conversation_get_ui_ops = PurpleConversationUiOps* function(const(PurpleConversation)* conv);																																																						/* da_purple_conversation_get_ui_ops purple_conversation_get_ui_ops; */
alias da_purple_conversation_set_account = void function(PurpleConversation* conv, PurpleAccount* account);																																																						/* da_purple_conversation_set_account purple_conversation_set_account; */
alias da_purple_conversation_get_account = PurpleAccount* function(const(PurpleConversation)* conv);																																																						/* da_purple_conversation_get_account purple_conversation_get_account; */
alias da_purple_conversation_get_gc = PurpleConnection* function(const(PurpleConversation)* conv);																																																						/* da_purple_conversation_get_gc purple_conversation_get_gc; */
alias da_purple_conversation_set_title = void function(PurpleConversation* conv, const(char)* title);																																																						/* da_purple_conversation_set_title purple_conversation_set_title; */
alias da_purple_conversation_get_title = const(char)* function(const(PurpleConversation)* conv);																																																						/* da_purple_conversation_get_title purple_conversation_get_title; */
alias da_purple_conversation_autoset_title = void function(PurpleConversation* conv);																																																						/* da_purple_conversation_autoset_title purple_conversation_autoset_title; */
alias da_purple_conversation_set_name = void function(PurpleConversation* conv, const(char)* name);																																																						/* da_purple_conversation_set_name purple_conversation_set_name; */
alias da_purple_conversation_get_name = const(char)* function(const(PurpleConversation)* conv);																																																						/* da_purple_conversation_get_name purple_conversation_get_name; */
alias da_purple_conv_chat_cb_get_attribute = const(char)* function(PurpleConvChatBuddy* cb, const(char)* key);																																																						/* da_purple_conv_chat_cb_get_attribute purple_conv_chat_cb_get_attribute; */
alias da_purple_conv_chat_cb_get_attribute_keys = GList* function(PurpleConvChatBuddy* cb);																																																						/* da_purple_conv_chat_cb_get_attribute_keys purple_conv_chat_cb_get_attribute_keys; */
alias da_purple_conv_chat_cb_set_attribute = void function(PurpleConvChat* chat, PurpleConvChatBuddy* cb, const(char)* key, const(char)* value);																																																						/* da_purple_conv_chat_cb_set_attribute purple_conv_chat_cb_set_attribute; */
alias da_purple_conv_chat_cb_set_attributes = void function(PurpleConvChat* chat, PurpleConvChatBuddy* cb, GList* keys, GList* values);																																																						/* da_purple_conv_chat_cb_set_attributes purple_conv_chat_cb_set_attributes; */
alias da_purple_conversation_set_logging = void function(PurpleConversation* conv, gboolean log);																																																						/* da_purple_conversation_set_logging purple_conversation_set_logging; */
alias da_purple_conversation_is_logging = gboolean function(const(PurpleConversation)* conv);																																																						/* da_purple_conversation_is_logging purple_conversation_is_logging; */
alias da_purple_conversation_close_logs = void function(PurpleConversation* conv);																																																						/* da_purple_conversation_close_logs purple_conversation_close_logs; */
alias da_purple_conversation_get_im_data = PurpleConvIm* function(const(PurpleConversation)* conv);																																																						/* da_purple_conversation_get_im_data purple_conversation_get_im_data; */
alias da_purple_conversation_get_chat_data = PurpleConvChat* function(const(PurpleConversation)* conv);																																																						/* da_purple_conversation_get_chat_data purple_conversation_get_chat_data; */
alias da_purple_conversation_set_data = void function(PurpleConversation* conv, const(char)* key, gpointer data);																																																						/* da_purple_conversation_set_data purple_conversation_set_data; */
alias da_purple_conversation_get_data = gpointer function(PurpleConversation* conv, const(char)* key);																																																						/* da_purple_conversation_get_data purple_conversation_get_data; */
alias da_purple_get_conversations = GList* function();																																																						/* da_purple_get_conversations purple_get_conversations; */
alias da_purple_get_ims = GList* function();																																																						/* da_purple_get_ims purple_get_ims; */
alias da_purple_get_chats = GList* function();																																																						/* da_purple_get_chats purple_get_chats; */
alias da_purple_find_conversation_with_account = PurpleConversation* function(PurpleConversationType type, const(char)* name, const(PurpleAccount)* account);																																																						/* da_purple_find_conversation_with_account purple_find_conversation_with_account; */
alias da_purple_conversation_write = void function(PurpleConversation* conv, const(char)* who, const(char)* message, PurpleMessageFlags flags, time_t mtime);																																																						/* da_purple_conversation_write purple_conversation_write; */
alias da_purple_conversation_set_features = void function(PurpleConversation* conv, PurpleConnectionFlags features);																																																						/* da_purple_conversation_set_features purple_conversation_set_features; */
alias da_purple_conversation_get_features = PurpleConnectionFlags function(PurpleConversation* conv);																																																						/* da_purple_conversation_get_features purple_conversation_get_features; */
alias da_purple_conversation_has_focus = gboolean function(PurpleConversation* conv);																																																						/* da_purple_conversation_has_focus purple_conversation_has_focus; */
alias da_purple_conversation_update = void function(PurpleConversation* conv, PurpleConvUpdateType type);																																																						/* da_purple_conversation_update purple_conversation_update; */
alias da_purple_conversation_foreach = void function(void function (PurpleConversation*) func);																																																						/* da_purple_conversation_foreach purple_conversation_foreach; */
alias da_purple_conversation_get_message_history = GList* function(PurpleConversation* conv);																																																						/* da_purple_conversation_get_message_history purple_conversation_get_message_history; */
alias da_purple_conversation_clear_message_history = void function(PurpleConversation* conv);																																																						/* da_purple_conversation_clear_message_history purple_conversation_clear_message_history; */
alias da_purple_conversation_message_get_sender = const(char)* function(PurpleConvMessage* msg);																																																						/* da_purple_conversation_message_get_sender purple_conversation_message_get_sender; */
alias da_purple_conversation_message_get_message = const(char)* function(PurpleConvMessage* msg);																																																						/* da_purple_conversation_message_get_message purple_conversation_message_get_message; */
alias da_purple_conversation_message_get_flags = PurpleMessageFlags function(PurpleConvMessage* msg);																																																						/* da_purple_conversation_message_get_flags purple_conversation_message_get_flags; */
alias da_purple_conversation_message_get_timestamp = time_t function(PurpleConvMessage* msg);																																																						/* da_purple_conversation_message_get_timestamp purple_conversation_message_get_timestamp; */
alias da_purple_conv_im_get_conversation = PurpleConversation* function(const(PurpleConvIm)* im);																																																						/* da_purple_conv_im_get_conversation purple_conv_im_get_conversation; */
alias da_purple_conv_im_set_icon = void function(PurpleConvIm* im, PurpleBuddyIcon* icon);																																																						/* da_purple_conv_im_set_icon purple_conv_im_set_icon; */
alias da_purple_conv_im_get_icon = PurpleBuddyIcon* function(const(PurpleConvIm)* im);																																																						/* da_purple_conv_im_get_icon purple_conv_im_get_icon; */
alias da_purple_conv_im_set_typing_state = void function(PurpleConvIm* im, PurpleTypingState state);																																																						/* da_purple_conv_im_set_typing_state purple_conv_im_set_typing_state; */
alias da_purple_conv_im_get_typing_state = PurpleTypingState function(const(PurpleConvIm)* im);																																																						/* da_purple_conv_im_get_typing_state purple_conv_im_get_typing_state; */
alias da_purple_conv_im_start_typing_timeout = void function(PurpleConvIm* im, int timeout);																																																						/* da_purple_conv_im_start_typing_timeout purple_conv_im_start_typing_timeout; */
alias da_purple_conv_im_stop_typing_timeout = void function(PurpleConvIm* im);																																																						/* da_purple_conv_im_stop_typing_timeout purple_conv_im_stop_typing_timeout; */
alias da_purple_conv_im_get_typing_timeout = guint function(const(PurpleConvIm)* im);																																																						/* da_purple_conv_im_get_typing_timeout purple_conv_im_get_typing_timeout; */
alias da_purple_conv_im_set_type_again = void function(PurpleConvIm* im, uint val);																																																						/* da_purple_conv_im_set_type_again purple_conv_im_set_type_again; */
alias da_purple_conv_im_get_type_again = time_t function(const(PurpleConvIm)* im);																																																						/* da_purple_conv_im_get_type_again purple_conv_im_get_type_again; */
alias da_purple_conv_im_start_send_typed_timeout = void function(PurpleConvIm* im);																																																						/* da_purple_conv_im_start_send_typed_timeout purple_conv_im_start_send_typed_timeout; */
alias da_purple_conv_im_stop_send_typed_timeout = void function(PurpleConvIm* im);																																																						/* da_purple_conv_im_stop_send_typed_timeout purple_conv_im_stop_send_typed_timeout; */
alias da_purple_conv_im_get_send_typed_timeout = guint function(const(PurpleConvIm)* im);																																																						/* da_purple_conv_im_get_send_typed_timeout purple_conv_im_get_send_typed_timeout; */
alias da_purple_conv_im_update_typing = void function(PurpleConvIm* im);																																																						/* da_purple_conv_im_update_typing purple_conv_im_update_typing; */
alias da_purple_conv_im_write = void function(PurpleConvIm* im, const(char)* who, const(char)* message, PurpleMessageFlags flags, time_t mtime);																																																						/* da_purple_conv_im_write purple_conv_im_write; */
alias da_purple_conv_present_error = gboolean function(const(char)* who, PurpleAccount* account, const(char)* what);																																																						/* da_purple_conv_present_error purple_conv_present_error; */
alias da_purple_conv_im_send = void function(PurpleConvIm* im, const(char)* message);																																																						/* da_purple_conv_im_send purple_conv_im_send; */
alias da_purple_conv_send_confirm = void function(PurpleConversation* conv, const(char)* message);																																																						/* da_purple_conv_send_confirm purple_conv_send_confirm; */
alias da_purple_conv_im_send_with_flags = void function(PurpleConvIm* im, const(char)* message, PurpleMessageFlags flags);																																																						/* da_purple_conv_im_send_with_flags purple_conv_im_send_with_flags; */
alias da_purple_conv_custom_smiley_add = gboolean function(PurpleConversation* conv, const(char)* smile, const(char)* cksum_type, const(char)* chksum, gboolean remote);																																																						/* da_purple_conv_custom_smiley_add purple_conv_custom_smiley_add; */
alias da_purple_conv_custom_smiley_write = void function(PurpleConversation* conv, const(char)* smile, const(guchar)* data, gsize size);																																																						/* da_purple_conv_custom_smiley_write purple_conv_custom_smiley_write; */
alias da_purple_conv_custom_smiley_close = void function(PurpleConversation* conv, const(char)* smile);																																																						/* da_purple_conv_custom_smiley_close purple_conv_custom_smiley_close; */
alias da_purple_conv_chat_get_conversation = PurpleConversation* function(const(PurpleConvChat)* chat);																																																						/* da_purple_conv_chat_get_conversation purple_conv_chat_get_conversation; */
alias da_purple_conv_chat_set_users = GList* function(PurpleConvChat* chat, GList* users);																																																						/* da_purple_conv_chat_set_users purple_conv_chat_set_users; */
alias da_purple_conv_chat_get_users = GList* function(const(PurpleConvChat)* chat);																																																						/* da_purple_conv_chat_get_users purple_conv_chat_get_users; */
alias da_purple_conv_chat_ignore = void function(PurpleConvChat* chat, const(char)* name);																																																						/* da_purple_conv_chat_ignore purple_conv_chat_ignore; */
alias da_purple_conv_chat_unignore = void function(PurpleConvChat* chat, const(char)* name);																																																						/* da_purple_conv_chat_unignore purple_conv_chat_unignore; */
alias da_purple_conv_chat_set_ignored = GList* function(PurpleConvChat* chat, GList* ignored);																																																						/* da_purple_conv_chat_set_ignored purple_conv_chat_set_ignored; */
alias da_purple_conv_chat_get_ignored = GList* function(const(PurpleConvChat)* chat);																																																						/* da_purple_conv_chat_get_ignored purple_conv_chat_get_ignored; */
alias da_purple_conv_chat_get_ignored_user = const(char)* function(const(PurpleConvChat)* chat, const(char)* user);																																																						/* da_purple_conv_chat_get_ignored_user purple_conv_chat_get_ignored_user; */
alias da_purple_conv_chat_is_user_ignored = gboolean function(const(PurpleConvChat)* chat, const(char)* user);																																																						/* da_purple_conv_chat_is_user_ignored purple_conv_chat_is_user_ignored; */
alias da_purple_conv_chat_set_topic = void function(PurpleConvChat* chat, const(char)* who, const(char)* topic);																																																						/* da_purple_conv_chat_set_topic purple_conv_chat_set_topic; */
alias da_purple_conv_chat_get_topic = const(char)* function(const(PurpleConvChat)* chat);																																																						/* da_purple_conv_chat_get_topic purple_conv_chat_get_topic; */
alias da_purple_conv_chat_set_id = void function(PurpleConvChat* chat, int id);																																																						/* da_purple_conv_chat_set_id purple_conv_chat_set_id; */
alias da_purple_conv_chat_get_id = int function(const(PurpleConvChat)* chat);																																																						/* da_purple_conv_chat_get_id purple_conv_chat_get_id; */
alias da_purple_conv_chat_write = void function(PurpleConvChat* chat, const(char)* who, const(char)* message, PurpleMessageFlags flags, time_t mtime);																																																						/* da_purple_conv_chat_write purple_conv_chat_write; */
alias da_purple_conv_chat_send = void function(PurpleConvChat* chat, const(char)* message);																																																						/* da_purple_conv_chat_send purple_conv_chat_send; */
alias da_purple_conv_chat_send_with_flags = void function(PurpleConvChat* chat, const(char)* message, PurpleMessageFlags flags);																																																						/* da_purple_conv_chat_send_with_flags purple_conv_chat_send_with_flags; */
alias da_purple_conv_chat_add_user = void function(PurpleConvChat* chat, const(char)* user, const(char)* extra_msg, PurpleConvChatBuddyFlags flags, gboolean new_arrival);																																																						/* da_purple_conv_chat_add_user purple_conv_chat_add_user; */
alias da_purple_conv_chat_add_users = void function(PurpleConvChat* chat, GList* users, GList* extra_msgs, GList* flags, gboolean new_arrivals);																																																						/* da_purple_conv_chat_add_users purple_conv_chat_add_users; */
alias da_purple_conv_chat_rename_user = void function(PurpleConvChat* chat, const(char)* old_user, const(char)* new_user);																																																						/* da_purple_conv_chat_rename_user purple_conv_chat_rename_user; */
alias da_purple_conv_chat_remove_user = void function(PurpleConvChat* chat, const(char)* user, const(char)* reason);																																																						/* da_purple_conv_chat_remove_user purple_conv_chat_remove_user; */
alias da_purple_conv_chat_remove_users = void function(PurpleConvChat* chat, GList* users, const(char)* reason);																																																						/* da_purple_conv_chat_remove_users purple_conv_chat_remove_users; */
alias da_purple_conv_chat_find_user = gboolean function(PurpleConvChat* chat, const(char)* user);																																																						/* da_purple_conv_chat_find_user purple_conv_chat_find_user; */
alias da_purple_conv_chat_user_set_flags = void function(PurpleConvChat* chat, const(char)* user, PurpleConvChatBuddyFlags flags);																																																						/* da_purple_conv_chat_user_set_flags purple_conv_chat_user_set_flags; */
alias da_purple_conv_chat_user_get_flags = PurpleConvChatBuddyFlags function(PurpleConvChat* chat, const(char)* user);																																																						/* da_purple_conv_chat_user_get_flags purple_conv_chat_user_get_flags; */
alias da_purple_conv_chat_clear_users = void function(PurpleConvChat* chat);																																																						/* da_purple_conv_chat_clear_users purple_conv_chat_clear_users; */
alias da_purple_conv_chat_set_nick = void function(PurpleConvChat* chat, const(char)* nick);																																																						/* da_purple_conv_chat_set_nick purple_conv_chat_set_nick; */
alias da_purple_conv_chat_get_nick = const(char)* function(PurpleConvChat* chat);																																																						/* da_purple_conv_chat_get_nick purple_conv_chat_get_nick; */
alias da_purple_find_chat = PurpleConversation* function(const(PurpleConnection)* gc, int id);																																																						/* da_purple_find_chat purple_find_chat; */
alias da_purple_conv_chat_left = void function(PurpleConvChat* chat);																																																						/* da_purple_conv_chat_left purple_conv_chat_left; */
alias da_purple_conv_chat_invite_user = void function(PurpleConvChat* chat, const(char)* user, const(char)* message, gboolean confirm);																																																						/* da_purple_conv_chat_invite_user purple_conv_chat_invite_user; */
alias da_purple_conv_chat_has_left = gboolean function(PurpleConvChat* chat);																																																						/* da_purple_conv_chat_has_left purple_conv_chat_has_left; */
alias da_purple_conv_chat_cb_new = PurpleConvChatBuddy* function(const(char)* name, const(char)* alias_, PurpleConvChatBuddyFlags flags);																																																						/* da_purple_conv_chat_cb_new purple_conv_chat_cb_new; */
alias da_purple_conv_chat_cb_find = PurpleConvChatBuddy* function(PurpleConvChat* chat, const(char)* name);																																																						/* da_purple_conv_chat_cb_find purple_conv_chat_cb_find; */
alias da_purple_conv_chat_cb_get_name = const(char)* function(PurpleConvChatBuddy* cb);																																																						/* da_purple_conv_chat_cb_get_name purple_conv_chat_cb_get_name; */
alias da_purple_conv_chat_cb_destroy = void function(PurpleConvChatBuddy* cb);																																																						/* da_purple_conv_chat_cb_destroy purple_conv_chat_cb_destroy; */
alias da_purple_conversation_get_extended_menu = GList* function(PurpleConversation* conv);																																																						/* da_purple_conversation_get_extended_menu purple_conversation_get_extended_menu; */
alias da_purple_conversation_do_command = gboolean function(PurpleConversation* conv, const(gchar)* cmdline, const(gchar)* markup, gchar** error);																																																						/* da_purple_conversation_do_command purple_conversation_do_command; */
alias da_purple_conversations_get_handle = void* function();																																																						/* da_purple_conversations_get_handle purple_conversations_get_handle; */
alias da_purple_conversations_init = void function();																																																						/* da_purple_conversations_init purple_conversations_init; */
alias da_purple_conversations_uninit = void function();																																																						/* da_purple_conversations_uninit purple_conversations_uninit; */


extern( C ) nothrow 
{
	
}

__gshared
{
	
}